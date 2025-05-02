// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bet_info_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BetInfoResponse _$BetInfoResponseFromJson(Map<String, dynamic> json) =>
    BetInfoResponse(
      (json['Popular'] as List<dynamic>)
          .map((e) => MarketResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      TeamResponse.fromJson(json['homeTeam'] as Map<String, dynamic>),
      TeamResponse.fromJson(json['awayTeam'] as Map<String, dynamic>),
      (json['Additional'] as List<dynamic>)
          .map((e) => MarketResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BetInfoResponseToJson(BetInfoResponse instance) =>
    <String, dynamic>{
      'homeTeam': instance.homeTeam,
      'awayTeam': instance.awayTeam,
      'Popular': instance.popular,
      'Additional': instance.additional,
    };
