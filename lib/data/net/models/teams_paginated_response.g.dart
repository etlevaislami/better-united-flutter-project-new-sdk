// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teams_paginated_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamsPaginatedResponse _$TeamsPaginatedResponseFromJson(
        Map<String, dynamic> json) =>
    TeamsPaginatedResponse(
      (json['data'] as List<dynamic>)
          .map((e) => TeamResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['totalPages'] as num).toInt(),
      (json['currentPage'] as num).toInt(),
      (json['totalItemCount'] as num).toInt(),
    );

Map<String, dynamic> _$TeamsPaginatedResponseToJson(
        TeamsPaginatedResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'totalPages': instance.totalPages,
      'currentPage': instance.currentPage,
      'totalItemCount': instance.totalItemCount,
    };
