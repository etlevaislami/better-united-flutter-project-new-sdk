// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'league_invitation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeagueInvitation _$LeagueInvitationFromJson(Map<String, dynamic> json) =>
    LeagueInvitation(
      nickname: json['nickname'] as String,
      leagueId: (json['leagueId'] as num).toInt(),
      leagueName: json['leagueName'] as String,
      type: $enumDecode(_$PouleTypeEnumMap, json['type']),
      poolPrize: (json['poolPrize'] as num).toInt(),
      entryFee: (json['entryFee'] as num).toInt(),
    );

Map<String, dynamic> _$LeagueInvitationToJson(LeagueInvitation instance) =>
    <String, dynamic>{
      'leagueId': instance.leagueId,
      'leagueName': instance.leagueName,
      'nickname': instance.nickname,
      'type': _$PouleTypeEnumMap[instance.type]!,
      'poolPrize': instance.poolPrize,
      'entryFee': instance.entryFee,
    };

const _$PouleTypeEnumMap = {
  PouleType.public: 'public',
  PouleType.friend: 'friend',
};
