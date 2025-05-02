// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'self_invite_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SelfInviteRequest _$SelfInviteRequestFromJson(Map<String, dynamic> json) =>
    SelfInviteRequest(
      (json['friendLeagueId'] as num).toInt(),
    );

Map<String, dynamic> _$SelfInviteRequestToJson(SelfInviteRequest instance) =>
    <String, dynamic>{
      'friendLeagueId': instance.friendLeagueId,
    };
