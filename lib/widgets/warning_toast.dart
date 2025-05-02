import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/svg.dart';

import '../figma/colors.dart';

class WarningToast extends StatelessWidget {
  const WarningToast({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  static showToast(BuildContext context,
      {required String title, required String subtitle}) {
    showToastWidget(
        WarningToast(
          title: title,
          subtitle: subtitle,
        ),
        context: context,
        dismissOtherToast: true,
        animation: StyledToastAnimation.fade,
        reverseAnimation: StyledToastAnimation.fade,
        duration: const Duration(seconds: 3));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Row(
        children: [
          const SizedBox(
            width: 8,
          ),
          SizedBox(
            height: 24,
            width: 24,
            child: SvgPicture.asset("assets/icons/ic_danger_triangle.svg"),
          ),
          const SizedBox(
            width: 13,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: context.displaySmall,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  subtitle,
                  style: context.bodySmall?.copyWith(color: Colors.white),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
