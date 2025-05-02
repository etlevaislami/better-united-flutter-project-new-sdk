// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'league_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeagueResponse _$LeagueResponseFromJson(Map<String, dynamic> json) =>
    LeagueResponse(
      (json['id'] as num).toInt(),
      json['name'] as String?,
      json['logoUrl'] as String?,
      (json['matchCount'] as num).toInt(),
      (json['tipCount'] as num).toInt(),
      json['countryName'] as String,
    );

Map<String, dynamic> _$LeagueResponseToJson(LeagueResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'logoUrl': instance.logoUrl,
      'matchCount': instance.matchCount,
      'tipCount': instance.tipCount,
      'countryName': instance.countryName,
    };
