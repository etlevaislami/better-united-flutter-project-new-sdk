// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'matches_by_league_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MatchesByLeagueResponse _$MatchesByLeagueResponseFromJson(
        Map<String, dynamic> json) =>
    MatchesByLeagueResponse(
      (json['leagueId'] as num).toInt(),
      json['leagueName'] as String,
      json['leagueLogoUrl'] as String?,
      (json['matches'] as List<dynamic>)
          .map((e) => MatchResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MatchesByLeagueResponseToJson(
        MatchesByLeagueResponse instance) =>
    <String, dynamic>{
      'leagueId': instance.leagueId,
      'leagueName': instance.leagueName,
      'leagueLogoUrl': instance.leagueLogoUrl,
      'matches': instance.matches,
    };
