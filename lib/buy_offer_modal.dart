import 'dart:async';

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart' as dialog;
import 'package:flutter/material.dart';
import 'package:flutter_better_united/constants/extended_theme.dart';
import 'package:flutter_better_united/pages/dialog/no_coins_dialog.dart';
import 'package:flutter_better_united/pages/dialog/offer_purchased_modal.dart';
import 'package:flutter_better_united/pages/shop/shop_page.dart';
import 'package:flutter_better_united/pages/shop/shop_provider.dart';
import 'package:flutter_better_united/util/exceptions/custom_exceptions.dart';
import 'package:flutter_better_united/util/ui_util.dart';
import 'package:flutter_better_united/widgets/coin_action_button.dart';
import 'package:flutter_better_united/widgets/hyperlink_text.dart';
import 'package:flutter_better_united/widgets/offer_card.dart';
import 'package:flutter_better_united/widgets/offer_description.dart';
import 'package:flutter_better_united/widgets/user_coins.dart';
import 'package:provider/provider.dart';

import 'data/model/offer.dart';

enum BuyOfferModalResult { purchased, canceled }

class BuyOfferModal extends StatefulWidget {
  final ShopProvider provider;
  final Offer offer;

  const BuyOfferModal({super.key, required this.provider, required this.offer});

  static Future<BuyOfferModalResult?> showDialog(BuildContext context,
      {required ShopProvider provider, required Offer offer}) {
    return dialog.showDialog(
      context: context,
      builder: (BuildContext _) {
        return BuyOfferModal(
          provider: provider,
          offer: offer,
        );
      },
    );
  }

  @override
  State<BuyOfferModal> createState() => _BuyOfferModalState();
}

class _BuyOfferModalState extends State<BuyOfferModal> {
  final _coinAnimationCompleter = Completer<void>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: widget.provider,
      child: Stack(
        children: [
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.85,
              ),
              child: Dialog(
                backgroundColor: const Color(0xff2B2B2B),
                insetPadding: const EdgeInsets.symmetric(horizontal: 16),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
                child: SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 16,
                        ),
                        Text("buyItemConfirmation".tr().toUpperCase(),
                            textAlign: TextAlign.center,
                            style: context.titleH1),
                        const SizedBox(
                          height: 16,
                        ),
                        OfferCard(
                          title: widget.offer.title,
                          imageUrl: widget.offer.imageUrl,
                          coins: widget.offer.coins,
                          validUntil: widget.offer.validUntil,
                        ),
                        widget.offer.description == null
                            ? const SizedBox()
                            : Padding(
                                padding: const EdgeInsets.only(top: 16.0),
                                child: OfferDescription(
                                  htmlContent: widget.offer.description!,
                                ),
                              ),
                        const SizedBox(
                          height: 16,
                        ),
                        CoinActionButton(
                          confineInSafeArea: false,
                          text: "buyOffer".tr(),
                          amount: widget.offer.coins,
                          onPressed: () async {
                            try {
                              await widget.provider.buyOffer(widget.offer);
                              hiddenLoading();
                              await _coinAnimationCompleter.future;
                              endLoading();
                              await OfferPurchasedDialog.displayDialog(context);
                              Navigator.pop(
                                  context, BuyOfferModalResult.purchased);
                            } catch (e) {
                              if (e is NotEnoughCoinsException) {
                                dialog.showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return NoCoinsDialog(
                                      message: "topUpCoins".tr(),
                                      onShopTap: () {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop();
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .push(ShopPage.route(
                                                withBackButton: true));
                                      },
                                      onBackPress: () {
                                        context.pop();
                                      },
                                    );
                                  },
                                );
                              } else if (e is OfferIsSoldOutException) {
                                showToast("offerIsSoldOut".tr());
                              }
                            }
                          },
                        ),
                        const SizedBox(height: 16),
                        HyperlinkText("cancel".tr(), onTap: () {
                          Navigator.pop(context);
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
              right: 20,
              child: UserCoins(
                onAnimationEnd: () {
                  _coinAnimationCompleter.complete();
                },
              ))
        ],
      ),
    );
  }
}
