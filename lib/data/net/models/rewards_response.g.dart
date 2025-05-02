// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rewards_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RewardsResponse _$RewardsResponseFromJson(Map<String, dynamic> json) =>
    RewardsResponse(
      (json['xpReward'] as num).toInt(),
      (json['coinReward'] as num).toInt(),
      (json['tipPoints'] as num).toInt(),
      (json['tipPointsXpReward'] as num).toInt(),
      intToTipSettlement((json['tipSettlement'] as num?)?.toInt()),
    );

Map<String, dynamic> _$RewardsResponseToJson(RewardsResponse instance) =>
    <String, dynamic>{
      'xpReward': instance.xpReward,
      'coinReward': instance.coinReward,
      'tipPoints': instance.tipPoints,
      'tipPointsXpReward': instance.tipPointsXpReward,
      'tipSettlement': tipSettlementFromInt(instance.tipSettlement),
    };
