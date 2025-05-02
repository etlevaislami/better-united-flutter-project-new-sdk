import 'package:flutter_better_united/data/net/models/reward_level_response.dart';
import 'package:flutter_better_united/util/extensions/int_extension.dart';

class RewardLevel {
  final int id;
  final String title;
  final int? coinCount;
  final int? tipRevealCount;
  final int? powerUpCount;
  final int level;
  final bool isAchieved;
  final int? neededPoints;

  bool isClaimed;

  RewardLevel(
      this.id,
      this.title,
      this.coinCount,
      this.tipRevealCount,
      this.powerUpCount,
      this.level,
      this.isClaimed,
      this.isAchieved,
      this.neededPoints);

  RewardLevel.fromRewardLevelResponse(RewardLevelResponse rewardLevelResponse)
      : this(
            rewardLevelResponse.id,
            rewardLevelResponse.title,
            rewardLevelResponse.coinCount,
            rewardLevelResponse.tipRevealCount,
            rewardLevelResponse.powerupCount,
            rewardLevelResponse.level,
            rewardLevelResponse.isClaimed.toBool(),
            rewardLevelResponse.isAchieved.toBool(),
            rewardLevelResponse.neededPoints);
}
