import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/constants/extended_theme.dart';
import 'package:flutter_better_united/data/enum/tip_settlement.dart';
import 'package:flutter_better_united/data/model/team.dart';
import 'package:flutter_better_united/data/model/tip_revealed_detail.dart';
import 'package:flutter_better_united/data/model/unacknowledged_tip.dart';
import 'package:flutter_better_united/figma/colors.dart';
import 'package:flutter_better_united/pages/dialog/user_xp_progress_indicator.dart';
import 'package:flutter_better_united/pages/shop/user_provider.dart';
import 'package:flutter_better_united/util/navigation_service.dart';
import 'package:flutter_better_united/util/tip_settlement_provider.dart';
import 'package:flutter_better_united/widgets/friend_poule_icon_with_name.dart';
import 'package:flutter_better_united/widgets/full_screen_base_dialog.dart';
import 'package:flutter_better_united/widgets/league_icon.dart';
import 'package:flutter_better_united/widgets/prediction_result_card.dart';
import 'package:flutter_better_united/widgets/primary_button.dart';
import 'package:flutter_better_united/widgets/team_icon.dart';
import 'package:flutter_better_united/widgets/user_coins.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../data/model/rewards.dart';

class TipResultDialog extends StatefulWidget {
  TipResultDialog({
    Key? key,
    this.unclaimedTip,
    required this.tipSettlement,
    required this.tipId,
  }) : super(key: key) {
    isTipWon = tipSettlement == TipSettlement.won;
  }

  final int tipId;
  final TipSettlement tipSettlement;
  late final bool isTipWon;
  final UnacknowledgedTip? unclaimedTip;

  @override
  State<TipResultDialog> createState() => _TipResultDialogState();
}

class _TipResultDialogState extends State<TipResultDialog> {
  @override
  void initState() {
    super.initState();
    if (widget.isTipWon) {
      int addedCoins = widget.unclaimedTip?.rewards.coinReward ?? 0;
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        context.read<UserProvider>().addUserCoins(addedCoins);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        final tipSettlementProvider = TipSettlementProvider(context.read(),
            unacknowledgedTip: widget.unclaimedTip);

        if (widget.unclaimedTip == null) {
          tipSettlementProvider.fetchUnacknowledgedTip(widget.tipId);
        }

        return tipSettlementProvider;
      },
      builder: (context, child) {
        final unclaimedTip =
            context.watch<TipSettlementProvider>().unacknowledgedTip;

        return WillPopScope(
          onWillPop: () async {
            _acknowledgeTip(context);
            return false;
          },
          child: Stack(
            children: [
              FullscreenBaseDialog(
                icon: unclaimedTip?.tipDetail.isPublicPoule == true
                    ? LeagueIconWithPlaceholder(
                        logoUrl: unclaimedTip?.tipDetail.pouleIconUrl,
                      )
                    : FriendPouleIconWithName(
                        name: unclaimedTip?.tipDetail.pouleName),
                withAnimation: widget.isTipWon,
                withConfetti: widget.isTipWon,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.only(top: 70),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxHeight: MediaQuery.of(context)
                                  .size
                                  .height, // Limits max height
                            ),
                            child: _scrollableContent(context, unclaimedTip),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: PrimaryButton(
                            onPressed: unclaimedTip == null
                                ? null
                                : () => _acknowledgeTip(context),
                            text: "getReward".tr()),
                      )
                    ],
                  ),
                ),
                expandChild: false,
                bottomPadding: 10,
              ),
              widget.isTipWon
                  ? const Positioned(right: 20, child: UserCoins())
                  : const SizedBox()
            ],
          ),
        );
      },
    );
  }

  _acknowledgeTip(BuildContext context) async {
    context.read<TipSettlementProvider>().acknowledgeTip(widget.tipId);
    context.read<NavigationService>().pendingPushNotification = false;
    context.pop();
  }

  _scrollableContent(BuildContext context, UnacknowledgedTip? unclaimedTip) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          (widget.isTipWon ? "predictionWon".tr() : "predictionLost".tr())
              .toUpperCase(),
          style: context.titleH1White.copyWith(
            shadows: [
              Shadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 16,
                offset: const Offset(0, 2),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _ScoreWidget(
                awayTeamName: unclaimedTip?.tipDetail.awayTeam.name ?? "",
                homeTeamName: unclaimedTip?.tipDetail.homeTeam.name ?? "",
                awayTeamScore: unclaimedTip?.tipDetail.awayTeamScore ?? -1,
                homeTeamScore: unclaimedTip?.tipDetail.homeTeamScore ?? -1,
                awayTeamLogoUrl: unclaimedTip?.tipDetail.awayTeam.logoUrl,
                homeTeamLogoUrl: unclaimedTip?.tipDetail.homeTeam.logoUrl)
          ],
        ),
        const SizedBox(
          height: 32,
        ),
        SizedBox(
          height: 100,
          child: PredictionResultCard(
            tipSettlement: widget.tipSettlement,
            points: unclaimedTip?.rewards.tipPoints ?? 0,
            odd: unclaimedTip == null ? "" : unclaimedTip.tipDetail.hint,
            isVoided: false,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          "rewards".tr().toUpperCase(),
          style: context.titleH2.copyWith(color: Colors.white),
        ),
        const SizedBox(
          height: 16,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: const BoxDecoration(
            color: Color(0xff1D1D1D),
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      (widget.isTipWon
                              ? "pointsToXp".tr()
                              : "losingPrediction".tr())
                          .toUpperCase(),
                      style: context.labelBold.copyWith(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    "rewardInXp".tr(args: [
                      (unclaimedTip?.rewards.xpReward ?? 0).toString()
                    ]),
                    style: context.bodyBold.copyWith(color: AppColors.primary),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              LayoutBuilder(builder: (context, constraints) {
                return SizedBox(
                    width: constraints.maxWidth * 0.8,
                    child: const UserXpProgressIndicator());
              }),
              widget.isTipWon
                  ? Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "winningPrediction".tr().toUpperCase(),
                              style: context.labelBold
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          SvgPicture.asset(
                            "assets/figma/svg/components/exported_icons/ic_coinwallet.svg",
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            (unclaimedTip?.rewards.coinReward ?? 0).toString(),
                            style: context.bodyBold
                                .copyWith(color: AppColors.primary),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
        const SizedBox(
          height: 25,
        ),
      ],
    );
  }
}

class _ScoreWidget extends StatelessWidget {
  final String homeTeamName;
  final String awayTeamName;
  final String? homeTeamLogoUrl;
  final String? awayTeamLogoUrl;
  final int homeTeamScore;
  final int awayTeamScore;

  const _ScoreWidget(
      {Key? key,
      required this.homeTeamName,
      required this.awayTeamName,
      required this.homeTeamScore,
      required this.awayTeamScore,
      this.homeTeamLogoUrl,
      this.awayTeamLogoUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TeamIcon(
                  invertColor: true,
                  logoUrl: homeTeamLogoUrl,
                ),
              ],
            )),
            Expanded(
                child: Row(children: [
              Expanded(
                child: Text(
                  homeTeamScore.toString(),
                  style: context.titleH1White.copyWith(fontSize: 50),
                ),
              ),
              Expanded(
                child: Text(
                  "-".tr(),
                  textAlign: TextAlign.center,
                  style: context.titleH1White,
                ),
              ),
              Expanded(
                child: Text(
                  awayTeamScore.toString(),
                  style: context.titleH1White.copyWith(fontSize: 50),
                ),
              ),
            ])),
            Expanded(
                child: Container(
                    alignment: Alignment.center,
                    child: TeamIcon(
                      invertColor: true,
                      logoUrl: awayTeamLogoUrl,
                    )))
          ],
        ),
        Row(
          children: [
            Expanded(
                child: Text(
              homeTeamName,
              textAlign: TextAlign.center,
              style: context.bodyBold.copyWith(color: Colors.white),
            )),
            const Spacer(),
            Expanded(
                child: Text(
              awayTeamName,
              textAlign: TextAlign.center,
              style: context.bodyBold.copyWith(color: Colors.white),
            )),
          ],
        )
      ],
    );
  }
}
