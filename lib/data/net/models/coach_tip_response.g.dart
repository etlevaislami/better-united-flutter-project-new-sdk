// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coach_tip_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoachTipResponse _$CoachTipResponseFromJson(Map<String, dynamic> json) =>
    CoachTipResponse(
      (json['id'] as num).toInt(),
      json['text'] as String,
      (json['announceAfterMinutes'] as num).toInt(),
      const DateTimeConverter().fromJson(json['expiresAt'] as String),
      json['imageUrl'] as String,
    );

Map<String, dynamic> _$CoachTipResponseToJson(CoachTipResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'announceAfterMinutes': instance.announceAfterMinutes,
      'expiresAt': const DateTimeConverter().toJson(instance.expiresAt),
      'imageUrl': instance.imageUrl,
    };
