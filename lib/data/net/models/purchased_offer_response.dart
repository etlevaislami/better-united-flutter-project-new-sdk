import 'package:json_annotation/json_annotation.dart';

import '../converters/date_converter.dart';

part 'purchased_offer_response.g.dart';

@JsonSerializable()
@DateTimeConverter()
class PurchasedOfferResponse {
  final int id;
  final int appUserRedemptionCodeId;
  final String title;
  final String imageUrl;
  final DateTime? availableUntil;
  final DateTime? redeemedAt;
  final String? redemptionCode;
  final String description;
  final String? webshopUrl;

  PurchasedOfferResponse({
    required this.id,
    required this.appUserRedemptionCodeId,
    required this.title,
    required this.imageUrl,
    required this.availableUntil,
    required this.redeemedAt,
    required this.redemptionCode,
    required this.description,
    required this.webshopUrl,
  });

  factory PurchasedOfferResponse.fromJson(Map<String, dynamic> json) =>
      _$PurchasedOfferResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PurchasedOfferResponseToJson(this);
}
