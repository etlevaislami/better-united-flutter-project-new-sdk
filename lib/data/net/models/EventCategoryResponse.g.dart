// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'EventCategoryResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventCategoryResponse _$EventCategoryResponseFromJson(
        Map<String, dynamic> json) =>
    EventCategoryResponse(
      (json['id'] as num).toInt(),
      json['name'] as String,
      json['pictureUrl'] as String?,
      json['iconUrl'] as String?,
    );

Map<String, dynamic> _$EventCategoryResponseToJson(
        EventCategoryResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'pictureUrl': instance.pictureUrl,
      'iconUrl': instance.iconUrl,
    };
