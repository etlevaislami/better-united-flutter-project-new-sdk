import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OddBanner extends StatelessWidget {
  const OddBanner({Key? key, required this.odds}) : super(key: key);
  final double odds;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(8, 0),
      child: Stack(
        children: [
          SvgPicture.asset(
            "assets/images/odd_card.svg",
            height: 50,
          ),
          Positioned.fill(
            child: Align(
              child: Container(
                margin: const EdgeInsets.only(
                    left: 8, top: 4, right: 8, bottom: 16),
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: FittedBox(
                  child: Text(
                    "${"odds".tr()}: ${odds.toStringAsFixed(2)}",
                    style: context.titleSmall,
                    textAlign: TextAlign.center,
                  ).textColor(Colors.white).fontWeight(FontWeight.bold),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
