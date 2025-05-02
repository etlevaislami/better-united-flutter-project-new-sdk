import '../net/models/daily_reward_response.dart';

class DailyReward {
  final int day;
  final int coins;
  final bool isClaimed;

  DailyReward(
      {required this.day, required this.coins, required this.isClaimed});

  DailyReward.fromDailyRewardResponse(DailyRewardResponse dailyRewardResponse,
      {required bool isClaimable})
      : day = dailyRewardResponse.day,
        coins = dailyRewardResponse.coins,
        isClaimed = dailyRewardResponse.claimed;

  DailyReward copyWith({int? day, int? coins, bool? isClaimed}) {
    return DailyReward(
      day: day ?? this.day,
      coins: coins ?? this.coins,
      isClaimed: isClaimed ?? this.isClaimed,
    );
  }
}
