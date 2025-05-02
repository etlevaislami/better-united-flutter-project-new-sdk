import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_better_united/data/enum/poule_type.dart';
import 'package:flutter_better_united/data/model/daily_rewards.dart';
import 'package:flutter_better_united/data/model/other_user.dart';
import 'package:flutter_better_united/data/model/poule_reward.dart';
import 'package:flutter_better_united/data/model/reward_level.dart';
import 'package:flutter_better_united/data/net/models/add_favorite_teams_request.dart';
import 'package:flutter_better_united/data/net/models/birthday_request.dart';
import 'package:flutter_better_united/data/net/models/language_request.dart';
import 'package:flutter_better_united/data/net/models/nickname_request.dart';
import 'package:flutter_better_united/data/net/models/push_request.dart';
import 'package:flutter_better_united/util/locale_util.dart';
import 'package:path_provider/path_provider.dart';

import '../model/daily_reward.dart';
import '../model/unacknowledged_poules_rewards.dart';
import '../model/user.dart';
import '../net/api_service.dart';

class ProfileRepository {
  final ApiService _apiService;
  final photoFileName = "profileImage.jpg";

  ProfileRepository(this._apiService);

  Future<void> setNickname(NicknameRequest nicknameRequest) async {
    await _apiService.setNickname(nicknameRequest);
  }

  Future<void> setBirthday(BirthdayRequest birthdayRequest) async {
    await _apiService.setBirthday(birthdayRequest);
  }

  Future<void> setLanguage(Locale locale) async {
    await _apiService
        .setLanguage(LanguageRequest(getLanguageIdByLocale(locale)));
  }

  Future<User> getProfile() async {
    var profile = await _apiService.getProfile();
    User user = User.fromProfileResponse(profile);
    return user;
  }

  Future<String> uploadProfilePhoto(MemoryImage bytes) async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    var file = await File("$tempPath/$photoFileName").writeAsBytes(bytes.bytes);
    final response = await _apiService.uploadProfilePicture(file);
    return response.profilePictureUrl;
  }

  Future<void> followUser(int userId) {
    return _apiService.followUser(userId);
  }

  Future<void> unfollowUser(int userId) {
    return _apiService.unfollowUser(userId);
  }

  Future<void> subscribeToUser(int userId) {
    return _apiService.subscribeUser(userId);
  }

  Future<void> unsubscribeToUser(int userId) {
    return _apiService.unsubscribeUser(userId);
  }

  Future<User> getOtherProfile(int userId) async {
    var profile = await _apiService.getOtherProfile(userId);
    User user = User.fromProfileResponse(profile);
    return user;
  }

  Future updatePushToken(
      {required String deviceId, required String pushToken}) {
    return _apiService.updatePushToken(PushRequest(pushToken, deviceId));
  }

  Future<List<RewardLevel>> getLevelRewards() async {
    final response = await _apiService.getLevelRewards();
    return response
        .map((rewardLevelResponse) =>
            RewardLevel.fromRewardLevelResponse(rewardLevelResponse))
        .toList();
  }

  Future<void> claimReward(int levelId) {
    return _apiService.claimReward(levelId);
  }

  Future<List<OtherUser>> getUsers(String? searchTerm) async {
    final response = await _apiService.getUsers(searchTerm);
    return response
        .map((userResponse) => OtherUser.fromUserResponse(userResponse))
        .toList();
  }

  Future<void> addFavoriteTeams(List<int> teamIds) {
    return _apiService.addFavoriteTeams(AddFavoriteTeamsRequest(teamIds));
  }

  Future<UnacknowledgedPoulesRewards> getUnacknowledgedPoulesRewards() async {
    final response = await _apiService.getUnacknowledgedPoulesRewards();
    return UnacknowledgedPoulesRewards.fromUnacknowledgedPoulesRewardsResponse(
        response);
  }

  Future<PouleReward> getPoulesRewards(int pouleId, PouleType pouleType) async {
    if (pouleType == PouleType.friend) {
      final response = await _apiService.getFriendPouleReward(pouleId);
      return PouleReward.fromFriendPouleRewardResponse(pouleId, response);
    } else if (pouleType == PouleType.public) {
      final response = await _apiService.getPublicPouleReward(pouleId);
      return PouleReward.fromPublicPouleRewardResponse(pouleId, response);
    }
    throw Exception("Invalid poule type");
  }

  Future<void> acknowledgePouleReward(int pouleId, PouleType pouleType) async {
    if (pouleType == PouleType.friend) {
      await _apiService.acknowledgeFriendPouleReward(pouleId);
    } else if (pouleType == PouleType.public) {
      await _apiService.acknowledgePublicPouleReward(pouleId);
    }
  }

  Future<DailyRewards?> getDailyRewards() async {
    final response = await _apiService.getDailyRewards();
    if (!response.isClaimable) {
      return null;
    }
    final rewards = response.rewards;
    final indexOfLastClaimedReward =
        rewards.lastIndexWhere((element) => element.claimed);

    final toBeClaimedReward = DailyReward.fromDailyRewardResponse(
        rewards[indexOfLastClaimedReward + 1],
        isClaimable: true);

    return DailyRewards(
      dayOneReward: DailyReward.fromDailyRewardResponse(rewards[0],
          isClaimable: 0 - indexOfLastClaimedReward == 1),
      dayTwoReward: DailyReward.fromDailyRewardResponse(rewards[1],
          isClaimable: 1 - indexOfLastClaimedReward == 1),
      dayThreeReward: DailyReward.fromDailyRewardResponse(rewards[2],
          isClaimable: 2 - indexOfLastClaimedReward == 1),
      dayFourReward: DailyReward.fromDailyRewardResponse(rewards[3],
          isClaimable: 3 - indexOfLastClaimedReward == 1),
      dayFiveReward: DailyReward.fromDailyRewardResponse(rewards[4],
          isClaimable: 4 - indexOfLastClaimedReward == 1),
      daySixReward: DailyReward.fromDailyRewardResponse(rewards[5],
          isClaimable: 5 - indexOfLastClaimedReward == 1),
      daySevenReward: DailyReward.fromDailyRewardResponse(rewards[6],
          isClaimable: 6 - indexOfLastClaimedReward == 1),
      toBeClaimedDayReward: toBeClaimedReward,
    );
  }

  Future<void> claimDailyReward() async {
    await _apiService.claimDailyReward();
  }
}
