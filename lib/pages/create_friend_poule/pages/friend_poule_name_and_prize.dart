import 'dart:async';
import 'dart:ui' as ui;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/constants/extended_theme.dart';
import 'package:flutter_better_united/figma/colors.dart';
import 'package:flutter_better_united/util/extensions/int_extension.dart';
import 'package:flutter_better_united/util/ui_util.dart';
import 'package:flutter_better_united/widgets/coin_action_button.dart';
import 'package:flutter_better_united/widgets/info_bubble.dart';
import 'package:flutter_better_united/widgets/input_field.dart';
import 'package:flutter_better_united/widgets/match_card.dart';
import 'package:provider/provider.dart';

import '../../../data/enum/poule_type.dart';
import '../../../util/exceptions/custom_exceptions.dart';
import '../../../widgets/user_coins.dart';
import '../../dialog/no_coins_dialog.dart';
import '../../nav_page.dart';
import '../../poules/friend_poule_preview_page.dart';
import '../../poules/invite_friends_page.dart';
import '../../poules/poule_page.dart';
import '../../poules/poules_provider.dart';
import '../../shop/shop_page.dart';
import '../create_friend_poule_provider.dart';

class FriendPouleNameAndPrize extends StatefulWidget {
  const FriendPouleNameAndPrize({Key? key}) : super(key: key);

  @override
  State<FriendPouleNameAndPrize> createState() =>
      _FriendPouleNameAndPrizeState();
}

class _FriendPouleNameAndPrizeState extends State<FriendPouleNameAndPrize> {
  final TextEditingController _nameController = TextEditingController();
  final _coinAnimationCompleter = Completer<void>();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _nameController.text =
        context.read<CreateFriendPouleProvider>().pouleName ?? "";
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CreateFriendPouleProvider>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _Subtitle(text: "friendPouleName".tr()),
                  const SizedBox(
                    height: 16,
                  ),
                  InputField(
                    hintText: "friendPouleHint".tr(),
                    errorText: provider.pouleNameValidationError,
                    allocateSpaceForTextError: false,
                    controller: _nameController,
                    onChanged: (value) {
                      provider.onPouleNameChanged(value);
                    },
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  _Subtitle(text: "selectMatch".tr()),
                  const SizedBox(
                    height: 16,
                  ),
                  const _SelectedMatchCard(),
                  const SizedBox(
                    height: 24,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: AppColors.secondary,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              color: AppColors.background,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Text(
                    "currentPrizePoule".tr().toUpperCase(),
                    style: context.titleH2.copyWith(color: Colors.white),
                  )),
                  RichText(
                    textDirection: ui.TextDirection.rtl,
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: Image.asset(
                              "assets/icons/ic_coins.png",
                              height: 24,
                            )),
                        TextSpan(
                            text: provider.selectedPrizePool.formatNumber(),
                            style: context.bodyBold
                                .copyWith(color: AppColors.primary)),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
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
            ),
            const Divider(
              height: 1,
              color: AppColors.buttonInnactive,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: InfoBubble(
                backgroundColor: AppColors.background,
                description: "friendPoulePrizeDisclaimer".tr(),
              ),
            ),
            SizedBox(
              height: 40,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final prizePouleAmount = provider.prizePools[index];
                  return GestureDetector(
                    onTap: () {
                      provider.onPrizePoolSelected(index);
                    },
                    child: _SelectableCoins(
                      isSelected: index == provider.selectedPrizePoolIndex,
                      amount: prizePouleAmount,
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    width: 12,
                  );
                },
                itemCount: provider.prizePools.length,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: CoinActionButton(
                  text: "createPoule".tr(),
                  amount: provider.selectedPrizePool,
                  onPressed: _onCreatePouleTap),
            ),
          ],
        ),
      ),
    );
  }

  _onCreatePouleTap() async {
    final provider = context.read<CreateFriendPouleProvider>();
    try {
      final pouleId = await provider.onCreatePoule();
      hiddenLoading();
      context.read<PoulesProvider>().fetchActivePoules();
      await _coinAnimationCompleter.future;
      endLoading();
      await Navigator.of(context).push(FriendPoulePreviewPage.route(
        isFromOverview: false,
        pouleId: pouleId,
        data: FriendPoulePreviewData(
            match: provider.selectedMatch!,
            pouleName: provider.pouleName!,
            poolPrize: provider.selectedPrizePool),
      ));

      await Navigator.of(context).push(InviteFriendsPage.route(
          pouleId: pouleId,
          pouleName: provider.pouleName!,
          withCloseButton: false,
          pouleType: PouleType.friend,
          poolPrize: provider.selectedPrizePool,
          leagueLogoUrl: null,
          entryFee: provider.selectedPrizePool));

      Navigator.of(context).pushAndRemoveUntil(
          PoulePage.route(
            pouleId: pouleId,
            type: PouleType.friend,
          ),
          (route) => route.settings.name == NavPage.route);
    } on NotEnoughCoinsException {
      NoCoinsDialog.displayDialog(context, onShopTap: () {
        Navigator.of(context).push(ShopPage.route(withBackButton: true));
      }, onBackPress: () {
        context.pop();
      }, message: "topUpCoinsFriendsLeague".tr());
    }
  }
}

class _SelectableCoins extends StatelessWidget {
  const _SelectableCoins({
    super.key,
    required this.isSelected,
    required this.amount,
  });

  final bool isSelected;
  final int amount;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 85,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
          border: Border.all(
              color: isSelected ? AppColors.primary : Colors.transparent,
              width: 1),
          color: AppColors.background,
          borderRadius: BorderRadius.circular(4),
          gradient: isSelected
              ? LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                      AppColors.textBlack,
                      AppColors.primary.withOpacity(0.4)
                    ])
              : null),
      child: Row(
        children: [
          Image.asset(
            "assets/icons/ic_coins.png",
            height: 24,
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: AutoSizeText(
              amount.toString(),
              style: context.titleH2.copyWith(color: Colors.white),
              maxLines: 1,
              minFontSize: 1,
            ),
          )
        ],
      ),
    );
  }
}

class _SelectedMatchCard extends StatelessWidget {
  const _SelectedMatchCard({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CreateFriendPouleProvider>();
    final selectedMatch = provider.selectedMatch;
    return selectedMatch != null
        ? MatchCard(
            matchDate: selectedMatch.startsAt,
            homeTeam: selectedMatch.homeTeam,
            awayTeam: selectedMatch.awayTeam)
        : const SizedBox();
  }
}

class _Subtitle extends StatelessWidget {
  const _Subtitle({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
            fontSize: 14,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w700,
            color: Colors.white),
      ),
    );
  }
}
