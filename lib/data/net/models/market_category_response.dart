import 'package:json_annotation/json_annotation.dart';

part 'market_category_response.g.dart';

@JsonSerializable()
class MarketCategoryResponse {
  final int marketCategoryId;
  final String marketCategoryName;

  MarketCategoryResponse(this.marketCategoryId, this.marketCategoryName);

  factory MarketCategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$MarketCategoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MarketCategoryResponseToJson(this);
}
