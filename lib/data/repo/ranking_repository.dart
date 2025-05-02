import 'package:flutter_better_united/data/enum/ranking_type.dart';
import 'package:flutter_better_united/data/model/paginated_list.dart';
import 'package:flutter_better_united/data/model/ranked_participant.dart';
import 'package:flutter_better_united/data/model/team_of_season.dart';
import 'package:flutter_better_united/data/model/team_of_week.dart';
import 'package:flutter_better_united/data/net/api_service.dart';
import 'package:flutter_better_united/data/net/models/ranking_overview_response.dart';
import 'package:flutter_better_united/data/net/models/rankings_response.dart';
import 'package:flutter_better_united/data/net/models/team_of_season_response.dart';
import 'package:flutter_better_united/data/net/models/team_of_week_response.dart';

import '../model/ranking_overview.dart';

class RankingRepository {
  final ApiService _apiService;

  RankingRepository({required ApiService apiService})
      : _apiService = apiService;

  Future<PaginatedList<RankedParticipant>> getRankings(
      {required int page, required RankingType type}) async {
    late final RankingsResponse response;
    if (type == RankingType.weekly) {
      response = await _apiService.getWeeklyRankings(page);
    } else if (type == RankingType.seasonal) {
      response = await _apiService.getSeasonalRankings(page);
    } else {
      throw Exception('Invalid ranking type');
    }
    final ranks = response.data
        .map((e) => RankedParticipant.fromRankedParticipantResponse(e))
        .toList();
    return PaginatedList(ranks, response.totalPages, response.currentPage, 0);
  }

  Future<RankingOverview> getRankingOverview(
      {required RankingType type}) async {
    late final RankingOverviewResponse response;
    if (type == RankingType.weekly) {
      response = await _apiService.getWeeklyRankingOverview();
    } else if (type == RankingType.seasonal) {
      response = await _apiService.getSeasonalRankingOverview();
    } else {
      throw Exception('Invalid ranking type');
    }

    return RankingOverview.fromWeeklyRankingResponse(response);
  }

  Future<TeamOfWeek> getTeamOfWeek() async {
    final teamOfWeekResponse = await _apiService.getTeamOfWeek();
    return TeamOfWeek.fromTeamOfWeekResponse(teamOfWeekResponse);
  }

  Future<TeamOfSeason> getTeamOfSeason() async {
    final teamOfSeasonResponse = await _apiService.getTeamOfSeason();
    return TeamOfSeason.fromTeamOfSeasonResponse(teamOfSeasonResponse);
  }

  Future claimWeekRankingReward() async {
    return await _apiService.claimWeekRankingReward();
  }

  Future claimTeamOfSeasonReward() async {
    return await _apiService.claimSeasonalRankingReward();
  }
}
