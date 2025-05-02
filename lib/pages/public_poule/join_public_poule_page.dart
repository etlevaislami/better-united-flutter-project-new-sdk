import 'dart:async';

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:easy_localization/easy_localization.dart' as easy_localization;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/constants/extended_theme.dart';
import 'package:flutter_better_united/data/model/public_league_join_info.dart';
import 'package:flutter_better_united/pages/nav_page.dart';
import 'package:flutter_better_united/pages/poules/poule_page.dart';
import 'package:flutter_better_united/pages/public_poule/public_poule_provider.dart';
import 'package:flutter_better_united/util/ui_util.dart';
import 'package:flutter_better_united/widgets/prize_poule_text.dart';
import 'package:flutter_better_united/widgets/regular_app_bar.dart';
import 'package:flutter_better_united/widgets/rules_widget.dart';
import 'package:flutter_better_united/widgets/trophy_pedestal.dart';
import 'package:flutter_better_united/widgets/user_coins.dart';
import 'package:provider/provider.dart';

import '../../data/enum/poule_type.dart';
import '../../figma/colors.dart';
import '../../util/exceptions/custom_exceptions.dart';
import '../../widgets/available_leagues_widget.dart';
import '../../widgets/available_matches_widget.dart';
import '../../widgets/coin_action_button.dart';
import '../../widgets/league_icon.dart';
import '../dialog/no_coins_dialog.dart';
import '../dialog/welcome_to_poule_dialog.dart';
import '../poules/invite_friends_page.dart';
import '../poules/poules_provider.dart';
import '../shop/shop_page.dart';

class JoinPublicPoulePage extends StatefulWidget {
  const JoinPublicPoulePage(
      {Key? key, required this.poule, required this.provider})
      : super(key: key);
  final PublicLeagueJoinInfo poule;
  final PublicPouleProvider provider;

  @override
  State<JoinPublicPoulePage> createState() => _JoinPublicPoulePageState();

  static Route route(
      {required PublicPouleProvider provider,
      required PublicLeagueJoinInfo poule}) {
    return CupertinoPageRoute(
        builder: (_) => JoinPublicPoulePage(
              poule: poule,
              provider: provider,
            ));
  }
}

class _JoinPublicPoulePageState extends State<JoinPublicPoulePage> {
  final _coinAnimationCompleter = Completer<void>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: RegularAppBarV5(
        icon: LeagueIconWithPlaceholder(
          logoUrl: widget.poule.iconUrl,
        ),
        title: "pouleOverview".tr(),
        onCloseTap: () {
          Navigator.of(context)
              .popUntil((route) => route.settings.name == NavPage.route);
        },
        onBackTap: () {
          context.pop();
        },
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 15),
        decoration: BoxDecoration(
          color: AppColors.secondary,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 0,
              blurRadius: 24,
              offset: const Offset(0, -2), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "youHave".tr().toUpperCase(),
                  style: context.bodyBold,
                ),
                UserCoins(
                  onAnimationEnd: () {
                    _coinAnimationCompleter.complete();
                  },
                )
              ],
            ),
            CoinActionButton(
              confineInSafeArea: true,
              text: "joinThisPoule".tr(),
              amount: widget.poule.joinFee,
              onPressed: () async {
                try {
                  await widget.provider.joinPoule(widget.poule);
                  context.read<PoulesProvider>().fetchActivePoules();
                  hiddenLoading();
                  await _coinAnimationCompleter.future;
                  endLoading();
                  final result = await WelcomeToPouleDialog.displayDialog(
                      context,
                      pouleName: widget.poule.name);
                  if (result is WelcomeToPouleDialogAction) {
                    switch (result) {
                      case WelcomeToPouleDialogAction.challengeFriends:
                        await Navigator.of(context)
                            .push(InviteFriendsPage.route(
                          withCloseButton: false,
                          pouleId: widget.poule.id,
                          pouleName: widget.poule.name,
                          pouleType: PouleType.public,
                          leagueLogoUrl: widget.poule.iconUrl,
                          poolPrize: widget.poule.poolPrize,
                          entryFee: widget.poule.joinFee,
                        ));

                        Navigator.of(context).pushAndRemoveUntil(
                            PoulePage.route(
                                pouleId: widget.poule.id,
                                type: PouleType.public),
                            (route) => route.settings.name == NavPage.route);
                        break;
                      case WelcomeToPouleDialogAction.backToOverview:
                        Navigator.of(context).pushAndRemoveUntil(
                            PoulePage.route(
                                pouleId: widget.poule.id,
                                type: PouleType.public),
                            (route) => route.settings.name == NavPage.route);
                        break;
                    }
                  }
                } on NotEnoughCoinsException {
                  NoCoinsDialog.displayDialog(context, onShopTap: () {
                    Navigator.of(context)
                        .push(ShopPage.route(withBackButton: true));
                  }, onBackPress: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  }, message: "topUpCoinsBeforeJoining".tr());
                }
              },
            )
          ],
          mainAxisSize: MainAxisSize.min,
        ),
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
            top: RegularAppBarV5.appBarHeight, bottom: 24),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  PrizePouleText(
                    amount: widget.poule.poolPrize,
                    text: "prizePool".tr(),
                    backgroundColor: AppColors.background,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TrophyPedestal(
                      coinsForFirst: widget.poule.coinsForFirst,
                      coinsForSecond: widget.poule.coinsForSecond,
                      coinsForThird: widget.poule.coinsForThird,
                      coinsForOthers: widget.poule.coinsForOthers),
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            const RulesWidget(),
            const SizedBox(
              height: 40,
            ),
            AvailableLeaguesWidget(
              leagues: widget.poule.leagues,
            ),
            AvailableMatchesWidget(
              matches: widget.poule.matches,
            )
          ],
        ),
      ),
    );
  }
}
