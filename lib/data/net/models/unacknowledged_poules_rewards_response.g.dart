// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unacknowledged_poules_rewards_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnacknowledgedPoulesRewardsResponse
    _$UnacknowledgedPoulesRewardsResponseFromJson(Map<String, dynamic> json) =>
        UnacknowledgedPoulesRewardsResponse(
          (json['friendPoules'] as List<dynamic>)
              .map((e) => (e as num).toInt())
              .toList(),
          (json['publicPoules'] as List<dynamic>)
              .map((e) => (e as num).toInt())
              .toList(),
        );

Map<String, dynamic> _$UnacknowledgedPoulesRewardsResponseToJson(
        UnacknowledgedPoulesRewardsResponse instance) =>
    <String, dynamic>{
      'friendPoules': instance.friendPoules,
      'publicPoules': instance.publicPoules,
    };
