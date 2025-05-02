// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tip_created_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TipCreatedResponse _$TipCreatedResponseFromJson(Map<String, dynamic> json) =>
    TipCreatedResponse(
      TipResponse.fromJson(json['tip'] as Map<String, dynamic>),
      json['promotedTip'] == null
          ? null
          : PromotedBetResponse.fromJson(
              json['promotedTip'] as Map<String, dynamic>),
      (json['earnedCoins'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TipCreatedResponseToJson(TipCreatedResponse instance) =>
    <String, dynamic>{
      'tip': instance.tip,
      'promotedTip': instance.promotedTip,
      'earnedCoins': instance.earnedCoins,
    };
