import 'package:json_annotation/json_annotation.dart';

import 'match_response.dart';

part 'tip_revealed_detail_response.g.dart';

@JsonSerializable()
class TipRevealedDetailResponse {
  final int id;
  final String? description;
  final String finalScore;
  final int points;
  final TeamResponse homeTeam;
  final TeamResponse awayTeam;
  final List<String>? hints;
  final String? pouleIconUrl;
  final int? publicLeagueId;
  final int? friendLeagueId;
  final String pouleName;

  TipRevealedDetailResponse(
      this.id,
      this.description,
      this.finalScore,
      this.points,
      this.homeTeam,
      this.awayTeam,
      this.hints,
      this.pouleIconUrl,
      this.publicLeagueId,
      this.friendLeagueId,
      this.pouleName);

  factory TipRevealedDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$TipRevealedDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TipRevealedDetailResponseToJson(this);
}
