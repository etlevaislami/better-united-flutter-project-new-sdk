// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_bet_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MatchBetResponse _$MatchBetResponseFromJson(Map<String, dynamic> json) =>
    MatchBetResponse(
      json['matchBetName'] as String,
      (json['matchBetOdds'] as num).toDouble(),
    );

Map<String, dynamic> _$MatchBetResponseToJson(MatchBetResponse instance) =>
    <String, dynamic>{
      'matchBetName': instance.matchBetName,
      'matchBetOdds': instance.matchBetOdds,
    };
