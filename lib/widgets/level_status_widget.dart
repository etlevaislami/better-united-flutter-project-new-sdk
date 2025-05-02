import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/constants/extended_theme.dart';
import 'package:flutter_better_united/data/model/reward_level.dart';
import 'package:flutter_better_united/widgets/primary_button.dart';

import '../figma/colors.dart';
import 'grey_color_filtered.dart';

class LevelStatusWidget extends StatelessWidget {
  const LevelStatusWidget(
      {Key? key, required this.rewardLevel, required this.onClaimTap})
      : super(key: key);

  final RewardLevel rewardLevel;
  final Function(RewardLevel) onClaimTap;

  @override
  Widget build(BuildContext context) {
    final width = context.width * 0.75;
    final levelWidth = width * 0.3;
    const levelLeftPadding = 10.0;

    return SizedBox(
      width: width,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 88,
                  color: AppColors.secondary,
                  clipBehavior: Clip.none,
                  width: double.infinity,
                  child: LayoutBuilder(builder: (context, constraints) {
                    return Stack(
                      children: [
                        Row(
                          children: [
                            //dummy place holder
                            Container(
                                clipBehavior: Clip.none,
                                width: levelWidth + levelLeftPadding),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 14,
                                  ),
                                  Text(
                                    rewardLevel.title.toUpperCase(),
                                    style: context.labelBold,
                                  ),
                                  Text(
                                    "fullLevelNumber".tr(args: [
                                      rewardLevel.level.toString()
                                    ]).toUpperCase(),
                                    style: context.labelSemiBold
                                        .copyWith(color: AppColors.primary),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    _getSubtitle(),
                                    style: context.labelRegular,
                                  )
                                ],
                              ),
                              flex: 4,
                            ),
                            const SizedBox(
                              width: 4,
                            )
                          ],
                        ),
                      ],
                    );
                  }),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    color: AppColors.background,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Rewards:",
                              style: context.labelBold,
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Image.asset(
                              "assets/icons/ic_coins.png",
                              height: 24,
                            ),
                            Expanded(
                              child: AutoSizeText(
                                "coinCount".plural(rewardLevel.coinCount ?? 0),
                                minFontSize: 0,
                                maxLines: 1,
                              ),
                            )
                          ],
                          crossAxisAlignment: CrossAxisAlignment.center,
                        ),
                        PrimaryButton(
                          text:
                              !rewardLevel.isClaimed && !rewardLevel.isAchieved
                                  ? "locked".tr()
                                  : rewardLevel.isClaimed
                                      ? "claimed".tr()
                                      : "claimReward".tr(),
                          onPressed:
                              rewardLevel.isClaimed || !rewardLevel.isAchieved
                                  ? null
                                  : () => onClaimTap.call(rewardLevel),
                          confineInSafeArea: false,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: levelLeftPadding,
            child: Container(
              clipBehavior: Clip.none,
              width: levelWidth,
              child: Transform.scale(
                scale: 1.1,
                child: GreyColorFiltered(
                  child: Image.asset(
                    "assets/icons/rank1.png",
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  String _getSubtitle() {
    if (rewardLevel.isClaimed) {
      return "completed".tr();
    }
    if (rewardLevel.isAchieved) {
      return rewardLevel.neededPoints == null
          ? ""
          : "nextRewardPoints".tr(args: [rewardLevel.neededPoints.toString()]);
    }
    return "unlockFirst".tr();
  }
}
