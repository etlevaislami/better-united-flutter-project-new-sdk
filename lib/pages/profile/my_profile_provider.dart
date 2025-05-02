import 'package:flutter/widgets.dart';
import 'package:flutter_better_united/data/repo/profile_repository.dart';

import '../../data/model/filter_criteria.dart';
import '../../data/model/reward_level.dart';
import '../../util/ui_util.dart';
import '../shop/user_provider.dart';

class MyProfileProvider with ChangeNotifier {
  final int userId;
  late final FilterCriteria activeFilterCriteria;
  late final FilterCriteria historyFilterCriteria;
  final UserProvider _userProvider;
  final ProfileRepository _profileRepository;
  List<RewardLevel> levels = [];
  List<int>? favoriteTeamIds;

  MyProfileProvider(
    this._userProvider,
    this._profileRepository, {
    required this.userId,
  }) {
    activeFilterCriteria = FilterCriteria(userId: userId, onlyActive: true);
    historyFilterCriteria = FilterCriteria(userId: userId, onlyHistory: true);
  }

  syncUserProfile() async {
    await _userProvider.syncUserProfile();
    favoriteTeamIds =
        _userProvider.user?.favoriteTeams.map((e) => e.id).toList();
  }

  fetchLevels() async {
    levels = await _profileRepository.getLevelRewards();
    notifyListeners();
  }

  claimReward(RewardLevel rewardLevel) async {
    try {
      beginLoading();
      await _profileRepository.claimReward(rewardLevel.id);
      _userProvider.syncUserProfile();
      rewardLevel.isClaimed = true;
      //force refresh
      levels = List.of(levels);
      notifyListeners();
    } catch (exception) {
      showGenericError(exception);
      rethrow;
    } finally {
      endLoading();
    }
  }
}
