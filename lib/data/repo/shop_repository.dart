import 'package:flutter_better_united/data/model/offer.dart';
import 'package:flutter_better_united/data/model/power_up.dart';
import 'package:flutter_better_united/data/net/models/verify_purchase_request.dart';

import '../../util/exceptions/custom_exceptions.dart';
import '../net/api_service.dart';
import '../net/interceptors/error_interceptor.dart';

class ShopRepository {
  final ApiService _apiService;

  ShopRepository(this._apiService);

  Future<List<PowerUp>> getPowerUps() async {
    var response = await _apiService.getPowerups();
    return response
        .map((powerUpResponse) => PowerUp.fromPowerUpResponse(powerUpResponse))
        .toList();
  }

  Future<void> verifyPurchase(String productId, String receipt) {
    return _apiService
        .verifyPurchase(VerifyPurchaseRequest(productId, receipt));
  }

  Future<void> purchasePowerUp(int id) {
    return _apiService.purchasePowerups(id).onError((error, stackTrace) {
      if (error is BadRequestException) {
        if (error.apiErrorCode == NotEnoughCoinsException.errorCode) {
          throw NotEnoughCoinsException();
        }
      }
      throw error as Exception;
    });
  }

  Future<List<Offer>> getOffers() async {
    final response = await _apiService.getOffers();
    return response.map((e) => Offer.fromOfferResponse(e)).toList();
  }

  Future<void> buyOffer(Offer offer) async {
    try {
      await _apiService.purchaseOffer(offer.id);
    } on BadRequestException catch (e) {
      if (e.apiErrorCode == NotEnoughCoinsException.errorCode) {
        throw NotEnoughCoinsException();
      } else if (e.apiErrorCode == "OFFER_IS_SOLD_OUT") {
        throw OfferIsSoldOutException();
      }
    }
  }

  Future<List<Offer>> getPurchasedOffers() async {
    final response = await _apiService.getActiveOffers();
    return response.map((e) => Offer.fromPurchasedOfferResponse(e)).toList();
  }

  Future<List<Offer>> getRedeemedOffers() async {
    final response = await _apiService.getRedeemedOffers();
    return response.map((e) => Offer.fromPurchasedOfferResponse(e)).toList();
  }

  Future<void> redeemOffer(int id) async {
    await _apiService.redeemCoupon(id);
  }
}
