import 'package:flutter/material.dart';
import 'package:flutter_better_united/util/notifications/handlers/push_handler.dart';

class FriendInvitationAcceptedHandler extends PushHandler {
  @override
  void handle(Map<String, dynamic> payload, BuildContext context) {
    final int leagueId = int.parse(payload["friendLeagueId"]);
    /*
       context.read<NavigationService>().jumpToNavPage(NavPage.friendIndex,
        extraParam: FriendLeagueIdArgument(leagueId));
     */
  }

  @override
  bool displayForegroundNotification = true;
}
