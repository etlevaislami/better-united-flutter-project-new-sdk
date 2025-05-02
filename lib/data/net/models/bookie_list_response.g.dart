// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookie_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookieListResponse _$BookieListResponseFromJson(Map<String, dynamic> json) =>
    BookieListResponse(
      (json['clickableBets'] as List<dynamic>)
          .map((e) => BookieMakerResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['additionalBets'] as List<dynamic>)
          .map((e) => BookieMakerResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BookieListResponseToJson(BookieListResponse instance) =>
    <String, dynamic>{
      'clickableBets': instance.clickableBets,
      'additionalBets': instance.additionalBets,
    };
