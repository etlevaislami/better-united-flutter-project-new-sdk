// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'market_category_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MarketCategoryResponse _$MarketCategoryResponseFromJson(
        Map<String, dynamic> json) =>
    MarketCategoryResponse(
      (json['marketCategoryId'] as num).toInt(),
      json['marketCategoryName'] as String,
    );

Map<String, dynamic> _$MarketCategoryResponseToJson(
        MarketCategoryResponse instance) =>
    <String, dynamic>{
      'marketCategoryId': instance.marketCategoryId,
      'marketCategoryName': instance.marketCategoryName,
    };
