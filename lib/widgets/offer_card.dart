import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/figma/colors.dart';
import 'package:flutter_better_united/figma/dimensions.dart';
import 'package:flutter_better_united/widgets/rounded_container.dart';
import 'package:flutter_better_united/widgets/user_coins.dart';
import 'package:flutter_svg/svg.dart';

import '../util/date_util.dart';
import 'background_container.dart';

class OfferCard extends StatelessWidget {
  const OfferCard({
    super.key,
    required this.title,
    this.coins,
    this.validUntil,
    this.isExpired,
    this.isRedeemed,
    this.isSoldOut = false,
    required this.imageUrl,
    this.imageLocal = false,
  });

  final String title;
  final int? coins;
  final DateTime? validUntil;
  final bool? isExpired;
  final bool? isRedeemed;
  final bool isSoldOut;
  final String imageUrl;
  final bool imageLocal;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: AppDimensions.shopOfferItemHeight,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Opacity(
              opacity: isSoldOut ? 0.5 : 1,
              child: PhysicalModel(
                color: Colors.transparent,
                // Required to apply shadow
                elevation: 10,
                // Elevation for shadow effect
                shadowColor: Colors.black.withOpacity(0.5),
                // Shadow color
                borderRadius: BorderRadius.circular(8),
                // Rounded corners
                clipBehavior: Clip.antiAlias,
                child: BackgroundContainer(
                  isInclinationReversed: true,
                  withShadow: false,
                  gradientEndColor: AppColors.primary,
                  borderRadius: BorderRadius.zero,
                  foregroundColor: isSoldOut
                      ? const Color(0xff2c2c2c)
                      : const Color(0xff151515),
                  backgroundColor: const Color(0xff4E4E4E),
                  widthRatio: 0.65,
                  leadingChild: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LayoutBuilder(
                          builder: (context, constraints) {
                            return SizedBox(
                                width: constraints.maxWidth * 0.7,
                                child: Text(
                                  title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    fontStyle: FontStyle.italic,
                                    shadows: [
                                      Shadow(
                                        color:
                                            AppColors.primary.withOpacity(0.5),
                                        // Converted ARGB color
                                        offset: const Offset(0, 0),
                                        // No offset
                                        blurRadius: 16, // Similar to box-shadow
                                      ),
                                    ],
                                  ),
                                ));
                          },
                        ),
                      ],
                    ),
                  ),
                  trailingChild: imageLocal
                      ? Transform.scale(
                          scale: 1.1,
                          child: Image(
                            image: AssetImage(imageUrl),
                            fit: BoxFit.cover,
                            alignment: Alignment.centerLeft,
                          ))
                      : Transform.scale(
                          scale: 0.85,
                          child: CachedNetworkImage(
                            imageUrl: imageUrl,
                          ),
                        ),
                ),
              ),
            ),
            isSoldOut
                ? Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 12),
                      child: RoundedContainer(
                          backgroundColor: const Color(0xff1D1D1D),
                          child: Text("soldOut".tr(),
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w500))),
                    ))
                : Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 12),
                      child: (isRedeemed ?? false) || (isExpired ?? false)
                          ? Row(
                              children: [
                                (isExpired ?? false)
                                    ? _StatusCard(
                                        asset: "assets/icons/ic-expired.svg",
                                        color: AppColors.textError,
                                        text: "expired".tr(),
                                      )
                                    : (isRedeemed ?? false)
                                        ? _StatusCard(
                                            asset:
                                                "assets/icons/ic-redeemed.svg",
                                            color: AppColors.textInnactive,
                                            text: "redeemed".tr(),
                                          )
                                        : const SizedBox()
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                coins == null
                                    ? const SizedBox()
                                    : AnimatedCoinsWidget(
                                        coins: coins!,
                                      ),
                                validUntil != null
                                    ? Expanded(
                                        child: LayoutBuilder(
                                            builder: (context, constraints) {
                                          return Row(
                                            mainAxisAlignment: coins == null
                                                ? MainAxisAlignment.start
                                                : MainAxisAlignment.end,
                                            children: [
                                              ConstrainedBox(
                                                constraints: BoxConstraints(
                                                  maxWidth:
                                                      constraints.maxWidth,
                                                ),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                    color:
                                                        const Color(0xff1D1D1D),
                                                  ),
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 8,
                                                      vertical: 4),
                                                  child: AutoSizeText.rich(
                                                    minFontSize: 1,
                                                    maxFontSize: 12,
                                                    placeholderDimensions: const [
                                                      PlaceholderDimensions(
                                                          size: Size(16, 16),
                                                          alignment:
                                                              PlaceholderAlignment
                                                                  .top)
                                                    ],
                                                    TextSpan(
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                      children: [
                                                        WidgetSpan(
                                                            child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  right: 4.0),
                                                          child: SvgPicture.asset(
                                                              "assets/icons/ic-schedule.svg"),
                                                        )),
                                                        TextSpan(
                                                          text:
                                                              "${"availableUntil".tr()}: ",
                                                          style: const TextStyle(
                                                              color: Color(
                                                                  0xffFEC101),
                                                              fontSize: 12,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        TextSpan(
                                                          text: dayMonthYearFormatterWithSeparator
                                                              .format(
                                                                  validUntil!),
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        // Unicode for superscript 3
                                                      ],
                                                    ),
                                                    textAlign: TextAlign.center,
                                                    maxLines: 1,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        }),
                                      )
                                    : const SizedBox()
                              ],
                            ),
                    ),
                  )
          ],
        ));
  }
}

class _StatusCard extends StatelessWidget {
  const _StatusCard({
    required this.color,
    required this.text,
    required this.asset,
  });

  final Color color;
  final String text;
  final String asset;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: const Color(0xff1D1D1D),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            asset,
            color: color,
            height: 16,
          ),
          const SizedBox(
            width: 4,
          ),
          Text(
            text,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: color,
                fontStyle: FontStyle.italic),
          )
        ],
      ),
    );
  }
}
