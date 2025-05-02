// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_league_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FriendLeagueResponse _$FriendLeagueResponseFromJson(
        Map<String, dynamic> json) =>
    FriendLeagueResponse(
      (json['id'] as num).toInt(),
      json['name'] as String,
      (json['tipCountTotal'] as num?)?.toInt(),
      (json['tipCountLost'] as num?)?.toInt(),
      (json['tipCountWon'] as num?)?.toInt(),
      (json['maximumTipCount'] as num).toInt(),
      (json['userTipCountTotal'] as num).toInt(),
      const DateTimeConverter().fromJson(json['startsAt'] as String),
      const DateTimeConverter().fromJson(json['endsAt'] as String),
      const PouleStatusTypeConverter().fromJson(json['status'] as String),
    );

Map<String, dynamic> _$FriendLeagueResponseToJson(
        FriendLeagueResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'tipCountTotal': instance.tipCountTotal,
      'tipCountLost': instance.tipCountLost,
      'tipCountWon': instance.tipCountWon,
      'maximumTipCount': instance.maximumTipCount,
      'userTipCountTotal': instance.userTipCountTotal,
      'startsAt': const DateTimeConverter().toJson(instance.startsAt),
      'endsAt': const DateTimeConverter().toJson(instance.endsAt),
      'status': const PouleStatusTypeConverter().toJson(instance.status),
    };
