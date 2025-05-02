// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'push_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PushRequest _$PushRequestFromJson(Map<String, dynamic> json) => PushRequest(
      json['pushToken'] as String,
      json['deviceId'] as String,
    );

Map<String, dynamic> _$PushRequestToJson(PushRequest instance) =>
    <String, dynamic>{
      'pushToken': instance.pushToken,
      'deviceId': instance.deviceId,
    };
