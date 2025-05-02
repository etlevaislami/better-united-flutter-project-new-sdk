import 'package:flutter_better_united/data/net/models/match_response.dart';
import 'package:json_annotation/json_annotation.dart';

import 'market_response.dart';

part 'bet_info_response.g.dart';

@JsonSerializable()
class BetInfoResponse {
  final TeamResponse homeTeam;
  final TeamResponse awayTeam;
  @JsonKey(name: 'Popular')
  final List<MarketResponse> popular;
  @JsonKey(name: 'Additional')
  final List<MarketResponse> additional;

  BetInfoResponse(this.popular, this.homeTeam, this.awayTeam, this.additional);

  factory BetInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$BetInfoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BetInfoResponseToJson(this);
}
