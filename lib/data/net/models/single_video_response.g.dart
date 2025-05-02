// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_video_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SingleVideoResponse _$SingleVideoResponseFromJson(Map<String, dynamic> json) =>
    SingleVideoResponse(
      (json['id'] as num).toInt(),
      (json['videoCategoryId'] as num).toInt(),
      json['title'] as String,
      const DateTimeConverter().fromJson(json['createdAt'] as String),
      (json['durationSeconds'] as num).toInt(),
      json['videoUrl'] as String,
    );

Map<String, dynamic> _$SingleVideoResponseToJson(
        SingleVideoResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'videoCategoryId': instance.videoCategoryId,
      'title': instance.title,
      'createdAt': const DateTimeConverter().toJson(instance.createdAt),
      'durationSeconds': instance.durationSeconds,
      'videoUrl': instance.videoUrl,
    };
