import 'package:flutter/material.dart';
import 'package:flutter_better_united/constants/extended_theme.dart';
import 'package:flutter_better_united/util/extensions/string_extension.dart';

import '../../figma/colors.dart';
import '../../figma/shadows.dart';
import '../../widgets/background_container.dart';

class CoinCard extends StatelessWidget {
  const CoinCard(
      {Key? key,
      required this.amount,
      required this.coins,
      required this.currencyCode})
      : super(key: key);
  final double amount;
  final String currencyCode;
  final int coins;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Container(
        height: 183,
        width: 158,
        decoration: BoxDecoration(
            color: AppColors.secondary,
            boxShadow: [AppShadows.dropShadowButton]),
        child: Column(
          children: [
            SizedBox(
                height: 40,
                child: BackgroundContainer(
                  isInclinationReversed: true,
                  withShadow: false,
                  gradientEndColor: AppColors.primary,
                  borderRadius: BorderRadius.zero,
                  foregroundColor: Color(0xff151515),
                  backgroundColor: Color(0xff4E4E4E),
                  widthRatio: 0.8,
                  leadingChild: Row(
                    children: [
                      Image.asset(
                        "assets/icons/ic_coins.png",
                        height: 18,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                          child:
                              Text(coins.toString(), style: context.titleH2)),
                    ],
                  ),
                )),
            Expanded(
              child: Transform.scale(scale: 0.7, child: _buildCoin()),
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 8.0),
                  child: Text(
                    "$currencyCode $amount".removeTrailingZeros(),
                    style: context.bodyBold,
                    textAlign: TextAlign.start,
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Widget _buildCoin() {
    if (amount <= 0.99) {
      return Image.asset("assets/icons/ic_bundle1.png");
    }

    if (amount < 7.99) {
      return Image.asset("assets/icons/ic_bundle2.png");
    }

    if (amount < 21.49) {
      return Image.asset("assets/icons/ic_bundle3.png");
    }

    return Image.asset("assets/icons/ic_bundle4.png");
  }
}
