import 'package:flutter_better_united/data/model/team.dart';
import 'package:flutter_better_united/data/net/models/match_response.dart';
import 'package:flutter_better_united/util/extensions/int_extension.dart';

import '../net/models/public_match_response.dart';
import 'match_bets.dart';

class FootballMatch {
  final int id;
  final DateTime startsAt;
  final Team homeTeam;
  final Team awayTeam;
  final MatchBets? matchBets;
  final int leagueId;
  final bool hasFavouriteTeam;
  final bool isAllowedToBet;

  FootballMatch(
      this.id,
      this.startsAt,
      this.homeTeam,
      this.awayTeam,
      this.matchBets,
      this.leagueId,
      this.hasFavouriteTeam,
      this.isAllowedToBet);

  FootballMatch.fromMatchResponse(MatchResponse matchResponse)
      : this(
            matchResponse.id,
            matchResponse.startsAt,
            Team.fromTeamResponse(matchResponse.homeTeam),
            Team.fromTeamResponse(matchResponse.awayTeam),
            matchResponse.matchBets.isEmpty
                ? null
                : MatchBets.fromMatchBetResponses(matchResponse.matchBets),
            matchResponse.leagueId,
            matchResponse.hasFavouriteTeam.toBool(),
            matchResponse.canUserAppBet.toBool());

  FootballMatch.fromPublicMatchResponse(PublicMatchResponse matchResponse)
      : this(
            matchResponse.id,
            matchResponse.startsAt,
            Team.fromTeamResponse(matchResponse.homeTeam),
            Team.fromTeamResponse(matchResponse.awayTeam),
            null,
            0,
            false,
            true);
}
