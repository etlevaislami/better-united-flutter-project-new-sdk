// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tip_revealed_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TipRevealedDetailResponse _$TipRevealedDetailResponseFromJson(
        Map<String, dynamic> json) =>
    TipRevealedDetailResponse(
      (json['id'] as num).toInt(),
      json['description'] as String?,
      json['finalScore'] as String,
      (json['points'] as num).toInt(),
      TeamResponse.fromJson(json['homeTeam'] as Map<String, dynamic>),
      TeamResponse.fromJson(json['awayTeam'] as Map<String, dynamic>),
      (json['hints'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['pouleIconUrl'] as String?,
      (json['publicLeagueId'] as num?)?.toInt(),
      (json['friendLeagueId'] as num?)?.toInt(),
      json['pouleName'] as String,
    );

Map<String, dynamic> _$TipRevealedDetailResponseToJson(
        TipRevealedDetailResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'finalScore': instance.finalScore,
      'points': instance.points,
      'homeTeam': instance.homeTeam,
      'awayTeam': instance.awayTeam,
      'hints': instance.hints,
      'pouleIconUrl': instance.pouleIconUrl,
      'publicLeagueId': instance.publicLeagueId,
      'friendLeagueId': instance.friendLeagueId,
      'pouleName': instance.pouleName,
    };
