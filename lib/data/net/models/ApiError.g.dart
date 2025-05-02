// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ApiError.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiError _$ApiErrorFromJson(Map<String, dynamic> json) => ApiError(
      json['error'] as String,
      json['error_description'] as String?,
    );

Map<String, dynamic> _$ApiErrorToJson(ApiError instance) => <String, dynamic>{
      'error': instance.error,
      'error_description': instance.errorDescription,
    };
