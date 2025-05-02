import 'package:json_annotation/json_annotation.dart';

part 'prediction_counters_response.g.dart';

@JsonSerializable()
class PredictionCountersResponse {
  final int totalPredictions;
  final int totalPredictionsWon;
  final int totalPredictionsLost;

  factory PredictionCountersResponse.fromJson(Map<String, dynamic> json) {
    return _$PredictionCountersResponseFromJson(json);
  }

  PredictionCountersResponse(this.totalPredictions, this.totalPredictionsWon,
      this.totalPredictionsLost);

  Map<String, dynamic> toJson() => _$PredictionCountersResponseToJson(this);
}
