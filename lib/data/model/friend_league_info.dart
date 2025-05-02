import 'package:flutter_better_united/data/model/team.dart';

import '../net/models/friend_league_active_list_item.dart';
import 'football_match.dart';

class FriendLeagueInfo {
  final int id;
  final String name;
  final DateTime startsAt;
  final DateTime endsAt;
  final int userCount;
  final int? userRank;
  final int predictionsLeft;
  final int poolPrize;
  final FootballMatch match;
  final int entryFee;
  final bool isFinished;

  FriendLeagueInfo({
    required this.id,
    required this.name,
    required this.startsAt,
    required this.endsAt,
    required this.userCount,
    required this.userRank,
    required this.predictionsLeft,
    required this.poolPrize,
    required this.match,
    required this.entryFee,
    required this.isFinished,
  });

  FriendLeagueInfo.fromFriendLeagueActivePouleItem(
      FriendLeagueActivePouleItem item)
      : id = item.id,
        name = item.name,
        startsAt = item.startsAt,
        endsAt = item.endsAt,
        userCount = item.userCount,
        userRank = item.userRank,
        predictionsLeft = item.predictionsRemaining,
        poolPrize = item.poolPrize,
        match = FootballMatch(
            item.matchId,
            item.matchStartsAt,
            Team.fromTeamResponse(item.homeTeam),
            Team.fromTeamResponse(item.awayTeam),
            null,
            0,
            false,
            true),
        entryFee = item.entryFee,
        isFinished = item.status;
}
