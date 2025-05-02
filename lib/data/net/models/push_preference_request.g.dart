// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'push_preference_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PushPreferenceRequest _$PushPreferenceRequestFromJson(
        Map<String, dynamic> json) =>
    PushPreferenceRequest(
      json['notificationAppUpdatesEnabled'] as bool,
      json['notificationPoulesEnabled'] as bool,
      json['notificationAccountEnabled'] as bool,
      json['notificationTipEnabled'] as bool,
    );

Map<String, dynamic> _$PushPreferenceRequestToJson(
        PushPreferenceRequest instance) =>
    <String, dynamic>{
      'notificationAppUpdatesEnabled': instance.notificationAppUpdatesEnabled,
      'notificationPoulesEnabled': instance.notificationPoulesEnabled,
      'notificationAccountEnabled': instance.notificationAccountEnabled,
      'notificationTipEnabled': instance.notificationTipEnabled,
    };
