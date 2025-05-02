import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_better_united/data/model/other_user.dart';
import 'package:flutter_better_united/pages/shop/user_provider.dart';
import 'package:flutter_better_united/util/deeplinks/deep_link_manager.dart';
import 'package:tuple/tuple.dart';

import '../../data/repo/profile_repository.dart';
import '../../util/ui_util.dart';

class FriendsProvider with ChangeNotifier {
  final ProfileRepository _profileRepository;
  final UserProvider _userProvider;
  final DeepLinkManager _deepLinkManager;
  List<OtherUser> users = [];
  List<OtherUser>? filteredUsers;
  List<OtherUser> followers = [];
  List<OtherUser>? filteredFollowers;

  FriendsProvider(
    this._deepLinkManager,
    this._profileRepository,
    this._userProvider,
  );

  fetchFollowers() async {
    //@todo fix
    final users = await _profileRepository.getUsers("");
    this.users = users;
    followers = users.where((user) => user.isFollowed).toList();
    filteredFollowers = followers;
    filteredUsers = List.of(this.users);
    notifyListeners();
  }

  followUser(OtherUser user) async {
    if (user.isFollowed) {
      return;
    }
    user.isLoading = true;
    notifyListeners();
    try {
      await _profileRepository.followUser(user.id);
      user.isFollowed = true;
      followers.add(user);
    } finally {
      user.isLoading = false;
      notifyListeners();
    }
  }

  searchFriend(String query) async {
    Tuple2<String, List<OtherUser>> data = Tuple2(query, followers);
    var result = await compute(filterUsers, data);
    filteredFollowers = result;
    notifyListeners();
  }

  searchUser(String query) async {
    final trimmedQuery = query.toLowerCase().trim();
    filteredUsers = users
        .where((user) => user.nickname.toLowerCase().contains(trimmedQuery))
        .toList();
    notifyListeners();
  }

  clearSearch() {
    filteredUsers = users;
    notifyListeners();
  }

  Future<Uri?> createInviteReferralLink() async {
    try {
      beginLoading();
      final link = await _deepLinkManager.createLink(LinkType.referral, {
        "level": (_userProvider.user?.level ?? 1).toString(),
        "nickname": _userProvider.user?.nickname ?? "unknown".tr(),
        "profilePictureUrl": _userProvider.user?.profilePictureUrl
      });
      return link.shortUrl;
    } catch (exception) {
      showGenericError(exception);
    } finally {
      endLoading();
    }
    return null;
  }
}

List<OtherUser> filterUsers(Tuple2<String, List<OtherUser>> data) {
  final String criteria = data.item1.toLowerCase();
  final List<OtherUser> matches = data.item2;
  return matches
      .where((f) => f.nickname.toLowerCase().contains(criteria))
      .toList();
}
