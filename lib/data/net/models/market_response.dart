import 'package:json_annotation/json_annotation.dart';

import 'odds_response.dart';

part 'market_response.g.dart';

@JsonSerializable()
class MarketResponse {
  final int marketId;
  final List<OddsResponse> odds;
  final int marketIsFolded;
  final int marketIsAlreadyPlayed;

  MarketResponse(
    this.marketId,
    this.odds,
    this.marketIsFolded,
    this.marketIsAlreadyPlayed,
  );

  factory MarketResponse.fromJson(Map<String, dynamic> json) =>
      _$MarketResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MarketResponseToJson(this);
}
