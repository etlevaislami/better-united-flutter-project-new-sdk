// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'active_poule_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivePouleListResponse _$ActivePouleListResponseFromJson(
        Map<String, dynamic> json) =>
    ActivePouleListResponse(
      (json['publicLeagues'] as List<dynamic>)
          .map((e) =>
              PublicLeagueActivePouleItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['friendLeagues'] as List<dynamic>)
          .map((e) =>
              FriendLeagueActivePouleItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ActivePouleListResponseToJson(
        ActivePouleListResponse instance) =>
    <String, dynamic>{
      'publicLeagues': instance.publicLeagues,
      'friendLeagues': instance.friendLeagues,
    };
