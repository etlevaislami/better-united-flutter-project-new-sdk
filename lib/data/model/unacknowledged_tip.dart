import 'package:flutter_better_united/data/enum/tip_settlement.dart';
import 'package:flutter_better_united/data/model/rewards.dart';
import 'package:flutter_better_united/data/model/tip_revealed_detail.dart';

class UnacknowledgedTip {
  final TipRevealedDetail tipDetail;
  final Rewards rewards;

  UnacknowledgedTip(this.tipDetail, this.rewards);

  bool get isTipWon => rewards.tipSettlement == TipSettlement.won;
}
