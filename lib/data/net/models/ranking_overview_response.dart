import 'package:flutter_better_united/data/net/models/prediction_counters_response.dart';
import 'package:flutter_better_united/data/net/models/ranked_participant_response.dart';
import 'package:json_annotation/json_annotation.dart';

import '../converters/date_converter.dart';

part 'ranking_overview_response.g.dart';

@JsonSerializable()
@DateTimeConverter()
class RankingOverviewResponse {
  final DateTime startDate;
  final DateTime endDate;
  final PredictionCountersResponse predictionCounters;
  final List<RankedParticipantResponse> data;

  RankingOverviewResponse(
      this.startDate, this.endDate, this.predictionCounters, this.data);

  factory RankingOverviewResponse.fromJson(Map<String, dynamic> json) =>
      _$RankingOverviewResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RankingOverviewResponseToJson(this);
}
