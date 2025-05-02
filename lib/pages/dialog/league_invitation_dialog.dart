import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/constants/extended_theme.dart';
import 'package:flutter_better_united/pages/poules/invite_friend_provider.dart';
import 'package:flutter_better_united/pages/poules/poule_page.dart';
import 'package:flutter_better_united/pages/poules/poules_provider.dart';
import 'package:flutter_better_united/pages/poules/public_poule_preview_page.dart';
import 'package:flutter_better_united/pages/shop/user_provider.dart';
import 'package:flutter_better_united/util/exceptions/custom_exceptions.dart';
import 'package:flutter_better_united/util/extensions/int_extension.dart';
import 'package:flutter_better_united/widgets/user_coins.dart';
import 'package:provider/provider.dart';

import '../../data/enum/poule_type.dart';
import '../../figma/colors.dart';
import '../../figma/text_styles.dart';
import '../../util/betterUnited_icons.dart';
import '../../util/ui_util.dart';
import '../../widgets/base_dialog.dart';
import '../../widgets/coin_action_button.dart';
import '../../widgets/friend_poule_placeholder.dart';
import '../../widgets/league_icon.dart';
import '../../widgets/poule_card_detail.dart';
import '../../widgets/rounded_container.dart';
import '../../widgets/secondary_button.dart';
import '../poules/friend_poule_preview_page.dart';
import '../shop/shop_page.dart';
import 'no_coins_dialog.dart';

class LeagueInvitationDialog extends StatelessWidget {
  LeagueInvitationDialog({
    Key? key,
    required this.leagueId,
    required this.nickname,
    required this.leagueName,
    required this.prizePool,
    required this.pouleType,
    required this.entryFee,
    this.logoUrl,
    required this.isSelfInvite,
  }) : super(key: key);
  final int leagueId;
  final String nickname;
  final String leagueName;
  final int prizePool;
  final PouleType pouleType;
  final String? logoUrl;
  final int entryFee;
  final bool isSelfInvite;
  final _coinAnimationCompleter = Completer<void>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => InviteFriendProvider(
        context.read(),
        context.read(),
        context.read(),
        context.read(),
        leagueId: leagueId,
        leagueName: leagueName,
        pouleType: pouleType,
        poolPrize: prizePool,
        leagueIconUrl: logoUrl,
        entryFee: entryFee,
      ),
      builder: (context, child) {
        return Stack(
          children: [
            BaseDialog(
              positionMultiplier: 1,
              withConfetti: false,
              withAnimation: true,
              icon: Transform.translate(
                offset: const Offset(0, -20),
                child: Transform.scale(
                    scale: 1.2,
                    child: pouleType == PouleType.friend
                        ? const FriendPoulePlaceHolder()
                        : pouleType == PouleType.public
                            ? LeagueIconWithPlaceholder(
                                logoUrl: logoUrl,
                              )
                            : const SizedBox()),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(
                    height: 18,
                  ),
                  Text("youAreInvited".tr().toUpperCase(),
                      style: context.titleH1White),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: nickname,
                              style: context.bodyBold
                                  .copyWith(color: Colors.white)),
                          const TextSpan(
                            text: " ",
                          ),
                          TextSpan(
                            text: "hasInvitedYou".tr(),
                          ),
                          const TextSpan(
                            text: " ",
                          ),
                          TextSpan(
                              text: leagueName,
                              style: context.bodyBold
                                  .copyWith(color: Colors.white)),
                          const TextSpan(
                            text: " ",
                          ),
                          TextSpan(
                            text: "league".tr().toLowerCase(),
                          ),
                          const TextSpan(
                            text: ".",
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: _PouleCard(
                      onPouleDetailTap: () {
                        if (pouleType == PouleType.friend) {
                          Navigator.of(context).push(
                            FriendPoulePreviewPage.route(
                              isFromOverview: false,
                              pouleId: leagueId,
                            ),
                          );
                        } else if (pouleType == PouleType.public) {
                          Navigator.of(context).push(
                            PublicPoulePreviewPage.route(
                              pouleId: leagueId,
                            ),
                          );
                        }
                      },
                      daysLeftToJoin: -1,
                      icon: pouleType == PouleType.public
                          ? LeagueIconWithPlaceholder(logoUrl: logoUrl)
                          : const FriendPoulePlaceHolder(),
                      pouleName: leagueName,
                      prizePool: prizePool,
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: CoinActionButton(
                        confineInSafeArea: false,
                        text: "joinThisPoule".tr(),
                        amount: entryFee,
                        onPressed: () async {
                          _acceptInvitation(context);
                        },
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  SecondaryButton.labelText(
                    "decline".tr(),
                    withUnderline: true,
                    onPressed: () => _declineInvitation(context),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            Positioned(
                right: 20,
                child: UserCoins(
                    backgroundColor: AppColors.secondary,
                    onAnimationEnd: () {
                      _coinAnimationCompleter.complete();
                    }))
          ],
        );
      },
    );
  }

  _acceptInvitation(BuildContext context) async {
    final inviteFriendProvider = context.read<InviteFriendProvider>();
    try {
      beginLoading();
      await inviteFriendProvider.acceptInvite(leagueId, isSelfInvite);
      context.read<UserProvider>().removeUserCoins(entryFee);
      endLoading();
      hiddenLoading();
      await _coinAnimationCompleter.future;
      endLoading();
      context.read<PoulesProvider>().fetchActivePoules();
      Navigator.pop(context);
      Navigator.of(context)
          .push(PoulePage.route(pouleId: leagueId, type: pouleType));
    } on InviteAlreadyAcceptedOrDeclined {
      showError("invitationHandled".tr());
      Navigator.pop(context);
    } on PouleNotFound {
      showError("pouleNotFound".tr());
      Navigator.pop(context);
    } on MatchAlreadyInProgress {
      showError("matchAlreadyStarted".tr());
      Navigator.pop(context);
    } on NotEnoughCoinsException {
      NoCoinsDialog.displayDialog(context, onShopTap: () {
        Navigator.of(context).push(ShopPage.route(withBackButton: true));
      }, onBackPress: () {
        context.pop();
      }, message: "topUpCoinsBeforeJoining".tr());
    } catch (exception) {
      showGenericError(exception);
    } finally {
      endLoading();
    }
  }

  _declineInvitation(BuildContext context) async {
    context.read<InviteFriendProvider>().declineInvite(leagueId);
    Navigator.pop(context);
  }
}

//@re-use with join poule screen
class _PouleCard extends StatelessWidget {
  const _PouleCard(
      {required this.pouleName,
      required this.prizePool,
      required this.daysLeftToJoin,
      required this.icon,
      this.onPouleDetailTap});

  final String pouleName;
  final int prizePool;
  final int daysLeftToJoin;
  final Widget icon;
  final GestureTapCallback? onPouleDetailTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: PouleCardWidget(
        childFlexValue: 3,
        image: icon,
        isActive: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              pouleName,
              style: context.titleH2.copyWith(color: Colors.white),
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              children: [
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: context.labelBold.copyWith(color: Colors.white),
                      children: [
                        TextSpan(
                            text: "prizePool".tr(),
                            style: context.labelBold
                                .copyWith(color: Colors.white)),
                        const TextSpan(text: ": "),
                        TextSpan(
                            text: prizePool.formatNumber(),
                            style: context.labelBold
                                .copyWith(color: AppColors.primary)),
                        WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: Image.asset(
                              "assets/icons/ic_coins.png",
                              height: 24,
                            )),
                      ],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 14,
            ),
            GestureDetector(
              onTap: onPouleDetailTap,
              child: RoundedContainer(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      BetterUnited.info,
                      size: 16,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: AutoSizeText(
                        "checkPouleDetails".tr(),
                        minFontSize: 1,
                        maxLines: 1,
                        style: AppTextStyles.labelSemiBoldItalic,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
