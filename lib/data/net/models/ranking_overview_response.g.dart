// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ranking_overview_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RankingOverviewResponse _$RankingOverviewResponseFromJson(
        Map<String, dynamic> json) =>
    RankingOverviewResponse(
      const DateTimeConverter().fromJson(json['startDate'] as String),
      const DateTimeConverter().fromJson(json['endDate'] as String),
      PredictionCountersResponse.fromJson(
          json['predictionCounters'] as Map<String, dynamic>),
      (json['data'] as List<dynamic>)
          .map((e) =>
              RankedParticipantResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RankingOverviewResponseToJson(
        RankingOverviewResponse instance) =>
    <String, dynamic>{
      'startDate': const DateTimeConverter().toJson(instance.startDate),
      'endDate': const DateTimeConverter().toJson(instance.endDate),
      'predictionCounters': instance.predictionCounters,
      'data': instance.data,
    };
