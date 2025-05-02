import 'package:flutter/material.dart';
import 'package:flutter_better_united/util/notifications/handlers/push_handler.dart';

import '../../../pages/public_poule/choose_public_poule_page.dart';

class PublicLeagueCreationHandler extends PushHandler {
  @override
  void handle(Map<String, dynamic> payload, BuildContext context) {
    Navigator.of(context).push(ChoosePublicPoulePage.route());
  }

  @override
  bool displayForegroundNotification = true;
}
