import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/constants/extended_theme.dart';
import 'package:flutter_better_united/widgets/rounded_container.dart';

import '../figma/colors.dart';
import '../util/betterUnited_icons.dart';
import '../util/date_util.dart';
import 'poule_card_detail.dart';

class PouleFromPredictionCard extends StatelessWidget {
  const PouleFromPredictionCard(
      {super.key,
      required this.pouleName,
      required this.predictionLeft,
      required this.icon,
      this.onTap,
      required this.startDate,
      required this.endDate,
      required this.hasEnded});

  final String pouleName;
  final DateTime startDate;
  final DateTime endDate;
  final int predictionLeft;
  final Widget icon;
  final GestureTapCallback? onTap;
  final bool hasEnded;

  @override
  Widget build(BuildContext context) {
    final bool hasPredictions = predictionLeft > 0;
    return GestureDetector(
      onTap: hasEnded
          ? null
          : hasPredictions
              ? onTap
              : null,
      child: Stack(
        children: [
          PouleCardWidget(
            image: icon,
            isActive: hasEnded ? true : !hasPredictions,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pouleName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.titleH2.copyWith(color: Colors.white),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Container(
                      width: 7,
                      height: 7,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: AppColors.primary),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                        child: AutoSizeText(
                      formatDatePeriod(startDate, endDate),
                      maxLines: 1,
                      minFontSize: 1,
                      style: context.labelRegular.copyWith(color: Colors.white),
                    ))
                  ],
                ),
                const SizedBox(
                  height: 14,
                ),
                RoundedContainer(
                  backgroundColor: hasEnded
                      ? AppColors.secondary
                      : hasPredictions
                          ? AppColors.primary
                          : AppColors.secondary,
                  child: Text(
                    hasEnded
                        ? "ended".tr()
                        : "predictionLeftArgs".plural(predictionLeft),
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.italic),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            top: 16,
            left: 16,
            child: GestureDetector(
              onTap: onTap,
              child: const Icon(
                BetterUnited.info,
              ),
            ),
          )
        ],
      ),
    );
  }
}
