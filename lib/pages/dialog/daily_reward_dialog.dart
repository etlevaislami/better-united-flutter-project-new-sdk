import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/constants/extended_theme.dart';
import 'package:flutter_better_united/data/model/daily_rewards.dart';
import 'package:flutter_better_united/figma/colors.dart';
import 'package:flutter_better_united/figma/shadows.dart';
import 'package:flutter_better_united/figma/text_styles.dart';
import 'package:flutter_better_united/util/betterUnited_icons.dart';
import 'package:flutter_better_united/util/extensions/int_extension.dart';
import 'package:flutter_better_united/util/ui_util.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../data/repo/profile_repository.dart';
import '../../util/dialog_manager.dart';
import '../../widgets/fixed_button.dart';
import '../../widgets/full_screen_base_dialog.dart';
import '../../widgets/user_coins.dart';
import '../shop/user_provider.dart';

class DailyRewardDialog extends StatefulWidget {
  const DailyRewardDialog({Key? key, required this.dailyRewards})
      : super(key: key);
  final DailyRewards dailyRewards;

  static show(BuildContext context, {required DailyRewards dailyRewards}) {
    showFlutterDialog(
        context: context,
        builder: (BuildContext _) {
          return DailyRewardDialog(
            dailyRewards: dailyRewards,
          );
        });
  }

  @override
  State<DailyRewardDialog> createState() => _DailyRewardDialogState();
}

class _DailyRewardDialogState extends State<DailyRewardDialog> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _claimRewardOnExit(context);
        return false;
      },
      child: ChangeNotifierProvider(
        create: (context) => DailyRewardProvider(context.read(), context.read(),
            dailyRewards: widget.dailyRewards),
        builder: (context, child) {
          final rewards = context.watch<DailyRewardProvider>().dailyRewards;
          return Stack(
            children: [
              FullscreenBaseDialog(
                withConfetti: false,
                icon: SvgPicture.asset(
                    "assets/figma/svg/components/exported_icons/ic_dailyreward.svg"),
                withAnimation: true,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            Column(
                              children: [
                                const SizedBox(
                                  height: 52,
                                ),
                                Text("dailyRewards".tr().toUpperCase(),
                                    style: context.titleH2
                                        .copyWith(color: Colors.white)),
                                const SizedBox(
                                  height: 12,
                                ),
                                Expanded(
                                  flex: 3,
                                  child: GridView.count(
                                    crossAxisCount: 3,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    crossAxisSpacing: 12,
                                    mainAxisSpacing: 12,
                                    shrinkWrap: true,
                                    childAspectRatio: 0.66,
                                    children: [
                                      _DailyRewards(
                                        isClaimed:
                                            rewards.dayOneReward.isClaimed,
                                        onTap: () {
                                          context
                                              .read<DailyRewardProvider>()
                                              .claimDayOneReward();
                                        },
                                        isClaimable: rewards.dayOneReward.day ==
                                            rewards.toBeClaimedDayReward.day,
                                        dayNumber: rewards.dayOneReward.day,
                                        coins: rewards.dayOneReward.coins,
                                      ),
                                      _DailyRewards(
                                        onTap: () {
                                          context
                                              .read<DailyRewardProvider>()
                                              .claimDayTwoReward();
                                        },
                                        isClaimed:
                                            rewards.dayTwoReward.isClaimed,
                                        isClaimable: rewards.dayTwoReward.day ==
                                            rewards.toBeClaimedDayReward.day,
                                        dayNumber: rewards.dayTwoReward.day,
                                        coins: rewards.dayTwoReward.coins,
                                      ),
                                      _DailyRewards(
                                        isClaimed:
                                            rewards.dayThreeReward.isClaimed,
                                        onTap: () {
                                          context
                                              .read<DailyRewardProvider>()
                                              .claimDayThreeReward();
                                        },
                                        isClaimable: rewards
                                                .dayThreeReward.day ==
                                            rewards.toBeClaimedDayReward.day,
                                        dayNumber: rewards.dayThreeReward.day,
                                        coins: rewards.dayThreeReward.coins,
                                      ),
                                      _DailyRewards(
                                        isClaimed:
                                            rewards.dayFourReward.isClaimed,
                                        onTap: () {
                                          context
                                              .read<DailyRewardProvider>()
                                              .claimDayFourReward();
                                        },
                                        isClaimable: rewards
                                                .dayFourReward.day ==
                                            rewards.toBeClaimedDayReward.day,
                                        dayNumber: rewards.dayFourReward.day,
                                        coins: rewards.dayFourReward.coins,
                                      ),
                                      _DailyRewards(
                                        isClaimed:
                                            rewards.dayFiveReward.isClaimed,
                                        onTap: () {
                                          context
                                              .read<DailyRewardProvider>()
                                              .claimDayFiveReward();
                                        },
                                        isClaimable: rewards
                                                .dayFiveReward.day ==
                                            rewards.toBeClaimedDayReward.day,
                                        dayNumber: rewards.dayFiveReward.day,
                                        coins: rewards.dayFiveReward.coins,
                                      ),
                                      _DailyRewards(
                                        isClaimed:
                                            rewards.daySixReward.isClaimed,
                                        onTap: () {
                                          context
                                              .read<DailyRewardProvider>()
                                              .claimDaySixReward();
                                        },
                                        isClaimable: rewards.daySixReward.day ==
                                            rewards.toBeClaimedDayReward.day,
                                        dayNumber: rewards.daySixReward.day,
                                        coins: rewards.daySixReward.coins,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    child: _DailyRewardsWide(
                                      onTap: () {
                                        context
                                            .read<DailyRewardProvider>()
                                            .claimDaySevenReward();
                                      },
                                      isClaimed:
                                          rewards.daySevenReward.isClaimed,
                                      isClaimable: rewards.daySevenReward.day ==
                                          rewards.toBeClaimedDayReward.day,
                                      dayNumber: rewards.daySevenReward.day,
                                      coins: rewards.daySevenReward.coins,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                )
                              ],
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: FixedButton(
                                    iconData: BetterUnited.remove,
                                    onTap: () {
                                      _claimRewardOnExit(context);
                                    }),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Positioned(right: 20, child: UserCoins())
            ],
          );
        },
      ),
    );
  }

  _claimRewardOnExit(BuildContext context) {
    if (!widget.dailyRewards.toBeClaimedDayReward.isClaimed) {
      context
          .read<UserProvider>()
          .claimReward(coins: widget.dailyRewards.toBeClaimedDayReward.coins);
    }
    context.pop();
  }
}

class _DailyRewards extends StatelessWidget {
  const _DailyRewards(
      {Key? key,
      required this.isClaimable,
      required this.dayNumber,
      required this.coins,
      required this.onTap,
      required this.isClaimed})
      : super(key: key);
  final bool isClaimable;
  final int dayNumber;
  final int coins;
  final GestureTapCallback? onTap;
  final bool isClaimed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isClaimable ? onTap : null,
      child: Container(
        clipBehavior: Clip.antiAlias,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          gradient: (isClaimable || isClaimed)
              ? const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFA5CE3A),
                    Color(0xff454545),
                  ],
                )
              : null,
          color: const Color(0xff6B6B6B),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: const [AppShadows.dropShadowButton],
            color: const Color(0xff535353),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            children: [
              Expanded(
                  flex: 7,
                  child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: const Color(0xff535353),
                          gradient: isClaimable || isClaimed
                              ? const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Color(0xFFA5CE3A)
                                  ],
                                )
                              : null,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8))),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Opacity(
                            opacity: isClaimed ? 0.5 : 1,
                            child: Image.asset(
                              coins <= 1000
                                  ? "assets/icons/ic-dailyreward-coin1.png"
                                  : "assets/icons/ic-dailyreward-coin2.png",
                              height: 60,
                            ),
                          ),
                          isClaimed
                              ? Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    "claimed".tr().toUpperCase(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                )
                              : Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: AppColors.secondary,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset(
                                        "assets/icons/ic_coins.png",
                                        height: 16,
                                        width: 16,
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        coins.formatNumber(),
                                        style: AppTextStyles.textStyle7,
                                      )
                                    ],
                                  ),
                                )
                        ],
                      ))),
              Expanded(
                  flex: 3,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: AppColors.secondary,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "dayNumber".tr(args: [dayNumber.toString()]),
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: AppTextStyles.textStyle8,
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class _DailyRewardsWide extends StatelessWidget {
  const _DailyRewardsWide(
      {Key? key,
      required this.dayNumber,
      required this.coins,
      required this.isClaimed,
      required this.onTap,
      required this.isClaimable})
      : super(key: key);
  final int dayNumber;
  final int coins;
  final bool isClaimed;
  final GestureTapCallback onTap;
  final bool isClaimable;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isClaimable ? onTap : null,
      child: Container(
        clipBehavior: Clip.antiAlias,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          gradient: (isClaimable || isClaimed)
              ? const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFA5CE3A),
                    Color(0xff454545),
                  ],
                )
              : null,
          color: const Color(0xff6B6B6B),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                boxShadow: const [AppShadows.dropShadowButton],
                color: const Color(0xff535353),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                children: [
                  Expanded(
                      flex: 7,
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.topLeft,
                        decoration: BoxDecoration(
                          color: const Color(0xff535353),
                          gradient: isClaimable || isClaimed
                              ? const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Color(0xFFA5CE3A)
                                  ],
                                )
                              : null,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                        ),
                        child: isClaimed
                            ? Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  "claimed".tr().toUpperCase(),
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              )
                            : Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: AppColors.secondary,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      "assets/icons/ic_coins.png",
                                      height: 16,
                                      width: 16,
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      coins.toString(),
                                      style: AppTextStyles.textStyle7,
                                    )
                                  ],
                                ),
                              ),
                      )),
                  Expanded(
                      flex: 4,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: AppColors.secondary,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "dayNumber".tr(args: [dayNumber.toString()]),
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: AppTextStyles.textStyle8,
                            ),
                          ],
                        ),
                      ))
                ],
              ),
            ),
            Align(
                alignment: Alignment.centerRight,
                child: Transform.scale(
                    scale: 0.9,
                    child:
                        Image.asset("assets/icons/ic-dailyreward-coin3.png")))
          ],
        ),
      ),
    );
  }
}

class DailyRewardProvider with ChangeNotifier {
  final ProfileRepository _profileRepository;
  DailyRewards dailyRewards;
  final UserProvider userProvider;

  DailyRewardProvider(this._profileRepository, this.userProvider,
      {required this.dailyRewards});

  Future _claimDailyReward() async {
    try {
      beginLoading();
      await _profileRepository.claimDailyReward();
      dailyRewards = dailyRewards.copyWith(
          dayOneReward:
              dailyRewards.toBeClaimedDayReward.copyWith(isClaimed: true));
      userProvider.addUserCoins(dailyRewards.toBeClaimedDayReward.coins);
    } catch (e) {
      showError("unknownError".tr());
    } finally {
      endLoading();
    }
  }

  claimDayOneReward() async {
    await _claimDailyReward();
    dailyRewards = dailyRewards.copyWith(
        dayOneReward: dailyRewards.dayOneReward.copyWith(isClaimed: true));
    notifyListeners();
  }

  claimDayTwoReward() async {
    await _claimDailyReward();
    dailyRewards = dailyRewards.copyWith(
        dayTwoReward: dailyRewards.dayTwoReward.copyWith(isClaimed: true));
    notifyListeners();
  }

  claimDayThreeReward() async {
    await _claimDailyReward();
    dailyRewards = dailyRewards.copyWith(
        dayThreeReward: dailyRewards.dayThreeReward.copyWith(isClaimed: true));
    notifyListeners();
  }

  claimDayFourReward() async {
    await _claimDailyReward();
    dailyRewards = dailyRewards.copyWith(
        dayFourReward: dailyRewards.dayFourReward.copyWith(isClaimed: true));
    notifyListeners();
  }

  claimDayFiveReward() async {
    await _claimDailyReward();
    dailyRewards = dailyRewards.copyWith(
        dayFiveReward: dailyRewards.dayFiveReward.copyWith(isClaimed: true));
    notifyListeners();
  }

  claimDaySixReward() async {
    await _claimDailyReward();
    dailyRewards = dailyRewards.copyWith(
        daySixReward: dailyRewards.daySixReward.copyWith(isClaimed: true));
    notifyListeners();
  }

  claimDaySevenReward() async {
    await _claimDailyReward();
    dailyRewards = dailyRewards.copyWith(
        daySevenReward: dailyRewards.daySevenReward.copyWith(isClaimed: true));
    notifyListeners();
  }
}