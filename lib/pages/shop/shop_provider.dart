import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_better_united/data/model/purchasable_coins.dart';
import 'package:flutter_better_united/data/repo/shop_repository.dart';
import 'package:flutter_better_united/pages/shop/purchase_manager.dart';
import 'package:flutter_better_united/pages/shop/user_provider.dart';

import '../../data/model/offer.dart';
import '../../data/model/power_up.dart';
import '../../run.dart';
import '../../util/ui_util.dart';

class ShopProvider with ChangeNotifier {
  final ShopRepository _shopRepository;
  final PurchaseManager _purchaseManager;
  final UserProvider _userProvider;
  List<PowerUp> powerUps = [];
  List<Offer>? offers;
  List<Offer>? purchasedOffers;
  List<Offer>? redeemedOffers;

  ShopProvider(this._shopRepository, this._purchaseManager, this._userProvider);

  fetchPowerUps() async {
    beginLoading();
    try {
      powerUps = await _shopRepository.getPowerUps();
      notifyListeners();
    } catch (e) {
      showGenericError(e);
    } finally {
      endLoading();
    }
    return null;
  }

  Future<PowerUp?> purchasePowerUp(PowerUp powerUp) async {
    beginLoading();
    try {
      await _purchaseManager.purchasePowerUp(powerUp);
      powerUp.powerUpCount++;
      powerUps = List.of(powerUps);
      notifyListeners();
      return powerUp;
    } catch (e) {
      logger.e(e);
      rethrow;
    } finally {
      endLoading();
    }
  }

  Future<void> buyCoins(PurchasableCoins product) async {
    return _purchaseManager.buyCoins(product);
  }

  fetchOffers() async {
    beginLoading();
    try {
      offers = await _shopRepository.getOffers();
      notifyListeners();
    } catch (e) {
      showGenericError(e);
    } finally {
      endLoading();
    }
    return null;
  }

  Future<void> buyOffer(Offer offer) async {
    beginLoading();
    try {
      await _shopRepository.buyOffer(offer);
      _userProvider.syncUserProfile();
    } catch (e) {
      rethrow;
    } finally {
      endLoading();
    }
  }

  fetchPurchasedOffers() async {
    beginLoading();
    try {
      purchasedOffers = await _shopRepository.getPurchasedOffers();
      notifyListeners();
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      showGenericError(e);
    } finally {
      endLoading();
    }
    return null;
  }

  fetchRedeemedOffers() async {
    beginLoading();
    try {
      redeemedOffers = await _shopRepository.getRedeemedOffers();
      notifyListeners();
    } catch (e) {
      showGenericError(e);
    } finally {
      endLoading();
    }
    return null;
  }

  Future<void> redeemOffer(int id) async {
    beginLoading();
    try {
      await _shopRepository.redeemOffer(id);
      notifyListeners();
    } catch (e) {
      showGenericError(e);
    } finally {
      endLoading();
    }
  }
}
