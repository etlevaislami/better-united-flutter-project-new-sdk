import 'package:flutter/material.dart';
import 'package:flutter_better_united/data/enum/ranking_type.dart';
import 'package:flutter_better_united/data/model/ranked_participant.dart';
import 'package:flutter_better_united/data/model/ranking_overview.dart';
import 'package:flutter_better_united/data/model/team_of_season.dart';
import 'package:flutter_better_united/data/model/team_of_week.dart';
import 'package:flutter_better_united/data/repo/ranking_repository.dart';
import 'package:flutter_better_united/run.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class RankingProvider with ChangeNotifier {
  final RankingRepository _rankingRepository;

  RankingProvider(this._rankingRepository);

  RankingOverview? rankingOverview;
  RankingType rankingType = RankingType.weekly;

  PagingState<int, RankedParticipant> pagingState =
   PagingState<int, RankedParticipant>(pages: [], keys: [], hasNextPage: true, error: null, isLoading: false);

  bool isRankingsShown = false;

  TeamOfWeek? teamOfWeek;
  TeamOfSeason? teamOfSeason;

  showRankings() {
    isRankingsShown = true;
    notifyListeners();
  }

  hideRankings() {
    isRankingsShown = false;
    notifyListeners();
  }

  Future<List<RankedParticipant>> fetchPage(int pageKey) async {
    final weeklyRankings = await _rankingRepository.getRankings(
      page: pageKey,
      type: rankingType,
    );
    return weeklyRankings.data;
  }

  void updatePagingState(List<List<RankedParticipant>> pages, List<int> keys, bool hasNextPage, [Object? error]) {
    pagingState = PagingState<int, RankedParticipant>(
      pages: pages,
      keys: keys,
      hasNextPage: hasNextPage,
      error: error,
      isLoading: false,
    );
    notifyListeners();
  }

  Future<void> getRankings({required int pageNumber}) async {
    try {
      final weeklyRankings = await _rankingRepository.getRankings(
        page: pageNumber,
        type: rankingType,
      );
      // Build new pages and keys
      final List<List<RankedParticipant>> newPages = List.from(pagingState.pages ?? []);
      final List<int> newKeys = List.from(pagingState.keys ?? []);
      if (pageNumber == 1) {
        newPages.clear();
        newKeys.clear();
      }
      newPages.add(weeklyRankings.data);
      newKeys.add(pageNumber);
      final bool hasNext = !weeklyRankings.isLastPage();
      updatePagingState(newPages, newKeys, hasNext);
    } catch (error) {
      logger.e(error);
      updatePagingState(pagingState.pages ?? [], pagingState.keys ?? [], pagingState.hasNextPage ?? false, error);
    }
  }

  getRankingOverview(RankingType type) async {
    rankingType = type;
    this.rankingOverview = null;
    notifyListeners();
    final rankingOverview =
    await _rankingRepository.getRankingOverview(type: type);
    this.rankingOverview = rankingOverview;
    notifyListeners();
  }

  Future<TeamOfWeek> getTeamOfWeek() async {
    return _rankingRepository.getTeamOfWeek();
  }

  Future<TeamOfSeason> getTeamOfSeason() async {
    return _rankingRepository.getTeamOfSeason();
  }

  fetchTeamOfWeekANdSeason() async {
    final teamOfWeek = await _rankingRepository.getTeamOfWeek();
    final teamOfSeason = await _rankingRepository.getTeamOfSeason();

    this.teamOfWeek = teamOfWeek;
    this.teamOfSeason = teamOfSeason;

    notifyListeners();
  }

  checkUnClaimedTeamOfWeekRewards(
      {required Function(TeamOfWeek teamOfWeek) unClaimedWeeklyRewardsCallback}) async {

    final teamOfWeek = await _rankingRepository.getTeamOfWeek();
    unClaimedWeeklyRewardsCallback(teamOfWeek);
  }

  checkUnClaimedTeamOfSeasonRewards(
      {required Function(TeamOfSeason teamOfSeason)
      unClaimedSeasonalRewardsCallback}) async {
    final teamOfSeason = await _rankingRepository.getTeamOfSeason();
    unClaimedSeasonalRewardsCallback(teamOfSeason);
  }

  Future<void> claimTeamOfWeekReward() async {
    await _rankingRepository.claimWeekRankingReward();
  }

  Future<void> claimTeamOfSeasonReward() async {
    await _rankingRepository.claimTeamOfSeasonReward();
  }
}
