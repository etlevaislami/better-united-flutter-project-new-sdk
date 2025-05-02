import 'package:flutter/material.dart';
import 'package:flutter_better_united/util/notifications/handlers/push_handler.dart';

import '../../../data/enum/poule_type.dart';
import '../../../pages/dialog/league_invitation_dialog.dart';

class FriendInvitationHandler extends PushHandler {
  @override
  void handle(Map<String, dynamic> payload, BuildContext context) {
    final int leagueId = int.parse(payload["friendLeagueId"]);
    final String nickname = payload["nickname"] ?? "undefined";
    final String leagueName = payload["friendLeagueName"];
    final int entryFee = int.parse(payload["entryFee"]);
    final int poolPrize = int.parse(payload["poolPrize"]);

    showDialog(
        context: context,
        builder: (BuildContext _) {
          return LeagueInvitationDialog(
            isSelfInvite: false,
            leagueId: leagueId,
            nickname: nickname,
            leagueName: leagueName,
            prizePool: poolPrize,
            pouleType: PouleType.friend,
            entryFee: entryFee,
          );
        });
  }

  @override
  void onForegroundMessageReceived(
      Map<String, dynamic> payload, BuildContext context) {
    handle(payload, context);
  }

  @override
  bool displayForegroundNotification = false;
}
