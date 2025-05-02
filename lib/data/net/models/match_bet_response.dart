import 'package:json_annotation/json_annotation.dart';

part 'match_bet_response.g.dart';

@JsonSerializable()
class MatchBetResponse {
  final String matchBetName;
  final double matchBetOdds;

  factory MatchBetResponse.fromJson(Map<String, dynamic> json) =>
      _$MatchBetResponseFromJson(json);

  MatchBetResponse(this.matchBetName, this.matchBetOdds);

  Map<String, dynamic> toJson() => _$MatchBetResponseToJson(this);
}
