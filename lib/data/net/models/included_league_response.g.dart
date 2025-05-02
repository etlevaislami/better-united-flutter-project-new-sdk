// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'included_league_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IncludedLeagueResponse _$IncludedLeagueResponseFromJson(
        Map<String, dynamic> json) =>
    IncludedLeagueResponse(
      (json['leagueId'] as num).toInt(),
      json['leagueName'] as String?,
      json['leagueLogoUrl'] as String?,
    );

Map<String, dynamic> _$IncludedLeagueResponseToJson(
        IncludedLeagueResponse instance) =>
    <String, dynamic>{
      'leagueId': instance.leagueId,
      'leagueName': instance.leagueName,
      'leagueLogoUrl': instance.leagueLogoUrl,
    };
