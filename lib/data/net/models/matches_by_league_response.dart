import 'package:json_annotation/json_annotation.dart';

import 'match_response.dart';

part 'matches_by_league_response.g.dart';

@JsonSerializable()
class MatchesByLeagueResponse {
  final int leagueId;
  final String leagueName;
  final String? leagueLogoUrl;
  final List<MatchResponse> matches;

  factory MatchesByLeagueResponse.fromJson(Map<String, dynamic> json) =>
      _$MatchesByLeagueResponseFromJson(json);

  MatchesByLeagueResponse(
      this.leagueId, this.leagueName, this.leagueLogoUrl, this.matches);

  Map<String, dynamic> toJson() => _$MatchesByLeagueResponseToJson(this);
}
