// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginatedResponse _$PaginatedResponseFromJson(Map<String, dynamic> json) =>
    PaginatedResponse(
      (json['data'] as List<dynamic>)
          .map((e) => TipDetailResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['totalPages'] as num).toInt(),
      (json['currentPage'] as num).toInt(),
      (json['totalItemCount'] as num).toInt(),
    );

Map<String, dynamic> _$PaginatedResponseToJson(PaginatedResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'totalPages': instance.totalPages,
      'currentPage': instance.currentPage,
      'totalItemCount': instance.totalItemCount,
    };
