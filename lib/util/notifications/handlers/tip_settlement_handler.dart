import 'package:flutter/material.dart';
import 'package:flutter_better_united/data/enum/tip_settlement.dart';
import 'package:flutter_better_united/util/notifications/handlers/push_handler.dart';
import 'package:provider/provider.dart';

import '../../../pages/dialog/tip_result_dialog.dart';
import '../../navigation_service.dart';

class TipSettlementHandler extends PushHandler {
  @override
  void handle(Map<String, dynamic> payload, BuildContext context) {
    final int tipId = int.parse(payload["tipId"]);
    final TipSettlement tipSettlement =
        intToTipSettlement(int.parse(payload["tipSettlement"]));
    context.read<NavigationService>().pendingPushNotification = true;
    showDialog(
        context: context,
        builder: (BuildContext _) {
          return TipResultDialog(
            tipId: tipId,
            tipSettlement: tipSettlement,
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
