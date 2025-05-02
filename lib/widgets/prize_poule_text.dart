import 'package:flutter/material.dart';
import 'package:flutter_better_united/constants/extended_theme.dart';
import 'package:flutter_better_united/figma/colors.dart';
import 'package:flutter_better_united/util/extensions/int_extension.dart';

class PrizePouleText extends StatelessWidget {
  const PrizePouleText({
    Key? key,
    required this.amount,
    this.backgroundColor = AppColors.secondary,
    required this.text,
  }) : super(key: key);
  final int amount;
  final String text;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          text.toUpperCase(),
          style: context.titleH2.copyWith(color: Colors.white),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  children: [
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Transform.scale(
                        scale: 1.3,
                        child: SizedBox(
                          width: 28,
                          height: 28,
                          child: Image.asset(
                            'assets/icons/ic_coins.png',
                            scale: 1.3,
                          ),
                        ),
                      ),
                    ),
                  ],
                  text: amount.formatNumber() + " ",
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
