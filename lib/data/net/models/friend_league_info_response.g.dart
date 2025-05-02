// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_league_info_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FriendLeagueInfoResponse _$FriendLeagueInfoResponseFromJson(
        Map<String, dynamic> json) =>
    FriendLeagueInfoResponse(
      (json['id'] as num).toInt(),
      json['name'] as String,
    );

Map<String, dynamic> _$FriendLeagueInfoResponseToJson(
        FriendLeagueInfoResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
