import 'package:flutter_better_united/data/net/models/daily_reward_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'daily_rewards_response.g.dart';

@JsonSerializable()
class DailyRewardsResponse {
  final List<DailyRewardResponse> rewards;
  final bool isClaimable;

  factory DailyRewardsResponse.fromJson(Map<String, dynamic> json) =>
      _$DailyRewardsResponseFromJson(json);

  DailyRewardsResponse(this.rewards, this.isClaimable);

  Map<String, dynamic> toJson() => _$DailyRewardsResponseToJson(this);
}
