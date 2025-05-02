import 'package:flutter_better_united/data/model/football_match.dart';

import '../enum/public_poule_type.dart';
import '../net/models/public_league_active_list_item.dart';
import 'league.dart';

class PublicLeagueInfo {
  final int id;
  final String name;
  final DateTime startsAt;
  final DateTime endsAt;
  final int userCount;
  final int? userRank;
  final int predictionsLeft;
  final int poolPrize;
  final String? iconUrl;
  final int coinsForFirst;
  final int coinsForSecond;
  final int coinsForThird;
  final int coinsForOthers;
  final List<League> leagues;
  final bool isFinished;
  final List<FootballMatch> matches;
  final PublicPouleType formatType;

  PublicLeagueInfo(
      {required this.id,
      required this.name,
      required this.startsAt,
      required this.endsAt,
      required this.userCount,
      required this.userRank,
      required this.predictionsLeft,
      required this.poolPrize,
      required this.iconUrl,
      required this.coinsForFirst,
      required this.coinsForSecond,
      required this.coinsForThird,
      required this.coinsForOthers,
      required this.leagues,
      required this.isFinished,
      required this.matches,
      required this.formatType
  });

  PublicLeagueInfo.fromPublicLeagueActivePouleItem(
      PublicLeagueActivePouleItem item)
      : id = item.id,
        name = item.name,
        startsAt = item.startsAt,
        endsAt = item.endsAt,
        userCount = item.userCount,
        userRank = item.userRank,
        predictionsLeft = item.predictionsRemaining,
        poolPrize = item.poolPrizeTotal,
        iconUrl = item.iconUrl,
        coinsForFirst = item.poolPrizeAmountFirst,
        coinsForSecond = item.poolPrizeAmountSecond,
        coinsForThird = item.poolPrizeAmountThird,
        coinsForOthers = item.poolPrizeAmountOthers,
        formatType = item.formatType,
        leagues = item.leagues
            .map((e) => League.fromFootballLeagueResponse(e))
            .toList(),
        isFinished = item.status,
        matches = item.matches
            .map((e) => FootballMatch.fromPublicMatchResponse(e))
            .toList();
}
