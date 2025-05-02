// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'football_league_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FootballLeagueResponse _$FootballLeagueResponseFromJson(
        Map<String, dynamic> json) =>
    FootballLeagueResponse(
      (json['id'] as num).toInt(),
      json['leagueName'] as String,
      json['leagueLogoUrl'] as String?,
    );

Map<String, dynamic> _$FootballLeagueResponseToJson(
        FootballLeagueResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'leagueName': instance.leagueName,
      'leagueLogoUrl': instance.leagueLogoUrl,
    };
