// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rankings_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RankingsResponse _$RankingsResponseFromJson(Map<String, dynamic> json) =>
    RankingsResponse(
      (json['data'] as List<dynamic>)
          .map((e) =>
              RankedParticipantResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['totalPages'] as num).toInt(),
      (json['currentPage'] as num).toInt(),
    );

Map<String, dynamic> _$RankingsResponseToJson(RankingsResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'totalPages': instance.totalPages,
      'currentPage': instance.currentPage,
    };
