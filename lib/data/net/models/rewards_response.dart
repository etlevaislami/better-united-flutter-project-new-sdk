import 'package:flutter_better_united/data/enum/tip_settlement.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rewards_response.g.dart';

@JsonSerializable()
class RewardsResponse {
  final int xpReward;
  final int coinReward;
  final int tipPoints;
  final int tipPointsXpReward;
  @JsonKey(fromJson: intToTipSettlement, toJson: tipSettlementFromInt)
  final TipSettlement tipSettlement;

  RewardsResponse(
    this.xpReward,
    this.coinReward,
    this.tipPoints,
    this.tipPointsXpReward,
    this.tipSettlement,
  );

  factory RewardsResponse.fromJson(Map<String, dynamic> json) =>
      _$RewardsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RewardsResponseToJson(this);
}
