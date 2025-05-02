// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookie_maker_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookieMakerResponse _$BookieMakerResponseFromJson(Map<String, dynamic> json) =>
    BookieMakerResponse(
      (json['bookmakerId'] as num).toInt(),
      json['bookmakerName'] as String,
      (json['odds'] as List<dynamic>)
          .map((e) => OddsResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['bookmakerlogoUrl'] as String,
      json['bookmakerLink'] as String?,
    );

Map<String, dynamic> _$BookieMakerResponseToJson(
        BookieMakerResponse instance) =>
    <String, dynamic>{
      'bookmakerId': instance.bookmakerId,
      'bookmakerName': instance.bookmakerName,
      'odds': instance.odds,
      'bookmakerlogoUrl': instance.bookmakerlogoUrl,
      'bookmakerLink': instance.bookmakerLink,
    };
