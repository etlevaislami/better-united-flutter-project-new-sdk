import 'dart:convert';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/pages/home/active_poules_button.dart';
import 'package:flutter_better_united/pages/home/background/home_background_widget.dart';
import 'package:flutter_better_united/pages/home/home_page_content.dart';
import 'package:flutter_better_united/pages/poules/poules_provider.dart';
import 'package:flutter_better_united/util/notifications/handlers/push_types.dart';
import 'package:flutter_better_united/util/notifications/handlers/team_of_season_ranking_handler.dart';
import 'package:flutter_better_united/util/notifications/handlers/team_of_week_ranking_handler.dart';
import 'package:flutter_better_united/util/notifications/notification_manager.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<PoulesProvider>().fetchActivePoules();

      _checkPendingNotification();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [BackgroundWidget(), HomePageContent()],
        ),
      ),
      bottomNavigationBar: ActivePoulesButton(),
    );
  }

  /// Checks if there are pending push notifications if type either inb PushType.weeklyRankingPushTypes or PushType.seasonalRankingPushTypes.
  void _checkPendingNotification() async {
    final notificationManager = context.read<NotificationManager>();
    final pendingNotifications =
        await notificationManager.getPendingNotifications();

    for (var pendingNotificationRequest in pendingNotifications) {
      if (pendingNotificationRequest.payload == null) {
        break;
      }
      final Map<String, dynamic> data =
          jsonDecode(pendingNotificationRequest.payload!);
      if (!data.containsKey("type")) {
        break;
      }
      final pushType = EnumToString.fromString(PushType.values, data["type"]);

      if (PushType.weeklyRankingPushTypes.contains(pushType)) {
        TeamOfWeekRankingHandler().handle(data, context);
        return;
      } else if (PushType.seasonalRankingPushTypes.contains(pushType)) {
        TeamOfSeasonRankingHandler().handle(data, context);
        return;
      }
    }
  }
}
