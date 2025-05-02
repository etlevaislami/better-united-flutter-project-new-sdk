import 'package:flutter/cupertino.dart';
import 'package:flutter_better_united/data/model/unacknowledged_tip.dart';
import 'package:flutter_better_united/data/repo/tip_repository.dart';
import 'package:flutter_better_united/util/ui_util.dart';

import '../run.dart';

class TipSettlementProvider with ChangeNotifier {
  final TipRepository _tipRepository;
  UnacknowledgedTip? unacknowledgedTip;
  int? tipId;

  TipSettlementProvider(this._tipRepository,
      {required this.unacknowledgedTip, this.tipId}) {
    if (unacknowledgedTip != null) {
      _sendAnalyticsEvent(unacknowledgedTip!);
    }
  }

  fetchUnacknowledgedTip(int tipId) async {
    try {
      beginLoading();
      final tipDetail = await _tipRepository.getRevealedTipDetail(tipId);
      final rewards = await _tipRepository.getRewards(tipId);
      final unacknowledgedTip = UnacknowledgedTip(tipDetail, rewards);
      this.unacknowledgedTip = unacknowledgedTip;
      _sendAnalyticsEvent(unacknowledgedTip);
      notifyListeners();
    } catch (exception) {
      showGenericError(exception);
      rethrow;
    } finally {
      endLoading();
    }
  }

  Future acknowledgeTip(int tipId) async {
    return _tipRepository.acknowledgeTip(tipId);
  }

  _sendAnalyticsEvent(UnacknowledgedTip unacknowledgedTip) {
    final eventName =
        unacknowledgedTip.isTipWon ? "TIP_RESULT_WON" : "TIP_RESULT_LOST";
    analytics.logEvent(
      name: eventName,
      parameters: {
        "tip_id": unacknowledgedTip.tipDetail.id,
        "betting_odds": unacknowledgedTip.tipDetail.points,
        "betting_indicator": unacknowledgedTip.tipDetail.hint
      },
    );
  }
}