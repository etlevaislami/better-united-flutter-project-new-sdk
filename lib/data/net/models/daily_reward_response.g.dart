// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_reward_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyRewardResponse _$DailyRewardResponseFromJson(Map<String, dynamic> json) =>
    DailyRewardResponse(
      (json['coins'] as num).toInt(),
      json['claimed'] as bool,
      (json['day'] as num).toInt(),
    );

Map<String, dynamic> _$DailyRewardResponseToJson(
        DailyRewardResponse instance) =>
    <String, dynamic>{
      'coins': instance.coins,
      'claimed': instance.claimed,
      'day': instance.day,
    };
