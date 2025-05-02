import 'package:json_annotation/json_annotation.dart';

part 'daily_reward_response.g.dart';

@JsonSerializable()
class DailyRewardResponse {
  final int coins;
  final bool claimed;
  final int day;

  factory DailyRewardResponse.fromJson(Map<String, dynamic> json) =>
      _$DailyRewardResponseFromJson(json);

  DailyRewardResponse(this.coins, this.claimed, this.day);

  Map<String, dynamic> toJson() => _$DailyRewardResponseToJson(this);
}
