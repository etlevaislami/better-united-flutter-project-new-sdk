import 'dart:async';

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/constants/app_colors.dart';
import 'package:flutter_better_united/data/model/team_of_week.dart';
import 'package:flutter_better_united/data/net/interceptors/error_interceptor.dart';
import 'package:flutter_better_united/figma/dimensions.dart';
import 'package:flutter_better_united/pages/ranking/ranking_provider.dart';
import 'package:flutter_better_united/pages/ranking/team_of_week/ranking_field.dart';
import 'package:flutter_better_united/pages/ranking/team_of_week/team_of_week_app_bar_message.dart';
import 'package:flutter_better_united/pages/shop/user_provider.dart';
import 'package:flutter_better_united/util/ui_util.dart';
import 'package:flutter_better_united/widgets/coin_action_button.dart';
import 'package:flutter_better_united/widgets/primary_button.dart';
import 'package:flutter_better_united/widgets/regular_app_bar.dart';
import 'package:flutter_better_united/widgets/user_coins.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class TeamOfWeekWeeklyRankDialog extends StatefulWidget {
  const TeamOfWeekWeeklyRankDialog({
    Key? key,
    required this.teamOfWeek,
    this.onDismissed,
  }) : super(key: key);

  final TeamOfWeek teamOfWeek;
  final Function? onDismissed;

  @override
  State<TeamOfWeekWeeklyRankDialog> createState() =>
      _TeamOfWeekWeeklyRankDialogState();
}

class _TeamOfWeekWeeklyRankDialogState
    extends State<TeamOfWeekWeeklyRankDialog> {
  late final int _connectedUserId;
  final _coinAnimationCompleter = Completer<void>();

  @override
  void initState() {
    _connectedUserId = context.read<UserProvider>().user?.userId ?? -1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool isCurrentUserInTop = widget.teamOfWeek.team
            .map((e) => e.userId)
            .contains(_connectedUserId) ==
        true;

    return WillPopScope(
      onWillPop: () async {
        _acknowledgeReward((widget.teamOfWeek.amountToClaim ?? 0).toInt());
        return false;
      },
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),

          /// hier dus niet
        ),
        insetPadding: const EdgeInsets.symmetric(vertical: 12),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: SizedBox(
          width: context.width * 0.9,
          child: Stack(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 50),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: const Color(0xff1D1D1D),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.grey900,
                      width: 5,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: RegularAppBarV7(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24.0, vertical: 44),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: TeamOfWeekAppBarMessage(
                                subTitle: 'topElevenPlayersOfTheWeek'.tr(),
                                title: isCurrentUserInTop
                                    ? "teamOfTheWeekCongratulations".tr()
                                    : "teamOfTheWeekNotIncluded".tr(),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: AppDimensions.teamOfWeekAppBarHeight,
                          bottom: AppDimensions.coinButtonHeight + 48.0,
                        ),
                        child: RankingField(
                          rankings: widget.teamOfWeek.team,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 12.0),
                            child: widget.teamOfWeek.hasUnclaimedPrize &&
                                    (widget.teamOfWeek.amountToClaim ?? 0) > 0
                                ? CoinActionButton(
                                    confineInSafeArea: false,
                                    text:
                                        "teamOfTheWeekDialogCollectReward".tr(),
                                    amount: widget.teamOfWeek.amountToClaim
                                            ?.toInt() ??
                                        0,
                                    onPressed: () async {
                                      _acknowledgeReward(
                                          (widget.teamOfWeek.amountToClaim ?? 0)
                                              .toInt());
                                    },
                                  )
                                : PrimaryButton(
                                    confineInSafeArea: false,
                                    text: "teamOfTheWeekDialogClose".tr(),
                                    onPressed: () {
                                      _acknowledgeReward(
                                          (widget.teamOfWeek.amountToClaim ?? 0)
                                              .toInt());
                                    })),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                  right: 10,
                  child: UserCoins(onAnimationEnd: () {
                    _coinAnimationCompleter.complete();
                  })),
              if (isCurrentUserInTop)
                IgnorePointer(
                  child: Lottie.asset(
                    'assets/animations/confetti.json',
                    repeat: false,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _acknowledgeReward(int coins) async {
    beginLoading();

    try {
      /// Make the claimReward call always (to acknowledge) when dialog is shown, even if there is no prize.
      await context.read<RankingProvider>().claimTeamOfWeekReward();
      if (coins > 0) {
        context.read<UserProvider>().addUserCoins(coins);
        endLoading();
        await _coinAnimationCompleter.future;
      }
    } on NotFoundException {
      // Error will be returned by API if there is no reward to claim
      // (DioError ║ Status: 404 Not Found - error: "not_found_no_rewards_to_claim"
      // This can be ignored.
    } finally {
      endLoading();
      context.pop();
    }
  }
}
