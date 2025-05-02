import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/data/enum/poule_type.dart';
import 'package:flutter_better_united/data/net/auth_manager.dart';
import 'package:flutter_better_united/pages/splashscreen/splashscreen.dart';
import 'package:flutter_better_united/util/deeplinks/handlers/deep_link_handler.dart';
import 'package:provider/provider.dart';

import '../../../data/model/league_invitation.dart';
import '../../../pages/dialog/league_invitation_dialog.dart';
import '../../../run.dart';
import '../../settings.dart';
import '../deep_link_manager.dart';

class LeagueInvitationHandler extends DeepLinkHandler {
  final LinkType linkType = LinkType.referral;

  @override
  bool canHandleDeepLink(Uri link) {
    return link.queryParameters.containsKey("type") &&
        link.queryParameters["type"] == linkType.toString();
  }

  @override
  Future<void> handle(BuildContext context, Uri uri, bool isInitial) async {
    final queryParams = uri.queryParameters;
    final leagueName = queryParams["leagueName"];
    final nickname = queryParams["nickname"];
    final leagueId = int.tryParse(queryParams["leagueId"] ?? "-1");
    final poolPrize = int.tryParse(queryParams["poolPrize"] ?? "-1");
    final pouleTypeString = queryParams["pouleType"];
    logger.d("PouleType: $pouleTypeString");
    final pouleType = PouleType.values
        .firstWhereOrNull((element) => element.toString() == pouleTypeString);
    final entryFee = int.tryParse(queryParams["entryFee"] ?? "-1");

    if (leagueName == null ||
        nickname == null ||
        leagueId == null ||
        poolPrize == null ||
        pouleType == null ||
        entryFee == null) {
      logger.e("Invalid league invitation deep link");
      if (pouleType == null) {
        logger.e("PouleType is null");
      }
      Navigator.of(context).pushNamedAndRemoveUntil(
        SplashScreen.route,
        (route) => false,
      );
      return;
    }

    final isAuthenticated =
        await context.read<AuthenticatorManager>().isAuthenticated();

    if (isInitial) {
      await context.read<Settings>().storeLeagueInvitation(LeagueInvitation(
          entryFee: entryFee,
          leagueId: leagueId,
          nickname: nickname,
          leagueName: leagueName,
          type: pouleType,
          poolPrize: poolPrize));
      Navigator.of(context).pushNamedAndRemoveUntil(
        SplashScreen.route,
        (route) => false,
      );
    } else {
      if (isAuthenticated) {
        showDialog(
            context: context,
            builder: (BuildContext _) {
              return LeagueInvitationDialog(
                isSelfInvite: true,
                entryFee: entryFee,
                leagueId: leagueId,
                nickname: nickname,
                leagueName: leagueName,
                prizePool: poolPrize,
                pouleType: pouleType,
              );
            });
      } else {
        await context.read<Settings>().storeLeagueInvitation(LeagueInvitation(
            entryFee: entryFee,
            leagueId: leagueId,
            nickname: nickname,
            leagueName: leagueName,
            type: pouleType,
            poolPrize: poolPrize));
      }
    }
  }
}
