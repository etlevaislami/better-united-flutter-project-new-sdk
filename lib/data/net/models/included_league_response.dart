import 'package:json_annotation/json_annotation.dart';

part 'included_league_response.g.dart';

@JsonSerializable()
class IncludedLeagueResponse {
  final int leagueId;
  final String? leagueName;
  final String? leagueLogoUrl;

  IncludedLeagueResponse(this.leagueId, this.leagueName, this.leagueLogoUrl);

  factory IncludedLeagueResponse.fromJson(Map<String, dynamic> json) =>
      _$IncludedLeagueResponseFromJson(json);

  Map<String, dynamic> toJson() => _$IncludedLeagueResponseToJson(this);
}
