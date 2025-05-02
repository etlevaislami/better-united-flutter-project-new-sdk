// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'league_detail_football_league_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeagueDetailFootballLeagueResponse _$LeagueDetailFootballLeagueResponseFromJson(
        Map<String, dynamic> json) =>
    LeagueDetailFootballLeagueResponse(
      (json['leagueId'] as num).toInt(),
      json['leagueName'] as String,
      json['leagueLogoUrl'] as String?,
    );

Map<String, dynamic> _$LeagueDetailFootballLeagueResponseToJson(
        LeagueDetailFootballLeagueResponse instance) =>
    <String, dynamic>{
      'leagueId': instance.leagueId,
      'leagueName': instance.leagueName,
      'leagueLogoUrl': instance.leagueLogoUrl,
    };
