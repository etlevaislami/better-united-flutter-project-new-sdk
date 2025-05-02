import 'package:flutter_better_united/data/net/models/match_bet_response.dart';

class MatchBets {
  final MatchBet homeTeamBet;
  final MatchBet drawBet;
  final MatchBet awayTeamBet;

  MatchBets(this.homeTeamBet, this.drawBet, this.awayTeamBet);

  factory MatchBets.fromMatchBetResponses(
      List<MatchBetResponse> matchBetsResponses) {
    // assumption verified by a backend member
    final homeTeamBet = MatchBet.fromMatchBetResponse(matchBetsResponses[0]);
    final awayTeamBet = MatchBet.fromMatchBetResponse(matchBetsResponses[1]);
    final drawBet = MatchBet.fromMatchBetResponse(matchBetsResponses.last);
    return MatchBets(homeTeamBet, drawBet, awayTeamBet);
  }
}

class MatchBet {
  final String matchBetName;
  final double matchBetOdds;

  MatchBet(this.matchBetName, this.matchBetOdds);

  MatchBet.fromMatchBetResponse(MatchBetResponse matchBetsResponse)
      : this(matchBetsResponse.matchBetName, matchBetsResponse.matchBetOdds);
}
