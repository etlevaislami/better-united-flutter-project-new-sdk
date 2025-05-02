// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'power_up_info_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PowerUpInfoResponse _$PowerUpInfoResponseFromJson(Map<String, dynamic> json) =>
    PowerUpInfoResponse(
      (json['powerupTypeId'] as num).toInt(),
      json['powerupName'] as String,
      json['powerupIconUrl'] as String,
      (json['powerupMultiplier'] as num).toDouble(),
    );

Map<String, dynamic> _$PowerUpInfoResponseToJson(
        PowerUpInfoResponse instance) =>
    <String, dynamic>{
      'powerupTypeId': instance.powerupTypeId,
      'powerupName': instance.powerupName,
      'powerupIconUrl': instance.powerupIconUrl,
      'powerupMultiplier': instance.powerupMultiplier,
    };
