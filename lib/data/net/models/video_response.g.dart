// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoResponse _$VideoResponseFromJson(Map<String, dynamic> json) =>
    VideoResponse(
      (json['id'] as num).toInt(),
      (json['videoCategoryId'] as num).toInt(),
      json['videoCategoryName'] as String,
      json['title'] as String,
      const DateTimeConverter().fromJson(json['createdAt'] as String),
      (json['durationSeconds'] as num).toInt(),
      json['videoUrl'] as String,
      (json['likeCount'] as num).toInt(),
      (json['isLiked'] as num).toInt(),
      json['thumbnailUrl'] as String?,
    );

Map<String, dynamic> _$VideoResponseToJson(VideoResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'videoCategoryId': instance.videoCategoryId,
      'videoCategoryName': instance.videoCategoryName,
      'title': instance.title,
      'createdAt': const DateTimeConverter().toJson(instance.createdAt),
      'durationSeconds': instance.durationSeconds,
      'videoUrl': instance.videoUrl,
      'likeCount': instance.likeCount,
      'isLiked': instance.isLiked,
      'thumbnailUrl': instance.thumbnailUrl,
    };
