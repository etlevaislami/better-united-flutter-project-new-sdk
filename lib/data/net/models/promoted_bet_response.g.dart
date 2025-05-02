// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promoted_bet_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PromotedBetResponse _$PromotedBetResponseFromJson(Map<String, dynamic> json) =>
    PromotedBetResponse(
      json['bookmakerUrl'] as String,
      json['tipImageEN'] as String?,
      json['tipImageNL'] as String?,
    );

Map<String, dynamic> _$PromotedBetResponseToJson(
        PromotedBetResponse instance) =>
    <String, dynamic>{
      'bookmakerUrl': instance.bookmakerUrl,
      'tipImageEN': instance.tipImageEN,
      'tipImageNL': instance.tipImageNL,
    };
