import 'package:flutter_better_united/data/enum/tip_settlement.dart';
import 'package:flutter_better_united/data/net/models/rewards_response.dart';

class Rewards {
  final int xpReward;
  final int coinReward;
  final int tipPoints;
  final int tipPointsXpReward;
  final TipSettlement tipSettlement;

  Rewards(
    this.xpReward,
    this.coinReward,
    this.tipPoints,
    this.tipPointsXpReward,
    this.tipSettlement,
  );

  Rewards.fromRewardsResponse(RewardsResponse rewardsResponse)
      : this(
          rewardsResponse.xpReward,
          rewardsResponse.coinReward,
          rewardsResponse.tipPoints,
          rewardsResponse.tipPointsXpReward,
          rewardsResponse.tipSettlement,
        );
}
