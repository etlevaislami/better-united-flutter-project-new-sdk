// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tip_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TipResponse _$TipResponseFromJson(Map<String, dynamic> json) => TipResponse(
      (json['id'] as num).toInt(),
      (json['appUserId'] as num).toInt(),
      (json['matchId'] as num).toInt(),
      const DateTimeConverter().fromJson(json['createdAt'] as String),
      (json['status'] as num).toInt(),
      (json['matchBetId'] as num).toInt(),
      (json['points'] as num).toInt(),
      (json['friendLeagueId'] as num?)?.toInt(),
      (json['publicLeagueId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TipResponseToJson(TipResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'appUserId': instance.appUserId,
      'matchId': instance.matchId,
      'createdAt': const DateTimeConverter().toJson(instance.createdAt),
      'status': instance.status,
      'matchBetId': instance.matchBetId,
      'points': instance.points,
      'friendLeagueId': instance.friendLeagueId,
      'publicLeagueId': instance.publicLeagueId,
    };
