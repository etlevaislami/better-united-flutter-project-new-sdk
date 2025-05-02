// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MatchResponse _$MatchResponseFromJson(Map<String, dynamic> json) =>
    MatchResponse(
      (json['id'] as num).toInt(),
      const DateTimeConverter().fromJson(json['startsAt'] as String),
      TeamResponse.fromJson(json['homeTeam'] as Map<String, dynamic>),
      TeamResponse.fromJson(json['awayTeam'] as Map<String, dynamic>),
      (json['matchBets'] as List<dynamic>)
          .map((e) => MatchBetResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['leagueId'] as num).toInt(),
      (json['hasFavouriteTeam'] as num).toInt(),
      (json['canUserAppBet'] as num).toInt(),
    );

Map<String, dynamic> _$MatchResponseToJson(MatchResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'startsAt': const DateTimeConverter().toJson(instance.startsAt),
      'homeTeam': instance.homeTeam,
      'awayTeam': instance.awayTeam,
      'matchBets': instance.matchBets,
      'leagueId': instance.leagueId,
      'hasFavouriteTeam': instance.hasFavouriteTeam,
      'canUserAppBet': instance.canUserAppBet,
    };

TeamResponse _$TeamResponseFromJson(Map<String, dynamic> json) => TeamResponse(
      (json['id'] as num).toInt(),
      json['name'] as String,
      json['logoUrl'] as String?,
    );

Map<String, dynamic> _$TeamResponseToJson(TeamResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'logoUrl': instance.logoUrl,
    };
