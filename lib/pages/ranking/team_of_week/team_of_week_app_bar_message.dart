import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/constants/extended_theme.dart';
import 'package:flutter_better_united/figma/colors.dart';
import 'package:flutter_glow/flutter_glow.dart';

class TeamOfWeekAppBarMessage extends StatelessWidget {
  const TeamOfWeekAppBarMessage({
    super.key,
    required this.title,
    required this.subTitle,
  });

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width * 0.6,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primary, width: 1),
        color: AppColors.background,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GlowText(
            title.toUpperCase(),
            blurRadius: 8,
            glowColor: AppColors.primary,
            textAlign: TextAlign.center,
            style: const TextStyle(
              height: 1.5,
              fontSize: 18,
              color: Colors.white,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            subTitle,
            style: context.labelRegular,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
