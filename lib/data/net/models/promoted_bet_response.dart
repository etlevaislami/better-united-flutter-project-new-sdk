import 'package:json_annotation/json_annotation.dart';

part 'promoted_bet_response.g.dart';

@JsonSerializable()
class PromotedBetResponse {
  final String bookmakerUrl;
  final String? tipImageEN;
  final String? tipImageNL;

  PromotedBetResponse(this.bookmakerUrl, this.tipImageEN, this.tipImageNL);

  factory PromotedBetResponse.fromJson(Map<String, dynamic> json) =>
      _$PromotedBetResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PromotedBetResponseToJson(this);
}
