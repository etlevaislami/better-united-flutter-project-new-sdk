import 'package:flutter_better_united/data/model/daily_reward.dart';

class DailyRewards {
  final DailyReward dayOneReward;
  final DailyReward dayTwoReward;
  final DailyReward dayThreeReward;
  final DailyReward dayFourReward;
  final DailyReward dayFiveReward;
  final DailyReward daySixReward;
  final DailyReward daySevenReward;
  final DailyReward toBeClaimedDayReward;

  DailyRewards(
      {required this.dayOneReward,
      required this.dayTwoReward,
      required this.dayThreeReward,
      required this.dayFourReward,
      required this.dayFiveReward,
      required this.daySixReward,
      required this.daySevenReward,
      required this.toBeClaimedDayReward});

  DailyRewards copyWith(
      {DailyReward? dayOneReward,
      DailyReward? dayTwoReward,
      DailyReward? dayThreeReward,
      DailyReward? dayFourReward,
      DailyReward? dayFiveReward,
      DailyReward? daySixReward,
      DailyReward? daySevenReward,
      DailyReward? toBeClaimedDayReward}) {
    return DailyRewards(
        dayOneReward: dayOneReward ?? this.dayOneReward,
        dayTwoReward: dayTwoReward ?? this.dayTwoReward,
        dayThreeReward: dayThreeReward ?? this.dayThreeReward,
        dayFourReward: dayFourReward ?? this.dayFourReward,
        dayFiveReward: dayFiveReward ?? this.dayFiveReward,
        daySixReward: daySixReward ?? this.daySixReward,
        daySevenReward: daySevenReward ?? this.daySevenReward,
        toBeClaimedDayReward:
            toBeClaimedDayReward ?? this.toBeClaimedDayReward);
  }
}
