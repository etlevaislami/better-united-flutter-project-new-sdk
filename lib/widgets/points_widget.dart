import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/constants/extended_theme.dart';
import 'package:flutter_better_united/figma/colors.dart';

class PointsWidget extends StatelessWidget {
  const PointsWidget({Key? key, required this.points, this.drawPlus = true})
      : super(key: key);
  final int points;
  final bool drawPlus;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: context.bodyBold.copyWith(color: Colors.white),
        children: [
          TextSpan(
              text: "${drawPlus ? "+" : ""}$points",
              style: context.bodyBold.copyWith(color: AppColors.primary)),
          const TextSpan(
            text: " ",
          ),
          TextSpan(
            text: "pointArgs".plural(points),
          ),
        ],
      ),
    );
  }
}
