import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart' as dialog;
import 'package:flutter/material.dart';
import 'package:flutter_better_united/figma/colors.dart';
import 'package:flutter_better_united/pages/shop/shop_provider.dart';
import 'package:flutter_better_united/util/date_util.dart';
import 'package:flutter_better_united/widgets/hyperlink_text.dart';
import 'package:flutter_better_united/widgets/info_bubble.dart';
import 'package:flutter_better_united/widgets/offer_card.dart';
import 'package:flutter_better_united/widgets/offer_description.dart';
import 'package:flutter_better_united/widgets/primary_button.dart';
import 'package:url_launcher/url_launcher.dart';

import 'data/model/offer.dart';

class CouponModal extends StatelessWidget {
  const CouponModal(
      {super.key,
      required this.shopProvider,
      required this.offer,
      required this.onRedeem});

  final ShopProvider shopProvider;
  final Offer offer;

  final Function? onRedeem;

  static showDialog(BuildContext context,
      {required ShopProvider provider,
      required Offer offer,
      Function? onRedeem}) {
    dialog.showDialog(
      context: context,
      builder: (BuildContext _) {
        return CouponModal(
          onRedeem: onRedeem,
          offer: offer,
          shopProvider: provider,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isRedeemable = onRedeem != null;
    return Dialog(
      backgroundColor: const Color(0xff2B2B2B),
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              isRedeemable
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: InfoBubble(
                        description: "couponRedeemedInstruction".tr(),
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        backgroundColor: Colors.transparent,
                      ),
                    )
                  : const SizedBox(),
              offer.redeemedAt == null
                  ? const SizedBox()
                  : Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24.0),
                      child: InfoBubble(
                        description: "redeemedOn".tr(args: [
                          dayMonthYearHoursWithDotsFormatter
                              .format(offer.redeemedAt!)
                        ]),
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        backgroundColor: const Color(0xff1D1D1D),
                      ),
                    ),
              OfferCard(
                  title: offer.title,
                  imageUrl: offer.imageUrl,
                  isExpired: offer.isExpired,
                  validUntil: offer.validUntil),
              offer.code != null
                  ? Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: _CouponCode(
                        code: offer.code ?? "",
                      ),
                    )
                  : const SizedBox(),
              const SizedBox(
                height: 16,
              ),
              PrimaryButton(
                  confineInSafeArea: false,
                  text: "goToWebShop".tr(),
                  onPressed: offer.url != null
                      ? () async {
                          final url = offer.url;
                          if (url != null) {
                            launchUrl(Uri.parse(url));
                          }
                        }
                      : null),
              offer.description == null
                  ? const SizedBox()
                  : Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: OfferDescription(
                        htmlContent: offer.description!,
                      ),
                    ),
              isRedeemable
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        PrimaryButton(
                            text: "redeemed".tr(),
                            onPressed: () async {
                              await shopProvider.redeemOffer(offer.id);
                              Navigator.pop(context);
                              onRedeem?.call();
                            }),
                        const SizedBox(height: 16),
                        HyperlinkText("cancel".tr(), onTap: () {
                          Navigator.pop(context);
                        })
                      ],
                    )
                  : PrimaryButton(
                      text: "ok".tr(),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
            ],
          ),
        ),
      ),
    );
  }
}

class _CouponCode extends StatelessWidget {
  const _CouponCode({
    required this.code,
  });

  final String code;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xff181818),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: Text(
        code,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontFamily: "Roboto",
          fontSize: 32,
          color: AppColors.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
