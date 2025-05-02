import '../enum/public_poule_type.dart';
import '../net/models/public_league_join_info_response.dart';
import 'football_match.dart';
import 'league.dart';

class PublicLeagueJoinInfo {
  final int id;
  final String name;
  final DateTime startsAt;
  final DateTime endsAt;
  final int poolPrize;
  final String? iconUrl;
  final List<League> leagues;
  final int coinsForFirst;
  final int coinsForSecond;
  final int coinsForThird;
  final int coinsForOthers;
  final int joinFee;
  final int predictionLeft;
  final int maximumTipCountPerMatch;
  final bool isFinished;
  final List<FootballMatch> matches;
  final PublicPouleType type;

  PublicLeagueJoinInfo(
    this.id,
    this.name,
    this.startsAt,
    this.endsAt,
    this.poolPrize,
    this.iconUrl,
    this.leagues,
    this.coinsForFirst,
    this.coinsForSecond,
    this.coinsForThird,
    this.coinsForOthers,
    this.joinFee,
    this.predictionLeft,
    this.maximumTipCountPerMatch,
    this.isFinished,
    this.matches,
    this.type
  );

  PublicLeagueJoinInfo.fromPublicLeagueJoinInfoResponse(
      PublicLeagueJoinInfoResponse item)
      : id = item.id,
        name = item.name,
        startsAt = item.startsAt,
        endsAt = item.endsAt,
        poolPrize = item.poolPrizeTotal,
        iconUrl = item.iconUrl,
        predictionLeft = item.predictionsRemaining ?? 0,
        leagues = item.leagues
            .map((e) => League.fromFootballLeagueResponse(e))
            .toList(),
        coinsForFirst = item.poolPrizeAmountFirst,
        coinsForSecond = item.poolPrizeAmountSecond,
        coinsForThird = item.poolPrizeAmountThird,
        coinsForOthers = item.poolPrizeAmountOthers,
        matches = item.matches
            .map((e) => FootballMatch.fromPublicMatchResponse(e))
            .toList(),
        type = item.formatType,
        joinFee = item.entryFee ?? 0,
        maximumTipCountPerMatch = item.maximumTipCountPerMatch,
        isFinished = item.status;
}
