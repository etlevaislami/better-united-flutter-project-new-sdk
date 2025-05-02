import 'package:flutter_better_united/data/model/football_match.dart';
import 'package:flutter_better_united/data/model/participant.dart';
import 'package:flutter_better_united/data/model/team.dart';

import '../net/models/friend_league_detail_response.dart';
import 'league.dart';

class FriendLeagueDetail {
  final int id;
  final String name;
  final DateTime startsAt;
  final DateTime endsAt;
  final int tipCountTotal;
  final int? tipCountLost;
  final int? tipCountWon;
  final List<Participant> userRankings;
  final List<League> includedLeagues;
  final int maximumTipCount;
  final int userTipCountTotal;
  final FootballMatch match;
  final int? prizePool;
  final bool isFinished;

  FriendLeagueDetail(
      this.id,
      this.name,
      this.startsAt,
      this.endsAt,
      this.tipCountTotal,
      this.tipCountLost,
      this.tipCountWon,
      this.userRankings,
      this.includedLeagues,
      this.maximumTipCount,
      this.userTipCountTotal,
      this.match,
      this.prizePool,
      this.isFinished);

  FriendLeagueDetail.fromFriendLeagueDetailResponse(FriendLeagueDetailResponse friendLeagueDetailResponse)
      : this(
      friendLeagueDetailResponse.id,
            friendLeagueDetailResponse.name,
            friendLeagueDetailResponse.startsAt,
            friendLeagueDetailResponse.endsAt,
            friendLeagueDetailResponse.tipCountTotal,
            friendLeagueDetailResponse.tipCountLost,
            friendLeagueDetailResponse.tipCountWon,
            friendLeagueDetailResponse.userRankings
                .map((participantResponse) =>
                    Participant.fromParticipantResponse(participantResponse))
                .toList(),
            [],
            friendLeagueDetailResponse.maximumTipCount,
            friendLeagueDetailResponse.userTipCountTotal,
            FootballMatch(
                friendLeagueDetailResponse.matchId,
                friendLeagueDetailResponse.matchStartsAt,
                Team(
                  -1,
                  friendLeagueDetailResponse.homeTeamName,
                  friendLeagueDetailResponse.homeTeamLogoUrl,
                ),
                Team(
                  -1,
                  friendLeagueDetailResponse.awayTeamName,
                  friendLeagueDetailResponse.awayTeamLogoUrl,
                ),
                null,
                -1,
                false,
                true),
            friendLeagueDetailResponse.prizePool,
            friendLeagueDetailResponse.status);
}
