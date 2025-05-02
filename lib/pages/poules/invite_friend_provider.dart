import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_better_united/data/enum/poule_type.dart';
import 'package:flutter_better_united/data/model/other_user.dart';
import 'package:flutter_better_united/pages/shop/user_provider.dart';
import 'package:flutter_better_united/util/deeplinks/deep_link_manager.dart';
import 'package:flutter_better_united/util/exceptions/custom_exceptions.dart';
import 'package:tuple/tuple.dart';

import '../../data/model/friend.dart';
import '../../data/repo/league_repository.dart';
import '../../data/repo/profile_repository.dart';
import '../../util/friend_compute.dart';
import '../../util/ui_util.dart';

class InviteFriendProvider with ChangeNotifier {
  final int leagueId;
  final PouleType pouleType;
  final String leagueName;
  final int poolPrize;
  final int entryFee;
  final String? leagueIconUrl;
  final LeagueRepository _leagueRepository;
  final ProfileRepository _profileRepository;
  final UserProvider _userProvider;
  final DeepLinkManager _deepLinkManager;
  List<OtherUser> users = [];
  List<OtherUser>? filteredUsers;
  List<Friend> followers = [];
  bool isInviteAllEnabled = true;
  List<Friend>? filteredFollowers;

  InviteFriendProvider(
    this._leagueRepository,
    this._deepLinkManager,
    this._profileRepository,
    this._userProvider, {
    required this.leagueId,
    required this.leagueName,
    required this.pouleType,
    required this.poolPrize,
    required this.leagueIconUrl,
    required this.entryFee,
  });

  Future<List<Friend>> getParticipants() async {
    try {
      final leagueDetail =
          await _leagueRepository.getFriendLeagueDetail(leagueId: leagueId);
      return leagueDetail.userRankings
          .map((participant) => Friend.fromParticipant(participant))
          .toList();
    } catch (e) {
      return [];
    }
  }

  fetchFollowers() async {
    //@todo fix
    final users = (await _profileRepository.getUsers(""))
        .where((element) => element.isLoggedUser == false)
        .toList();
    final joinedUsers = await getParticipants();

    for (var user in users) {
      user.isJoined = joinedUsers.any((element) => element.id == user.id);
    }
    this.users = users;
    followers = users
        .where((user) => user.isFollowed)
        .map(
          (e) => Friend.fromOtherUser(e),
        )
        .toList();
    filteredFollowers = followers;
    filteredUsers = List.of(this.users);
    notifyListeners();
  }

  inviteFriend(Friend friend) async {
    if (friend.isInvited) {
      return;
    }
    friend.isLoading = true;
    notifyListeners();
    try {
      await _leagueRepository.inviteToLeague(
          friendId: friend.id, leagueId: leagueId, type: pouleType);
      friend.isInvited = true;
      users.firstWhere((element) => element.id == friend.id).isInvited = true;
    } finally {
      friend.isLoading = false;
      notifyListeners();
    }
  }

  inviteUser(OtherUser user) async {
    if (user.isInvited) {
      return;
    }
    user.isLoading = true;
    notifyListeners();
    try {
      await _leagueRepository.inviteToLeague(
          friendId: user.id, leagueId: leagueId, type: pouleType);
      user.isInvited = true;
      followers.firstWhere((element) => element.id == user.id).isInvited = true;
    } finally {
      user.isLoading = false;
      notifyListeners();
    }
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
      followers.add(Friend.fromOtherUser(user));
    } finally {
      user.isLoading = false;
      notifyListeners();
    }
  }

  searchFriend(String query) async {
    Tuple2<String, List<Friend>> data = Tuple2(query, followers);
    var result = await compute(filterFriends, data);
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

  inviteAll() async {
    final unInvitedFollowers = followers
        .where(
          (element) => !element.isInvited,
        )
        .toList();
    for (var element in unInvitedFollowers) {
      element.isLoading = true;
      users.firstWhere((user) => user.id == element.id).isLoading = true;
    }
    notifyListeners();
    try {
      await _leagueRepository.inviteAllToLeague(
          leagueId: leagueId, type: pouleType);
    } finally {
      for (var element in unInvitedFollowers) {
        element.isLoading = false;
        element.isInvited = true;
        final user = users.firstWhere((user) => user.id == element.id);
        user.isLoading = false;
        user.isInvited = true;
      }
      isInviteAllEnabled = false;
      notifyListeners();
    }
  }

  acceptInvite(int leagueId, bool isSelfInvite) async {
    if (isSelfInvite) {
      if (pouleType == PouleType.friend) {
        await _leagueRepository.selfInvite(leagueId);
        await _leagueRepository.acceptInvite(leagueId, pouleType);
      } else if (pouleType == PouleType.public) {
        await _leagueRepository.joinPublicLeague(leagueId);
      }
    } else {
      await _leagueRepository.acceptInvite(leagueId, pouleType);
    }
  }

  validateInviteAll() {
    isInviteAllEnabled = followers.any((element) => !element.isInvited);
    notifyListeners();
  }

  declineInvite(int leagueId) async {
    try {
      await _leagueRepository.declineInvite(leagueId, pouleType);
    } on InviteAlreadyAcceptedOrDeclined {
      showError("invitationHandled".tr());
    } on PouleNotFound {
      showError("pouleNotFound".tr());
    } catch (exception) {
      showGenericError(exception);
    }
  }

  Future<Uri?> createInviteReferralLink() async {
    try {
      beginLoading();
      final link = await _deepLinkManager.createLink(LinkType.referral, {
        "leagueId": leagueId.toString(),
        "nickname": _userProvider.user?.nickname ?? "unknown".tr(),
        "leagueName": leagueName,
        "pouleType": pouleType.toString(),
        "poolPrize": poolPrize.toString(),
        "publicLeagueIconUrl": leagueIconUrl,
        "entryFee": entryFee.toString(),
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
