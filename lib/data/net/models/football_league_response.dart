import 'package:json_annotation/json_annotation.dart';

part 'football_league_response.g.dart';

@JsonSerializable()
class FootballLeagueResponse {
  final int id;
  final String leagueName;
  final String? leagueLogoUrl;

  factory FootballLeagueResponse.fromJson(Map<String, dynamic> json) =>
      _$FootballLeagueResponseFromJson(json);

  FootballLeagueResponse(this.id, this.leagueName, this.leagueLogoUrl);

  Map<String, dynamic> toJson() => _$FootballLeagueResponseToJson(this);
}
