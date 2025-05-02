import 'dart:async';
import 'dart:io';

import 'package:flutter_better_united/data/repo/shop_repository.dart';
import 'package:flutter_better_united/pages/shop/user_provider.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';

import '../../data/model/power_up.dart';
import '../../data/model/purchasable_coins.dart';
import '../../run.dart';
import '../../util/ui_util.dart';

class PurchaseManager {
  static const List<String> _productIds = [
    "coins_500",
    "coins_2000",
    "coins_7000",
    "coins_15000"
  ];
  final RegExp code = RegExp("(?<=coins_)[0-9]+");
  final UserProvider _userProvider;
  final ShopRepository _shopRepository;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  final _inAppPurchase = InAppPurchase.instance;
  List<PurchasableCoins> purchasableCoins = [];
  List<ProductDetails> _products = <ProductDetails>[];
  bool _isStoreAvailable = false;

  PurchaseManager(this._userProvider, this._shopRepository) {
    final purchaseUpdated = _inAppPurchase.purchaseStream;
    _subscription = purchaseUpdated.listen(
      _listenToPurchaseUpdated,
      onDone: _updateStreamOnDone,
      onError: _updateStreamOnError,
    );

    initStoreInfo();
  }

  bool isStoreAvailable() => _isStoreAvailable;

  _mapPurchasableCoins(List<ProductDetails> products) {
    final List<ProductDetails> productsCopy = [...products];
    purchasableCoins.clear();
    for (var product in productsCopy) {
      final coins = int.tryParse(code.stringMatch(product.id) ?? "");
      if (coins != null) {
        purchasableCoins.add(PurchasableCoins(
            id: product.id,
            coins: coins,
            amount: product.rawPrice,
            currencySymbol: product.currencySymbol));
      }
    }
    purchasableCoins.sort((a, b) => a.coins.compareTo(b.coins));
  }

  void _updateStreamOnDone() {
    _subscription.cancel();
  }

  void _updateStreamOnError(dynamic error) {
    logger.e("_updateStreamOnError");
    logger.e(error);
  }

  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) async {
    beginLoading();
    try {
      await _shopRepository.verifyPurchase(purchaseDetails.productID,
          purchaseDetails.verificationData.serverVerificationData);
      return true;
    } catch (exception) {
      showGenericError(exception);
    } finally {
      endLoading();
    }
    return false;
  }

  Future<void> buyCoins(PurchasableCoins product) async {
    await _finishUnfinishedIosTransactions();
    final productDetails =
        _products.firstWhere((element) => element.id == product.id);
    final purchaseParam = PurchaseParam(productDetails: productDetails);
    await _inAppPurchase.buyConsumable(purchaseParam: purchaseParam);
  }

  Future<void> purchasePowerUp(PowerUp powerUp) async {
    await _shopRepository.purchasePowerUp(powerUp.id);
    _userProvider.syncUserProfile();
  }

  Future<List<PowerUp>> getPurchasedPowerUps() async {
    List<PowerUp> powerUps = await _shopRepository.getPowerUps();
    return powerUps.where((powerUp) => powerUp.powerUpCount > 0).toList();
  }

  Future<void> _listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList) async {
    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      switch (purchaseDetails.status) {
        case PurchaseStatus.pending:
          logger.e("purchase $purchaseDetails pending");
          break;
        case PurchaseStatus.error:
          logger.e("purchase failed $purchaseDetails");
          await _inAppPurchase.completePurchase(purchaseDetails);
          break;
        case PurchaseStatus.purchased:
        case PurchaseStatus.restored:
          final bool valid = await _verifyPurchase(purchaseDetails);
          if (valid) {
            _deliverProduct(purchaseDetails);
          }
          break;
        case PurchaseStatus.canceled:
          logger.e("purchase canceled");
          break;
      }
    }
  }

  Future<void> _deliverProduct(PurchaseDetails purchaseDetails) async {
    if (Platform.isAndroid) {
      final InAppPurchaseAndroidPlatformAddition androidAddition =
          _inAppPurchase
              .getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();
      await androidAddition.consumePurchase(purchaseDetails);
    }
    if (purchaseDetails.pendingCompletePurchase) {
      await _inAppPurchase.completePurchase(purchaseDetails);
    }

    _userProvider.syncUserProfile();
  }

  Future<void> initStoreInfo() async {
    final bool isAvailable = await _inAppPurchase.isAvailable();
    _isStoreAvailable = isAvailable;
    logger.e("store available $isAvailable");
    if (!isAvailable) {
      _isStoreAvailable = isAvailable;
      return;
    }

    final ProductDetailsResponse productDetailResponse = await _inAppPurchase.queryProductDetails({..._productIds});
    if (productDetailResponse.error == null ||
        productDetailResponse.productDetails.isEmpty) {
      _isStoreAvailable = isAvailable;
      _products = productDetailResponse.productDetails;
      _mapPurchasableCoins(_products);
      return;
    }

    _products = productDetailResponse.productDetails;
    _mapPurchasableCoins(_products);
    _finishUnfinishedIosTransactions();
  }

  Future<void> _finishUnfinishedIosTransactions() async {
    if (_isStoreAvailable && Platform.isIOS) {
      final paymentWrapper = SKPaymentQueueWrapper();
      final transactions = await paymentWrapper.transactions();

      await Future.wait(
          transactions.map((e) => paymentWrapper.finishTransaction(e)));
    }
  }
}
