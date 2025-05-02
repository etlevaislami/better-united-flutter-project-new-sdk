// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'market_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MarketResponse _$MarketResponseFromJson(Map<String, dynamic> json) =>
    MarketResponse(
      (json['marketId'] as num).toInt(),
      (json['odds'] as List<dynamic>)
          .map((e) => OddsResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['marketIsFolded'] as num).toInt(),
      (json['marketIsAlreadyPlayed'] as num).toInt(),
    );

Map<String, dynamic> _$MarketResponseToJson(MarketResponse instance) =>
    <String, dynamic>{
      'marketId': instance.marketId,
      'odds': instance.odds,
      'marketIsFolded': instance.marketIsFolded,
      'marketIsAlreadyPlayed': instance.marketIsAlreadyPlayed,
    };
