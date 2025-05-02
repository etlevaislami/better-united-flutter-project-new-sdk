// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_category_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoCategoryResponse _$VideoCategoryResponseFromJson(
        Map<String, dynamic> json) =>
    VideoCategoryResponse(
      (json['id'] as num).toInt(),
      json['iconUrl'] as String,
      json['name'] as String,
      (json['videoCount'] as num).toInt(),
    );

Map<String, dynamic> _$VideoCategoryResponseToJson(
        VideoCategoryResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'iconUrl': instance.iconUrl,
      'name': instance.name,
      'videoCount': instance.videoCount,
    };
