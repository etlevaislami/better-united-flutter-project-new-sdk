// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reward_level_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RewardLevelResponse _$RewardLevelResponseFromJson(Map<String, dynamic> json) =>
    RewardLevelResponse(
      (json['id'] as num).toInt(),
      json['title'] as String,
      (json['coinCount'] as num?)?.toInt(),
      (json['tipRevealCount'] as num?)?.toInt(),
      (json['powerupCount'] as num?)?.toInt(),
      (json['level'] as num).toInt(),
      (json['isClaimed'] as num).toInt(),
      (json['isAchieved'] as num).toInt(),
      (json['neededPoints'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RewardLevelResponseToJson(
        RewardLevelResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'coinCount': instance.coinCount,
      'tipRevealCount': instance.tipRevealCount,
      'powerupCount': instance.powerupCount,
      'level': instance.level,
      'isClaimed': instance.isClaimed,
      'isAchieved': instance.isAchieved,
      'neededPoints': instance.neededPoints,
    };
