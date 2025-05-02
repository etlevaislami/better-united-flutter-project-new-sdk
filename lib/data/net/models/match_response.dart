import 'package:flutter_better_united/data/net/converters/date_converter.dart';
import 'package:json_annotation/json_annotation.dart';

import 'match_bet_response.dart';

part 'match_response.g.dart';

@JsonSerializable()
@DateTimeConverter()
class MatchResponse {
  final int id;
  final DateTime startsAt;
  final TeamResponse homeTeam;
  final TeamResponse awayTeam;
  final List<MatchBetResponse> matchBets;
  final int leagueId;
  final int hasFavouriteTeam;
  final int canUserAppBet;

  factory MatchResponse.fromJson(Map<String, dynamic> json) =>
      _$MatchResponseFromJson(json);

  MatchResponse(this.id, this.startsAt, this.homeTeam, this.awayTeam,
      this.matchBets, this.leagueId, this.hasFavouriteTeam, this.canUserAppBet);

  Map<String, dynamic> toJson() => _$MatchResponseToJson(this);
}

@JsonSerializable()
class TeamResponse {
  final int id;
  final String name;
  final String? logoUrl;

  TeamResponse(this.id, this.name, this.logoUrl);

  factory TeamResponse.fromJson(Map<String, dynamic> json) =>
      _$TeamResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TeamResponseToJson(this);
}
