// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_rewards_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyRewardsResponse _$DailyRewardsResponseFromJson(
        Map<String, dynamic> json) =>
    DailyRewardsResponse(
      (json['rewards'] as List<dynamic>)
          .map((e) => DailyRewardResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['isClaimable'] as bool,
    );

Map<String, dynamic> _$DailyRewardsResponseToJson(
        DailyRewardsResponse instance) =>
    <String, dynamic>{
      'rewards': instance.rewards,
      'isClaimable': instance.isClaimable,
    };
