import 'package:flutter/material.dart';
import 'package:flutter_better_united/pages/dialog/team_of_week_weekly_rank_dialog.dart';
import 'package:flutter_better_united/pages/ranking/ranking_provider.dart';
import 'package:flutter_better_united/util/notifications/handlers/push_handler.dart';
import 'package:flutter_better_united/util/ui_util.dart';
import 'package:provider/provider.dart';

import '../../../data/enum/poule_type.dart';
import '../../../pages/dialog/league_invitation_dialog.dart';

/// Handler for push notifications for weekly ranking (teamOfWeekWin / teamOfWeekLose)
class TeamOfWeekRankingHandler extends PushHandler {
  @override
  void handle(Map<String, dynamic> payload, BuildContext context) async {
    beginLoading();
    try {
      final teamOfWeek = await context
          .read<RankingProvider>()
          .getTeamOfWeek();

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext _) {
          return TeamOfWeekWeeklyRankDialog(
            teamOfWeek: teamOfWeek,
          );
        },
      );
    }
    finally {
      endLoading();
    }
  }

  @override
  void onForegroundMessageReceived(
      Map<String, dynamic> payload, BuildContext context) {
    handle(payload, context);
  }

  @override
  bool displayForegroundNotification = false;
}
