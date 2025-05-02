import 'package:json_annotation/json_annotation.dart';

part 'league_detail_football_league_response.g.dart';

@JsonSerializable()
class LeagueDetailFootballLeagueResponse {
  final int leagueId;
  final String leagueName;
  final String? leagueLogoUrl;

  factory LeagueDetailFootballLeagueResponse.fromJson(
          Map<String, dynamic> json) =>
      _$LeagueDetailFootballLeagueResponseFromJson(json);

  LeagueDetailFootballLeagueResponse(
      this.leagueId, this.leagueName, this.leagueLogoUrl);

  Map<String, dynamic> toJson() =>
      _$LeagueDetailFootballLeagueResponseToJson(this);
}
