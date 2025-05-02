import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CoinWidget extends StatelessWidget {
  const CoinWidget({
    Key? key,
    required this.tipRevealPrice,
  }) : super(key: key);
  final int tipRevealPrice;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(4.0),
            bottomRight: Radius.circular(17.0),
            topLeft: Radius.circular(4.0),
            bottomLeft: Radius.circular(4.0)),
      ),
      child: Row(
        children: [
          Text(
            tipRevealPrice.toString(),
            style: context.titleLarge,
          ).fontSize(14),
          const SizedBox(
            width: 5,
          ),
          SvgPicture.asset("assets/images/ic_coin.svg")
        ],
      ),
    );
  }
}
