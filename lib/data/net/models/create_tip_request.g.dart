// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_tip_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateTipRequest _$CreateTipRequestFromJson(Map<String, dynamic> json) =>
    CreateTipRequest(
      (json['matchId'] as num).toInt(),
      (json['matchBetId'] as num).toInt(),
      (json['friendLeagueId'] as num?)?.toInt(),
      (json['publicLeagueId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CreateTipRequestToJson(CreateTipRequest instance) =>
    <String, dynamic>{
      'matchId': instance.matchId,
      'matchBetId': instance.matchBetId,
      'friendLeagueId': instance.friendLeagueId,
      'publicLeagueId': instance.publicLeagueId,
    };
