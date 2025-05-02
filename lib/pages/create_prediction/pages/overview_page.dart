import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/data/enum/tip_settlement.dart';
import 'package:flutter_better_united/pages/create_prediction/modals/confirm_exit_dialog.dart';
import 'package:flutter_better_united/pages/shop/user_provider.dart';
import 'package:flutter_better_united/util/exceptions/custom_exceptions.dart';
import 'package:flutter_better_united/widgets/info_bubble.dart';
import 'package:flutter_better_united/widgets/primary_button.dart';
import 'package:flutter_better_united/widgets/regular_app_bar.dart';
import 'package:provider/provider.dart';

import '../../../util/ui_util.dart';
import '../../../widgets/prediction_card.dart';
import '../../../widgets/prediction_limit_message.dart';
import '../../poules/poules_provider.dart';
import '../create_prediction_provider.dart';
import '../modals/prediction_shared_modal.dart';
import '../modals/reveal_prediction_modal.dart';

/// Overview screen displaying an overview of the selected predictions, before sharing it.
class OverviewPage extends StatefulWidget {
  const OverviewPage({super.key});

  @override
  State<OverviewPage> createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RegularAppBar.withBackButton(
        title: "overview".tr(),
        onBackTap: () {
          context.read<CreatePredictionProvider>().onBackClicked();
        },
        onCloseTap: () {
          showConfirmExitDialog(context);
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: InfoBubble(
                title: "readyToPostPrediction".tr(),
                description: "pleaseCheckYourPrediction".tr(),
              ),
            ),
            const _SelectedPrediction()
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: PrimaryButton(
          text: "sharePrediction".tr(),
          onPressed: _onSharePredictionTap,
        ),
      ),
    );
  }

  _onSharePredictionTap() async {
    try {
      final tipWithPromotedBet =
          await context.read<CreatePredictionProvider>().sharePrediction();
      context.read<PoulesProvider>().fetchActivePoules();
      final promotedBet = tipWithPromotedBet.promotedBet;
      MemoryImage? promotedTipImage;
      final hasBookies = promotedBet != null;
      if (hasBookies) {
        promotedTipImage = await BookieCard.generateImage(
            context, promotedBet.tipImageNL!, promotedBet.tipImageNL!);
      }
      endLoading();
      PredictionSharedDialog.displayDialog(context, onBackToHomeTap: () {
        context.pop();
      }, onGetFreePredictionTap: () async {
        if (promotedTipImage != null && promotedBet != null) {
          await RevealPredictionDialog.show(
            context,
            bookieImage: promotedTipImage,
            promotedBet: promotedBet,
          );
          context.pop();
        }
      }, coins: tipWithPromotedBet.earnedCoins, hasBookies: hasBookies);
    } on PublicLeagueMaximumTipsForMatchReached {
      final maximumTipCountPerMatch = context
          .read<CreatePredictionProvider>()
          .selectedPoule
          ?.publicPouleData
          ?.maximumTipCountPerMatch;

      PredictionLimitMessage.showToast(context,
          maximumTipCountPerMatch: maximumTipCountPerMatch);
    }
  }
}

class _SelectedPrediction extends StatelessWidget {
  const _SelectedPrediction();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CreatePredictionProvider>();
    final user = context.watch<UserProvider>().user;
    final match = provider.selectedMatch;
    if (match == null) {
      return const SizedBox();
    }
    return PredictionCard(
        tipSettlement: TipSettlement.notStarted,
        startsAt: match.startsAt,
        onProfileTap: () {},
        rank: user?.level ?? 0,
        photoUrl: user?.profilePictureUrl,
        points: provider.points ?? 0,
        pouleName: provider.selectedPoule?.name ?? "",
        homeTeam: match.homeTeam,
        awayTeam: match.awayTeam,
        leagueName: "League",
        levelName: user?.rewardTitle ?? "",
        name: user?.nickname ?? "",
        odd: provider.hint ?? "",
        isVoided: false,
        isConnectedUser: false);
  }
}
