import 'package:flutter/material.dart';
import 'package:flutter_better_united/data/enum/poule_type.dart';
import 'package:flutter_better_united/pages/dialog/poule_rank_dialog.dart';
import 'package:flutter_better_united/pages/poules/poule_page.dart';
import 'package:flutter_better_united/pages/shop/user_provider.dart';
import 'package:flutter_better_united/util/notifications/handlers/push_handler.dart';
import 'package:flutter_better_united/util/ui_util.dart';
import 'package:provider/provider.dart';

import '../../../data/net/interceptors/error_interceptor.dart';

class FinishedPublicLeagueHandler extends PushHandler {
  @override
  Future<void> handle(
      Map<String, dynamic> payload, BuildContext context) async {
    final int leagueId = int.parse(payload["publicLeagueId"]);
    beginLoading();
    try {
      final reward = await context
          .read<UserProvider>()
          .getPouleReward(leagueId, PouleType.public);
      showDialog(
          context: context,
          builder: (BuildContext _) {
            return PouleRankDialog(pouleReward: reward);
          });
    } on NotFoundException {
      Navigator.of(context)
          .push(PoulePage.route(pouleId: leagueId, type: PouleType.public));
    } finally {
      endLoading();
    }
  }

  @override
  bool displayForegroundNotification = true;
}
