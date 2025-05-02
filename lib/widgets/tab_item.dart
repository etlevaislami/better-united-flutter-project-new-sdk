import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/util/common_ui.dart';

import '../constants/app_colors.dart';

class TabItem extends StatelessWidget {
  const TabItem({
    Key? key,
    this.isActive = false,
    required this.text,
    this.selectedColor = AppColors.pearlPowder,
    this.unselectedColor = AppColors.pearlPowder,
  }) : super(key: key);
  final bool isActive;
  final String text;
  final Color selectedColor;
  final Color unselectedColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        boxShadow: isActive ? appBoxShadow : null,
        color: isActive ? selectedColor : unselectedColor,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(15.0),
          bottomRight: Radius.zero,
          topLeft: Radius.circular(15.0),
          bottomLeft: Radius.zero,
        ),
      ),
      child: Text(
        text,
        style: context.titleLarge?.copyWith(
          color: isActive
              ? AppColors.forgedSteel
              : AppColors.forgedSteel.withOpacity(0.5),
        ),
      ).fontSize(14),
    );
  }
}
