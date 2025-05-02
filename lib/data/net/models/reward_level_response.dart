import 'package:json_annotation/json_annotation.dart';

part 'reward_level_response.g.dart';

@JsonSerializable()
class RewardLevelResponse {
  final int id;
  final String title;
  final int? coinCount;
  final int? tipRevealCount;
  final int? powerupCount;
  final int level;

  final int isClaimed;
  final int isAchieved;
  final int? neededPoints;

  factory RewardLevelResponse.fromJson(Map<String, dynamic> json) =>
      _$RewardLevelResponseFromJson(json);

  RewardLevelResponse(
      this.id,
      this.title,
      this.coinCount,
      this.tipRevealCount,
      this.powerupCount,
      this.level,
      this.isClaimed,
      this.isAchieved,
      this.neededPoints);

  Map<String, dynamic> toJson() => _$RewardLevelResponseToJson(this);
}
