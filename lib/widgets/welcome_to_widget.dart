import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../figma/colors.dart';

class WelcomeToWidget extends StatelessWidget {
  const WelcomeToWidget(
      {super.key,
      required this.name,
      this.titleSize = 18,
      this.subtitleSize = 22});

  final String name;
  final double titleSize;
  final double subtitleSize;

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: "welcomeTo".tr().toUpperCase() + "\n",
            style: TextStyle(
              color: Colors.white,
              fontSize: titleSize,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.italic,
              height: 0.5,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.5),
                  offset: const Offset(0, 2),
                  blurRadius: 16,
                ),
              ],
            ),
          ),
          TextSpan(
            text: name.toUpperCase(),
            style: TextStyle(
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.5),
                    offset: const Offset(0, 2),
                    blurRadius: 16,
                  ),
                ],
                color: AppColors.primary,
                fontSize: subtitleSize,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.italic,
                height: 1.5),
          ),
        ],
      ),
    );
  }
}
