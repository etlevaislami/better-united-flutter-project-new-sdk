// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_friend_league_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateFriendLeagueRequest _$CreateFriendLeagueRequestFromJson(
        Map<String, dynamic> json) =>
    CreateFriendLeagueRequest(
      json['name'] as String,
      (json['entryFee'] as num).toInt(),
      (json['matchId'] as num).toInt(),
    );

Map<String, dynamic> _$CreateFriendLeagueRequestToJson(
        CreateFriendLeagueRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'entryFee': instance.entryFee,
      'matchId': instance.matchId,
    };
