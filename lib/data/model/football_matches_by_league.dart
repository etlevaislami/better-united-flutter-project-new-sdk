import 'package:flutter_better_united/data/model/football_match.dart';

import '../net/models/matches_by_league_response.dart';

class FootballMatchesByLeague {
  final int leagueId;
  final String leagueName;
  final String? leagueLogoUrl;
  final List<FootballMatch> matches;

  FootballMatchesByLeague(
      {required this.leagueId,
      required this.leagueName,
      required this.leagueLogoUrl,
      required this.matches});

  FootballMatchesByLeague.fromMatchesByLeagueResponse(
      MatchesByLeagueResponse matchesByLeagueResponse)
      : this(
            leagueId: matchesByLeagueResponse.leagueId,
            leagueName: matchesByLeagueResponse.leagueName,
            leagueLogoUrl: matchesByLeagueResponse.leagueLogoUrl,
            matches: matchesByLeagueResponse.matches
                .map((matchResponse) =>
                    FootballMatch.fromMatchResponse(matchResponse))
                .toList());
}
