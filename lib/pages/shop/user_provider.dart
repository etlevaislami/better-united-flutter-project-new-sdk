import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/data/enum/poule_type.dart';
import 'package:flutter_better_united/data/model/daily_rewards.dart';
import 'package:flutter_better_united/data/model/poule_reward.dart';
import 'package:flutter_better_united/data/model/unacknowledged_tip.dart';
import 'package:flutter_better_united/data/net/auth_manager.dart';
import 'package:flutter_better_united/data/net/interceptors/error_interceptor.dart';
import 'package:flutter_better_united/data/net/models/nickname_request.dart';
import 'package:flutter_better_united/data/repo/tip_repository.dart';
import 'package:flutter_better_united/util/dialog_manager.dart';
import 'package:flutter_better_united/util/locale_util.dart';
import 'package:flutter_better_united/util/settings.dart';

import '../../data/model/user.dart';
import '../../data/repo/profile_repository.dart';
import '../../run.dart';
import '../../util/ui_util.dart';

class UserProvider with ChangeNotifier {
  final AuthenticatorManager _authenticatorManager;
  final DialogManager _dialogManager;
  final ProfileRepository _profileRepository;
  final TipRepository _tipRepository;
  final Settings _settings;
  final Completer<User> _profileSyncedOnceCompleter = Completer();
  MemoryImage? profilePicture;
  bool isNicknameInUse = false;

  UserProvider(this._authenticatorManager, this._profileRepository,
      this._dialogManager, this._settings, this._tipRepository);

  User? get user {
    return _authenticatorManager.connectedUser;
  }

  set user(User? user) {
    _authenticatorManager.connectedUser = user;
    notifyListeners();
  }

  syncUserProfile() async {
    final user = await _profileRepository.getProfile();
    this.user = user;
    if (!_profileSyncedOnceCompleter.isCompleted) {
      _profileSyncedOnceCompleter.complete(user);
    }
    notifyListeners();
  }

  int get userCoins {
    return user?.coinBalance ?? 0;
  }

  setProfileImage(MemoryImage image) {
    profilePicture = image;
    notifyListeners();
  }

  _uploadProfilePhoto(User user) async {
    if (profilePicture != null) {
      final imageUrl =
          await _profileRepository.uploadProfilePhoto(profilePicture!);
      user.profilePictureUrl = imageUrl;
      profilePicture = null;
    }
  }

  Future updateProfile(String nickname) async {
    final user = _authenticatorManager.connectedUser;
    if (user == null) {
      return;
    }
    try {
      beginLoading();
      await _updateNickname(user, nickname);
      await _uploadProfilePhoto(user);
      _authenticatorManager.connectedUser = user;
      notifyListeners();
    } on ConflictException {
      rethrow;
    } catch (exception) {
      showGenericError(exception);
      rethrow;
    } finally {
      endLoading();
    }
  }

  _updateNickname(User user, String nickname) async {
    try {
      if (nickname != user.nickname) {
        await _profileRepository.setNickname(NicknameRequest(nickname));
        user.nickname = nickname;
      }
      isNicknameInUse = false;
    } on ConflictException {
      isNicknameInUse = true;
      notifyListeners();
      rethrow;
    }
  }

  handleUnacknowledgedTips(Function(UnacknowledgedTip) callback) async {
    final ids = await _tipRepository.getUnacknowledgedTips();
    for (int index = 0; index < ids.length; index++) {
      final id = ids[index];
      final tipDetail = await _tipRepository.getRevealedTipDetail(id.id);
      final rewards = await _tipRepository.getRewards(id.id);
      final unclaimedTip = UnacknowledgedTip(tipDetail, rewards);
      callback.call(unclaimedTip);
    }
  }

  handleUnacknowledgedPoulesRewards(Function(PouleReward) callback) async {
    final multipleIds =
        await _profileRepository.getUnacknowledgedPoulesRewards();
    final publicIds = multipleIds.publicPoules;
    final friendPouleIds = multipleIds.friendPoules;
    logger.e("handleUnacknowledgedPoulesRewards");

    for (int index = 0; index < publicIds.length; index++) {
      final id = publicIds[index];
      try {
        final pouleReward =
            await _profileRepository.getPoulesRewards(id, PouleType.public);
        callback.call(pouleReward);
      } catch (e) {
        logger.e("Error getting poule reward");
      }
    }

    for (int index = 0; index < friendPouleIds.length; index++) {
      final id = friendPouleIds[index];
      try {
        final pouleReward =
            await _profileRepository.getPoulesRewards(id, PouleType.friend);
        callback.call(pouleReward);
      } catch (e) {
        logger.e("Error getting poule reward");
      }
    }
  }

  Future<PouleReward> getPouleReward(int pouleId, PouleType pouleType) {
    return _profileRepository.getPoulesRewards(pouleId, pouleType);
  }

  Future acknowledgePouleReward(int id, PouleType pouleType) async {
    await _profileRepository.acknowledgePouleReward(id, pouleType);
  }

  Future<String?> _getDeviceId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor;
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id;
    }
    return null;
  }

  Future<String?> _getPushToken() {
    return FirebaseMessaging.instance.getToken();
  }

  syncPushToken() async {
    final pushToken = await _getPushToken();
    if (pushToken != null && _settings.pushToken != pushToken) {
      logger.i("Push Token requires an update $pushToken");
      final deviceId = await _getDeviceId();
      if (deviceId != null) {
        await _profileRepository.updatePushToken(
            deviceId: deviceId, pushToken: pushToken);
        _settings.updatePushToken(pushToken);
        logger.i("push token synced with API");
      }
    } else {
      logger.i("push token syncing not required $pushToken");
      debugPrint(pushToken);
    }
  }

  Future clearRemotePushToken() async {
    final deviceId = await _getDeviceId();
    if (deviceId != null) {
      await _profileRepository.updatePushToken(
          deviceId: deviceId, pushToken: "");
      logger.i("push token cleared");
    }
  }

  syncUserLanguage(Locale deviceLocale) async {
    // wait for profile to sync
    final user = await _profileSyncedOnceCompleter.future;
    if (user.languageId != getLanguageIdByLocale(deviceLocale)) {
      logger.i("syncing language with API");
      updateRemoteLanguage(deviceLocale);
    }
  }

  Future<void> updateRemoteLanguage(Locale locale) {
    return _profileRepository.setLanguage(locale);
  }

  Future<void> handleUserDailyRewards(Function(DailyRewards) callback) async {
    // wait for profile to sync
    await _profileSyncedOnceCompleter.future;
    final dailyRewards = await _profileRepository.getDailyRewards();
    if (dailyRewards != null) {
      callback.call(dailyRewards);
    }
  }

  addUserCoins(int coins) {
    final user = this.user;
    user?.coinBalance = user.coinBalance + coins;
    this.user = user;
  }

  removeUserCoins(int coins) {
    final user = this.user;
    user?.coinBalance = user.coinBalance - coins;
    this.user = user;
  }

  Future<void> claimReward({required int coins}) async {
    await _profileRepository.claimDailyReward();
    addUserCoins(coins);
  }
}
