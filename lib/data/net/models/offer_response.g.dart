// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offer_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfferResponse _$OfferResponseFromJson(Map<String, dynamic> json) =>
    OfferResponse(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      price: (json['price'] as num).toInt(),
      imageUrl: json['imageUrl'] as String,
      isSoldOut: json['isSoldOut'] as bool,
      availableUntil: _$JsonConverterFromJson<String, DateTime>(
          json['availableUntil'], const DateTimeConverter().fromJson),
      description: json['description'] as String?,
    );

Map<String, dynamic> _$OfferResponseToJson(OfferResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'price': instance.price,
      'imageUrl': instance.imageUrl,
      'isSoldOut': instance.isSoldOut,
      'availableUntil': _$JsonConverterToJson<String, DateTime>(
          instance.availableUntil, const DateTimeConverter().toJson),
      'description': instance.description,
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
