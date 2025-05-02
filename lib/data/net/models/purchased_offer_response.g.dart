// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchased_offer_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PurchasedOfferResponse _$PurchasedOfferResponseFromJson(
        Map<String, dynamic> json) =>
    PurchasedOfferResponse(
      id: (json['id'] as num).toInt(),
      appUserRedemptionCodeId: (json['appUserRedemptionCodeId'] as num).toInt(),
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String,
      availableUntil: _$JsonConverterFromJson<String, DateTime>(
          json['availableUntil'], const DateTimeConverter().fromJson),
      redeemedAt: _$JsonConverterFromJson<String, DateTime>(
          json['redeemedAt'], const DateTimeConverter().fromJson),
      redemptionCode: json['redemptionCode'] as String?,
      description: json['description'] as String,
      webshopUrl: json['webshopUrl'] as String?,
    );

Map<String, dynamic> _$PurchasedOfferResponseToJson(
        PurchasedOfferResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'appUserRedemptionCodeId': instance.appUserRedemptionCodeId,
      'title': instance.title,
      'imageUrl': instance.imageUrl,
      'availableUntil': _$JsonConverterToJson<String, DateTime>(
          instance.availableUntil, const DateTimeConverter().toJson),
      'redeemedAt': _$JsonConverterToJson<String, DateTime>(
          instance.redeemedAt, const DateTimeConverter().toJson),
      'redemptionCode': instance.redemptionCode,
      'description': instance.description,
      'webshopUrl': instance.webshopUrl,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
