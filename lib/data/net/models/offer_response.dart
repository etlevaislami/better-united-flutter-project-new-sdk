import 'package:json_annotation/json_annotation.dart';

import '../converters/date_converter.dart';

part 'offer_response.g.dart';

@JsonSerializable()
@DateTimeConverter()
class OfferResponse {
  final int id;
  final String title;
  final int price;
  final String imageUrl;
  final bool isSoldOut;
  final DateTime? availableUntil;
  final String? description;

  OfferResponse(
      {required this.id,
      required this.title,
      required this.price,
      required this.imageUrl,
      required this.isSoldOut,
      required this.availableUntil,
      required this.description});

  factory OfferResponse.fromJson(Map<String, dynamic> json) =>
      _$OfferResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OfferResponseToJson(this);
}
