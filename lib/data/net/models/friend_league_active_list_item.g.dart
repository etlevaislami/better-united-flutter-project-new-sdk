// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_league_active_list_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FriendLeagueActivePouleItem _$FriendLeagueActivePouleItemFromJson(
        Map<String, dynamic> json) =>
    FriendLeagueActivePouleItem(
      (json['id'] as num).toInt(),
      json['name'] as String,
      const DateTimeConverter().fromJson(json['startsAt'] as String),
      const DateTimeConverter().fromJson(json['endsAt'] as String),
      const DateTimeConverter().fromJson(json['matchStartsAt'] as String),
      TeamResponse.fromJson(json['homeTeam'] as Map<String, dynamic>),
      TeamResponse.fromJson(json['awayTeam'] as Map<String, dynamic>),
      (json['userCount'] as num).toInt(),
      (json['userRank'] as num?)?.toInt(),
      (json['predictionsRemaining'] as num).toInt(),
      (json['poolPrize'] as num).toInt(),
      json['iconUrl'] as String?,
      (json['entryFee'] as num).toInt(),
      (json['matchId'] as num).toInt(),
      const PouleStatusTypeConverter().fromJson(json['status'] as String),
    );

Map<String, dynamic> _$FriendLeagueActivePouleItemToJson(
        FriendLeagueActivePouleItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'startsAt': const DateTimeConverter().toJson(instance.startsAt),
      'endsAt': const DateTimeConverter().toJson(instance.endsAt),
      'matchStartsAt': const DateTimeConverter().toJson(instance.matchStartsAt),
      'homeTeam': instance.homeTeam,
      'awayTeam': instance.awayTeam,
      'userCount': instance.userCount,
      'userRank': instance.userRank,
      'predictionsRemaining': instance.predictionsRemaining,
      'poolPrize': instance.poolPrize,
      'iconUrl': instance.iconUrl,
      'entryFee': instance.entryFee,
      'matchId': instance.matchId,
      'status': const PouleStatusTypeConverter().toJson(instance.status),
    };
