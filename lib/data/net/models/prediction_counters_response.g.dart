// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prediction_counters_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PredictionCountersResponse _$PredictionCountersResponseFromJson(
        Map<String, dynamic> json) =>
    PredictionCountersResponse(
      (json['totalPredictions'] as num).toInt(),
      (json['totalPredictionsWon'] as num).toInt(),
      (json['totalPredictionsLost'] as num).toInt(),
    );

Map<String, dynamic> _$PredictionCountersResponseToJson(
        PredictionCountersResponse instance) =>
    <String, dynamic>{
      'totalPredictions': instance.totalPredictions,
      'totalPredictionsWon': instance.totalPredictionsWon,
      'totalPredictionsLost': instance.totalPredictionsLost,
    };
