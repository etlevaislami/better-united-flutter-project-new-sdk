import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../data/model/filter_criteria.dart';
import '../../data/model/tip.dart';
import '../../data/repo/tip_repository.dart';
import '../../run.dart';
import '../shop/user_provider.dart';

class TipProvider with ChangeNotifier {
  FilterCriteria filterCriteria;
  PagingState<int, TipDetail> pagingState = PagingState<int, TipDetail>();
  final TipRepository _tipRepository;
  final UserProvider _userProvider;
  final Duration minimumDelay = const Duration(milliseconds: 2000);
  int totalItemCount = 0;

  TipProvider(this._tipRepository, this._userProvider,
      {required this.filterCriteria});

  Future<List<TipDetail>> fetchPage(int pageKey) async {
    await getTips(pageNumber: pageKey);
    final pages = pagingState.pages;
    if (pages != null && pages.isNotEmpty) {
      return pages.last;
    }
    return <TipDetail>[];
  }

  clearTips() {
    pagingState = PagingState<int, TipDetail>();
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

      final List<List<TipDetail>> pages = List.from(pagingState.pages ?? []);
      final List<int> keys = List.from(pagingState.keys ?? []);
      if (paginatedTips.data.isNotEmpty) {
        pages.add(paginatedTips.data);
        keys.add(pageNumber);
      }

      pagingState = PagingState<int, TipDetail>(
        pages: pages,
        keys: keys,
        error: null,
        hasNextPage: !paginatedTips.isLastPage(),
        isLoading: false,
      );
      totalItemCount = paginatedTips.totalItemCount;
      notifyListeners();
    } catch (error) {
      pagingState = PagingState<int, TipDetail>(
        pages: pagingState.pages,
        keys: pagingState.keys,
        error: error,
        hasNextPage: pagingState.hasNextPage,
        isLoading: false,
      );
      notifyListeners();
    }
  }

  _refreshTip() {
    pagingState = PagingState<int, TipDetail>(
      pages: List.of(pagingState.pages ?? []),
      keys: List.of(pagingState.keys ?? []),
      error: pagingState.error,
      hasNextPage: pagingState.hasNextPage,
      isLoading: false,
    );
    notifyListeners();
  }

  refreshTips() {
    pagingState = PagingState<int, TipDetail>();
    notifyListeners();
    getTips(pageNumber: 1);
  }

  updateFollowingStatus(int userId, bool isFollowing) {
    for (final page in pagingState.pages ?? []) {
      for (final tipDetail in page) {
        if (tipDetail.userId == userId) {
          tipDetail.isFollowingAuthor = isFollowing;
        }
      }
    }
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
