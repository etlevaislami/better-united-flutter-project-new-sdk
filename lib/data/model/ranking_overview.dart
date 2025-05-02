import 'package:flutter_better_united/data/model/ranked_participant.dart';

import '../net/models/ranking_overview_response.dart';

class RankingOverview {
  final DateTime startDate;
  final DateTime endDate;
  final int totalPredictions;
  final int totalPredictionsWon;
  final int totalPredictionsLost;
  final List<RankedParticipant> rankings;

  RankingOverview(
      {required this.startDate,
      required this.endDate,
      required this.totalPredictions,
      required this.totalPredictionsWon,
      required this.totalPredictionsLost,
      required this.rankings});

  RankingOverview.fromWeeklyRankingResponse(RankingOverviewResponse response)
      : startDate = response.startDate,
        endDate = response.endDate,
        totalPredictions = response.predictionCounters.totalPredictions,
        totalPredictionsWon = response.predictionCounters.totalPredictionsWon,
        totalPredictionsLost = response.predictionCounters.totalPredictionsLost,
        rankings = response.data
            .map((e) => RankedParticipant.fromRankedParticipantResponse(e))
            .toList();

  int get daysLeft {
    return endDate.difference(DateTime.now()).inDays;
  }
}
