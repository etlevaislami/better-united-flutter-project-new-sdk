import 'package:flutter_better_united/data/net/models/offer_response.dart';

import '../net/models/purchased_offer_response.dart';

class Offer {
  final int id;
  final String title;
  final String? description;
  final String imageUrl;
  final DateTime? validUntil;
  final int coins;
  final String? url;
  final String? code;
  final DateTime? redeemedAt;
  final bool isSoldOut;

  Offer({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.validUntil,
    required this.coins,
    required this.url,
    required this.code,
    required this.redeemedAt,
    this.isSoldOut = false,
  });

  bool get isExpired => validUntil?.isBefore(DateTime.now()) ?? false;

  Offer.fromOfferResponse(OfferResponse response)
      : id = response.id,
        title = response.title,
        description = response.description,
        imageUrl = response.imageUrl,
        validUntil = response.availableUntil,
        coins = response.price,
        url = null,
        redeemedAt = null,
        isSoldOut = response.isSoldOut,
        code = null;

  Offer.fromPurchasedOfferResponse(PurchasedOfferResponse response)
      : id = response.appUserRedemptionCodeId,
        title = response.title,
        description = response.description,
        imageUrl = response.imageUrl,
        validUntil = response.availableUntil,
        coins = 0,
        url = response.webshopUrl,
        redeemedAt = response.redeemedAt,
        isSoldOut = false,
        code = response.redemptionCode;
}
