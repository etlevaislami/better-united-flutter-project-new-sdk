import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../data/model/filter_criteria.dart';
import '../../data/model/tip.dart';
import '../../data/repo/tip_repository.dart';
import '../../run.dart';
import '../shop/user_provider.dart';

class TipProvider with ChangeNotifier {
  FilterCriteria filterCriteria;
  PagingState<int, TipDetail> pagingState = const PagingState<int, TipDetail>();
  final TipRepository _tipRepository;
  final UserProvider _userProvider;
  final Duration minimumDelay = const Duration(milliseconds: 2000);
  int totalItemCount = 0;

  TipProvider(this._tipRepository, this._userProvider,
      {required this.filterCriteria});

  clearTips() {
    pagingState = const PagingState<int, TipDetail>();
  }

  updateFilterCriteria(FilterCriteria filterCriteria) {
    this.filterCriteria = filterCriteria;
    clearTips();
    notifyListeners();
    getTips(pageNumber: 1);
  }

  getTips({required int pageNumber}) async {
    try {
      final paginatedTips = await _tipRepository.getTips(
          date: filterCriteria.matchDay,
          leagueId: filterCriteria.leagueId,
          onlyFollowing: filterCriteria.onlyFollowing,
          searchTerm: filterCriteria.searchQuery,
          sortType: filterCriteria.sortType,
          teamId: filterCriteria.team?.id,
          page: pageNumber,
          friendLeagueId: filterCriteria.friendLeagueId,
          onlyFriendLeagues: filterCriteria.onlyFriendLeagues,
          onlyActive: filterCriteria.onlyActive,
          userId: filterCriteria.userId,
          onlyHistory: filterCriteria.onlyHistory,
          onlyMine: filterCriteria.onlyMine,
          onlyOthers: filterCriteria.onlyOthers,
          publicLeagueId: filterCriteria.publicLeagueId);

      if (pagingState.nextPageKey == null) {
        pagingState.itemList?.clear();
      }

      final previousItems = pagingState.itemList ?? [];
      final itemList = previousItems + paginatedTips.data;
      pagingState = PagingState<int, TipDetail>(
        itemList: itemList,
        error: null,
        nextPageKey: paginatedTips.isLastPage() ? null : pageNumber + 1,
      );
      totalItemCount = paginatedTips.totalItemCount;
      notifyListeners();
    } catch (error) {
      pagingState = PagingState<int, TipDetail>(
        itemList: pagingState.itemList,
        error: error,
        nextPageKey: pagingState.nextPageKey,
      );
      notifyListeners();
    }
  }

  _refreshTip() {
    pagingState = PagingState(
        nextPageKey: pagingState.nextPageKey,
        itemList: List.of(pagingState.itemList ?? []),
        error: pagingState.error);
    notifyListeners();
  }

  refreshTips() {
    pagingState = const PagingState<int, TipDetail>();
    notifyListeners();
    getTips(pageNumber: 1);
  }

  updateFollowingStatus(int userId, bool isFollowing) {
    pagingState.itemList
        ?.where((element) => element.userId == userId)
        .forEach((tipDetail) {
      tipDetail.isFollowingAuthor = isFollowing;
    });
    _refreshTip();
  }

  revealTip(TipDetail tip) async {
    final Stopwatch stopwatch = Stopwatch();
    try {
      _refreshTip();
      stopwatch.start();
      await _tipRepository.revealTip(tip.id);
      _userProvider.syncUserProfile();
      final elapsedTime = stopwatch.elapsed;
      logger.i("elapsed time $elapsedTime");
      if (elapsedTime < minimumDelay) {
        await Future.delayed(Duration(
            milliseconds:
                minimumDelay.inMilliseconds - elapsedTime.inMilliseconds));
      }
      _refreshTip();
      await Future.delayed(minimumDelay);
      _refreshTip();
    } catch (e) {
      logger.e(e);
      _refreshTip();
      rethrow;
    } finally {
      stopwatch.stop();
    }
  }

  toggleLike(TipDetail tip) {
    if (!tip.isOwn) {
      return;
    }
    _refreshTip();
  }
}
