import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../figma/colors.dart';
import '../figma/text_styles.dart';
import '../util/betterUnited_icons.dart';

class SeeMoreButton extends StatelessWidget {
  final bool isExpanded;

  const SeeMoreButton({super.key, required this.isExpanded});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.all(
          Radius.circular(4),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text((isExpanded ? "seeLess".tr() : "seeMore".tr()).toUpperCase(),
              style: AppTextStyles.textStyle2),
          const SizedBox(
            width: 5,
          ),
          Icon(
            isExpanded ? BetterUnited.arrowUp : BetterUnited.arrowDown,
            color: Colors.white,
            size: 13,
          )
        ],
      ),
    );
  }
}
