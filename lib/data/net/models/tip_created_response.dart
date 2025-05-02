import 'package:flutter_better_united/data/net/models/promoted_bet_response.dart';
import 'package:flutter_better_united/data/net/models/tip_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tip_created_response.g.dart';

@JsonSerializable()
class TipCreatedResponse {
  final TipResponse tip;
  final PromotedBetResponse? promotedTip;
  final int? earnedCoins;

  factory TipCreatedResponse.fromJson(Map<String, dynamic> json) =>
      _$TipCreatedResponseFromJson(json);

  TipCreatedResponse(this.tip, this.promotedTip, this.earnedCoins);

  Map<String, dynamic> toJson() => _$TipCreatedResponseToJson(this);
}
