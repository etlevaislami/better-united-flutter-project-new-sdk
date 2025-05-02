import 'package:flutter_better_united/data/model/friend_league_info.dart';
import 'package:flutter_better_united/data/model/participant.dart';
import 'package:flutter_better_united/data/model/public_league_join_info.dart';
import 'package:flutter_better_united/data/model/team.dart';
import 'package:flutter_better_united/data/net/models/public_league_detail_response.dart';

import '../enum/poule_type.dart';
import '../enum/public_poule_type.dart';
import '../net/models/friend_league_detail_response.dart';
import 'football_match.dart';
import 'league.dart';

class PublicPouleData {
  final int coinsForFirst;
  final int coinsForSecond;
  final int coinsForThird;
  final int coinsForOthers;
  final String? imageUrl;
  final List<League> leagues;
  final int maximumTipCountPerMatch;
  final List<FootballMatch> matches;
  final PublicPouleType publicPouleType;

  PublicPouleData({
    required this.coinsForFirst,
    required this.coinsForSecond,
    required this.coinsForThird,
    required this.coinsForOthers,
    required this.imageUrl,
    required this.leagues,
    required this.maximumTipCountPerMatch,
    required this.matches,
    required this.publicPouleType
  });

  FootballMatch? getSingleMatch() {
    if (matches.isNotEmpty && matches.length == 1) return matches.first;
    return null;
  }
}

class FriendPouleData {
  final FootballMatch match;

  FriendPouleData({required this.match});
}

class LeagueDetail {
  final int id;
  final String name;
  final DateTime startsAt;
  final DateTime endsAt;
  final int tipCountTotal;
  final int tipCountLost;
  final int tipCountWon;
  final List<Participant> userRankings;
  final int maximumTipCount;
  final int userTipCountTotal;
  final int? prizePool;
  final PublicPouleData? publicPouleData;
  final FriendPouleData? friendPouleData;
  final int predictionsLeft;
  final int entryFee;
  final bool isFinished;

  LeagueDetail({
    required this.id,
    required this.name,
    required this.startsAt,
    required this.endsAt,
    required this.tipCountTotal,
    required this.tipCountLost,
    required this.tipCountWon,
    required this.userRankings,
    required this.maximumTipCount,
    required this.userTipCountTotal,
    required this.prizePool,
    required this.publicPouleData,
    required this.friendPouleData,
    required this.predictionsLeft,
    required this.entryFee,
    required this.isFinished,
  });

  LeagueDetail.fromFriendLeagueDetailResponse(
      FriendLeagueDetailResponse friendLeagueDetailResponse)
      : id = friendLeagueDetailResponse.id,
        name = friendLeagueDetailResponse.name,
        startsAt = friendLeagueDetailResponse.startsAt,
        endsAt = friendLeagueDetailResponse.endsAt,
        tipCountTotal = friendLeagueDetailResponse.tipCountTotal,
        tipCountLost = friendLeagueDetailResponse.tipCountLost ?? 0,
        tipCountWon = friendLeagueDetailResponse.tipCountWon ?? 0,
        userRankings = friendLeagueDetailResponse.userRankings
            .map((participantResponse) =>
                Participant.fromParticipantResponse(participantResponse))
            .toList(),
        maximumTipCount = friendLeagueDetailResponse.maximumTipCount,
        userTipCountTotal = friendLeagueDetailResponse.userTipCountTotal,
        prizePool = friendLeagueDetailResponse.prizePool,
        publicPouleData = null,
        predictionsLeft = friendLeagueDetailResponse.predictionsRemaining,
        friendPouleData = FriendPouleData(
            match: FootballMatch(
                friendLeagueDetailResponse.matchId,
                friendLeagueDetailResponse.matchStartsAt,
                Team(-1, friendLeagueDetailResponse.homeTeamName,
                    friendLeagueDetailResponse.homeTeamLogoUrl),
                Team(-1, friendLeagueDetailResponse.awayTeamName,
                    friendLeagueDetailResponse.awayTeamLogoUrl),
                null,
                -1,
                false,
                true)),
        entryFee = friendLeagueDetailResponse.entryFee,
        isFinished = friendLeagueDetailResponse.status;

  LeagueDetail.fromPublicLeagueJoinInfo(
      PublicLeagueJoinInfo publicLeagueJoinInfo)
      : id = publicLeagueJoinInfo.id,
        entryFee = publicLeagueJoinInfo.joinFee,
        name = publicLeagueJoinInfo.name,
        startsAt = publicLeagueJoinInfo.startsAt,
        endsAt = publicLeagueJoinInfo.endsAt,
        tipCountTotal = 0,
        tipCountLost = 0,
        tipCountWon = 0,
        userRankings = [],
        maximumTipCount = 0,
        userTipCountTotal = 0,
        prizePool = publicLeagueJoinInfo.poolPrize,
        publicPouleData = PublicPouleData(
          matches: publicLeagueJoinInfo.matches,
            publicPouleType: publicLeagueJoinInfo.type,
            coinsForFirst: publicLeagueJoinInfo.coinsForFirst,
            coinsForSecond: publicLeagueJoinInfo.coinsForSecond,
            coinsForThird: publicLeagueJoinInfo.coinsForThird,
            coinsForOthers: publicLeagueJoinInfo.coinsForOthers,
            imageUrl: publicLeagueJoinInfo.iconUrl,
            leagues: publicLeagueJoinInfo.leagues,
          maximumTipCountPerMatch: publicLeagueJoinInfo.maximumTipCountPerMatch,
        ),
        predictionsLeft = publicLeagueJoinInfo.predictionLeft,
        friendPouleData = null,
        isFinished = publicLeagueJoinInfo.isFinished;

  LeagueDetail.fromFriendLeagueInfo(FriendLeagueInfo friendLeagueInfo)
      : id = friendLeagueInfo.id,
        name = friendLeagueInfo.name,
        startsAt = friendLeagueInfo.startsAt,
        endsAt = friendLeagueInfo.endsAt,
        tipCountTotal = 0,
        tipCountLost = 0,
        tipCountWon = 0,
        userRankings = [],
        maximumTipCount = 0,
        userTipCountTotal = 0,
        entryFee = friendLeagueInfo.entryFee,
        prizePool = friendLeagueInfo.poolPrize,
        publicPouleData = null,
        predictionsLeft = friendLeagueInfo.predictionsLeft,
        friendPouleData = FriendPouleData(match: friendLeagueInfo.match),
        isFinished = friendLeagueInfo.isFinished;

  LeagueDetail.fromPublicLeagueDetailResponse(
      PublicLeagueDetailResponse publicLeagueDetailResponse)
      : id = publicLeagueDetailResponse.id,
        entryFee = publicLeagueDetailResponse.entryFee,
        name = publicLeagueDetailResponse.name,
        startsAt = publicLeagueDetailResponse.startsAt,
        endsAt = publicLeagueDetailResponse.endsAt,
        tipCountTotal = publicLeagueDetailResponse.tipCountTotal,
        tipCountLost = publicLeagueDetailResponse.tipCountLost ?? 0,
        tipCountWon = publicLeagueDetailResponse.tipCountWon ?? 0,
        userRankings = publicLeagueDetailResponse.userRankings
            .map((participantResponse) =>
                Participant.fromParticipantResponse(participantResponse))
            .toList(),
        maximumTipCount = publicLeagueDetailResponse.maximumTipCount ?? 0,
        userTipCountTotal = publicLeagueDetailResponse.userTipCountTotal,
        prizePool = publicLeagueDetailResponse.poolPrizeTotal,
        publicPouleData = PublicPouleData(
            maximumTipCountPerMatch:
                publicLeagueDetailResponse.maximumTipCountPerMatch,
            publicPouleType: publicLeagueDetailResponse.formatType,
            matches: publicLeagueDetailResponse.matches
                .map((matchResponse) =>
                    FootballMatch.fromPublicMatchResponse(matchResponse))
                .toList(),
            coinsForFirst: publicLeagueDetailResponse.poolPrizeAmountFirst ?? 0,
            coinsForSecond:
                publicLeagueDetailResponse.poolPrizeAmountSecond ?? 0,
            coinsForThird: publicLeagueDetailResponse.poolPrizeAmountThird ?? 0,
            coinsForOthers:
                publicLeagueDetailResponse.poolPrizeAmountOthers ?? 0,
            imageUrl: publicLeagueDetailResponse.iconUrl,
            leagues: publicLeagueDetailResponse.leagues
                .map((leagueResponse) =>
                    League.fromLeagueDetailFootballLeagueResponse(
                        leagueResponse))
                .toList()),
        predictionsLeft = publicLeagueDetailResponse.predictionsRemaining ?? 0,
        friendPouleData = null,
        isFinished = publicLeagueDetailResponse.status;

  bool get isPublicLeague => publicPouleData != null;

  bool get isFriendLeague => friendPouleData != null;

  PouleType get pouleType {
    if (isPublicLeague) {
      return PouleType.public;
    } else if (isFriendLeague) {
      return PouleType.friend;
    } else {
      return PouleType.public;
    }
  }

  int get daysLeft {
    return endsAt.difference(DateTime.now()).inDays;
  }
}
