// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'power_up_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PowerUpResponse _$PowerUpResponseFromJson(Map<String, dynamic> json) =>
    PowerUpResponse(
      (json['id'] as num).toInt(),
      (json['powerupTypeId'] as num).toInt(),
      json['name'] as String,
      (json['price'] as num).toInt(),
      json['iconUrl'] as String,
      (json['multiplier'] as num).toDouble(),
      json['description'] as String,
      (json['powerupCount'] as num).toInt(),
    );

Map<String, dynamic> _$PowerUpResponseToJson(PowerUpResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'powerupTypeId': instance.powerupTypeId,
      'name': instance.name,
      'price': instance.price,
      'iconUrl': instance.iconUrl,
      'multiplier': instance.multiplier,
      'description': instance.description,
      'powerupCount': instance.powerupCount,
    };
