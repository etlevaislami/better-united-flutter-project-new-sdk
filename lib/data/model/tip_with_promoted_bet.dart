import 'package:flutter_better_united/data/model/promoted_bet.dart';
import 'package:flutter_better_united/data/model/tip.dart';
import 'package:flutter_better_united/data/net/models/tip_created_response.dart';

class TipWithPromotedBet {
  final Tip tip;
  final PromotedBet? promotedBet;
  final int? earnedCoins;

  TipWithPromotedBet({
    required this.tip,
    required this.promotedBet,
    this.earnedCoins,
  });

  factory TipWithPromotedBet.fromTipCreatedResponse(
      TipCreatedResponse response) {
    return TipWithPromotedBet(
        earnedCoins: response.earnedCoins,
        tip: Tip.fromTipResponse(response.tip),
        promotedBet: response.promotedTip != null
            ? PromotedBet.fromPromotedBetResponse(response.promotedTip!)
            : null);
  }
}
