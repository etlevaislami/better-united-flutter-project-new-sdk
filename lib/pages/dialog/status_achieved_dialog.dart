import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/data/model/reward_level.dart';
import 'package:flutter_better_united/widgets/achievement_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/app_colors.dart';
import '../../widgets/button.dart';

class StatusAchievedDialog extends StatelessWidget {
  const StatusAchievedDialog({
    Key? key,
    required this.rewardLevel,
  }) : super(key: key);
  final RewardLevel rewardLevel;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      child: SizedBox(
        width: double.infinity,
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Align(
                alignment: const FractionalOffset(0.5, -0.4),
                child: SvgPicture.asset("assets/icons/ic_shimmer.svg",
                    width: context.width),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: const FractionalOffset(0.5, -0.5),
                child: SvgPicture.asset(
                  "assets/icons/ic_modal_icon_background",
                  height: context.width * 0.7,
                ),
              ),
            ),
            Positioned(
              child: Container(
                padding: const EdgeInsets.only(
                    left: 20, top: 70, right: 20, bottom: 0),
                margin: const EdgeInsets.only(top: 76.5, right: 35, left: 35),
                width: context.width,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "statusAchieved".tr(),
                      style: context.titleLarge,
                    ),
                    const SizedBox(
                      height: 19,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: AppColors.dollarBill,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      padding: const EdgeInsets.all(14),
                      child: Text(
                        rewardLevel.title,
                        style:
                            context.titleMedium?.copyWith(color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    Text(
                      "rewardReceived".tr(),
                      style: context.titleLarge?.copyWith(fontSize: 14),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      height: 110,
                      decoration: const BoxDecoration(
                        color: AppColors.bleachedSilk,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: LayoutBuilder(
                        builder: (p0, p1) => SizedBox(
                          width: p1.maxWidth / 2,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              rewardLevel.tipRevealCount == null
                                  ? const SizedBox()
                                  : Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 6.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          SvgPicture.asset(
                                            "assets/icons/ic_chat_bubble.svg",
                                            width: 20,
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            "tipRevealCount".plural(
                                                rewardLevel.tipRevealCount!),
                                            style: context.bodySmall,
                                          )
                                        ],
                                      ),
                                    ),
                              rewardLevel.powerUpCount == null
                                  ? const SizedBox()
                                  : Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 6.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          SvgPicture.asset(
                                            "assets/icons/ic_exp.svg",
                                            width: 20,
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            "powerUpCount".plural(
                                                rewardLevel.powerUpCount!),
                                            style: context.bodySmall,
                                          )
                                        ],
                                      ),
                                    ),
                              rewardLevel.coinCount == null
                                  ? const SizedBox()
                                  : Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 6.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          SvgPicture.asset(
                                            "assets/images/ic_coin.svg",
                                            width: 20,
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                              "coinCount".plural(
                                                  rewardLevel.coinCount!),
                                              style: context.bodySmall)
                                        ],
                                      ),
                                    )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Button(
                      foregroundColor: AppColors.forgedSteel,
                      backgroundColor: AppColors.goldenHandshake,
                      text: "ok".tr(),
                      onPressed: () => context.pop(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 35,
              left: 0,
              right: 0,
              child: Align(
                child: AchievementWidget(
                  levelNumber: rewardLevel.level,
                  ratio: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
