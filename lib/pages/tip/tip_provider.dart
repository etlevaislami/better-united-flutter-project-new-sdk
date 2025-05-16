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
      pagingState = pagingState.copyWith(isLoading: true);
      notifyListeners();

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

      final List<List<TipDetail>> currentPages = List<List<TipDetail>>.from(pagingState.pages ?? []);
      final List<int> currentKeys = List<int>.from(pagingState.keys ?? []);

      if (pageNumber == 1) {
        currentPages.clear();
        currentKeys.clear();
      }

      currentPages.add(paginatedTips.data);
      currentKeys.add(pageNumber);

      pagingState = PagingState<int, TipDetail>(
        pages: currentPages,
        keys: currentKeys,
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
    List<List<TipDetail>>? newPages;
    if (pagingState.pages != null) {
      newPages = [];
      for (var page in pagingState.pages!) {
        newPages.add(List.of(page));
      }
    }

    pagingState = PagingState(
        pages: newPages,
        keys: pagingState.keys != null ? List.of(pagingState.keys!) : null,
        error: pagingState.error,
        hasNextPage: pagingState.hasNextPage,
        isLoading: pagingState.isLoading);
    notifyListeners();
  }

  refreshTips() {
    pagingState = PagingState<int, TipDetail>();
    notifyListeners();
    getTips(pageNumber: 1);
  }

  updateFollowingStatus(int userId, bool isFollowing) {
    if (pagingState.pages != null) {
      for (var page in pagingState.pages!) {
        for (var tipDetail in page) {
          if (tipDetail.userId == userId) {
            tipDetail.isFollowingAuthor = isFollowing;
          }
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