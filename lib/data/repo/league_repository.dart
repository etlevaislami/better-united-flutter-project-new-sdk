import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_better_united/constants/market_ids.dart';
import 'package:flutter_better_united/data/model/football_match.dart';
import 'package:flutter_better_united/data/model/football_matches_by_league.dart';
import 'package:flutter_better_united/data/model/friend_league.dart';
import 'package:flutter_better_united/data/model/league.dart';
import 'package:flutter_better_united/data/model/league_detail.dart';
import 'package:flutter_better_united/data/model/team.dart';
import 'package:flutter_better_united/data/net/api_service.dart';
import 'package:flutter_better_united/data/net/models/bet_info_response.dart';
import 'package:flutter_better_united/data/net/models/friend_league_name_request.dart';
import 'package:flutter_better_united/data/net/models/self_invite_request.dart';
import 'package:flutter_better_united/pages/create_prediction/prediction_widgets/correct_score.dart';
import 'package:flutter_better_united/pages/create_prediction/prediction_widgets/half_time_full_time.dart';
import 'package:flutter_better_united/pages/create_prediction/prediction_widgets/home_draw_away.dart';
import 'package:flutter_better_united/pages/create_prediction/prediction_widgets/player_to_score_anytime.dart';
import 'package:flutter_better_united/util/exceptions/custom_exceptions.dart';
import 'package:flutter_better_united/util/extensions/bool_extension.dart';
import 'package:flutter_better_united/util/extensions/int_extension.dart';

import '../../pages/create_prediction/prediction_widgets/ToScoreFirst.dart';
import '../../pages/create_prediction/prediction_widgets/both_team_to_score.dart';
import '../../pages/create_prediction/prediction_widgets/handicap.dart';
import '../../util/date_util.dart';
import '../../util/settings.dart';
import '../enum/poule_type.dart';
import '../model/active_poule_list.dart';
import '../model/friend.dart';
import '../model/friend_league_detail.dart';
import '../model/friend_league_info.dart';
import '../model/paginated_list.dart';
import '../model/public_league_join_info.dart';
import '../net/interceptors/error_interceptor.dart';
import '../net/models/create_friend_league_request.dart';
import '../net/models/market_response.dart';
import '../net/models/match_response.dart';

abstract class OddData {
  final int id;
  final bool isFolded;
  final bool isEnabled;

  OddData(this.id, this.isFolded, this.isEnabled);
}

abstract class OddDataBuilder {
  OddData build(
      TeamResponse homeTeam, TeamResponse awayTeam, MarketResponse market);
}

class OddsList {
  final List<OddData> popular;
  final List<OddData> additional;

  OddsList({required this.popular, required this.additional});

  get isEmpty => popular.isEmpty && additional.isEmpty;
}

class OddDataFactory {
  static OddDataBuilder getBuilder(int marketId) {
    switch (marketId) {
      case MarketIds.correctScore:
        return CorrectScoreDataBuilder();
      case MarketIds.homeDrawAway:
        return HomeDrawAwayDataBuilder();
      case MarketIds.handicap:
        return HandicapDataBuilder();
      case MarketIds.firstPlayerToScore:
        return FirstPlayerToScoreDataBuilder();
      case MarketIds.bothTeamToScore:
        return BothTeamsToScoreDataBuilder();
      case MarketIds.halfTimeFullTime:
        return HalfTimeFullTimeDataBuilder();
      case MarketIds.underOver:
        return UnderOverDataBuilder();
      case MarketIds.playerToScoreAnytime:
        return PlayerToScoreAnytimeDataBuilder();
      default:
        throw UnknownMarketException();
    }
  }

  static OddData build(int marketId, TeamResponse homeTeam,
      TeamResponse awayTeam, MarketResponse market) {
    return getBuilder(marketId).build(homeTeam, awayTeam, market);
  }
}

class HandicapDataBuilder implements OddDataBuilder {
  @override
  OddData build(
      TeamResponse homeTeam, TeamResponse awayTeam, MarketResponse market) {
    getOddName(String name) {
      switch (name) {
        case "1":
          return homeTeam.name;
        case "2":
          return awayTeam.name;
        case "X":
          return "draw".tr();
        default:
          return name;
      }
    }

    final groups = market.odds.groupListsBy((element) => element.line);
    final List<GroupedBets> groupedBets = [];
    groups.forEach((key, value) {
      if (key != null) {
        final score = key.replaceAll(":", "-");
        final String title = "handicapScore".tr(args: [score]);
        List<BetData> bets = value
            .map((e) => BetData(
                betId: e.id,
                points: e.points,
                hint: e.hints?.first ?? "",
                text: getOddName(e.name)))
            .toList();
        groupedBets.add(GroupedBets(groupName: title, bets: bets));
      }
    });
    return HandicapData(MarketIds.handicap, market.marketIsFolded.toBool(),
        !market.marketIsAlreadyPlayed.toBool(), groupedBets);
  }
}

class CorrectScoreDataBuilder implements OddDataBuilder {
  @override
  OddData build(
      TeamResponse homeTeam, TeamResponse awayTeam, MarketResponse market) {
    final otherOdd =
        market.odds.firstWhere((element) => element.name == "any_other_score");
    market.odds.remove(otherOdd);
    final scores = market.odds
        .map((e) => ScorePoints(
            score: e.name,
            points: e.points,
            betId: e.id,
            hint: e.hints?.firstOrNull ?? ""))
        .toList();
    return CorrectScoreData(
        MarketIds.correctScore, market.marketIsFolded.toBool(), !market.marketIsAlreadyPlayed.toBool(),
        homeTeamName: homeTeam.name,
        awayTeamName: awayTeam.name,
        otherPoints: otherOdd.points,
        otherBetId: otherOdd.id,
        otherBetHint: otherOdd.hints?.firstOrNull ?? "",
        scores: scores);
  }
}

class HomeDrawAwayDataBuilder implements OddDataBuilder {
  @override
  OddData build(
      TeamResponse homeTeam, TeamResponse awayTeam, MarketResponse market) {
    final homeOdd = market.odds.firstWhere((element) => element.name == "1");
    final awayOdd = market.odds.firstWhere((element) => element.name == "2");
    final drawOdd = market.odds.firstWhere((element) => element.name == "X");
    return HomeDrawAwayData(
        MarketIds.homeDrawAway, market.marketIsFolded.toBool(), !market.marketIsAlreadyPlayed.toBool(),
        awayTeamName: awayTeam.name,
        homeTeamName: homeTeam.name,
        homeTeamPoints: homeOdd.points,
        awayTeamPoints: awayOdd.points,
        drawPoints: drawOdd.points,
        awayTeamBetId: awayOdd.id,
        homeTeamBetId: homeOdd.id,
        drawBetId: drawOdd.id,
        awayHint: awayOdd.hints?.firstOrNull ?? "",
        drawHint: drawOdd.hints?.firstOrNull ?? "",
        homeHint: homeOdd.hints?.firstOrNull ?? "");
  }
}

class FirstPlayerToScoreDataBuilder implements OddDataBuilder {
  @override
  OddData build(
      TeamResponse homeTeam, TeamResponse awayTeam, MarketResponse market) {
    final bets = market.odds
        .map((e) => BetData(
            betId: e.id,
            points: e.points,
            text: e.name,
            hint: e.hints?.firstOrNull ?? ""))
        .toList();
    return FirstPlayerToScoreData(
        MarketIds.firstPlayerToScore,
        market.marketIsFolded.toBool(),
        !market.marketIsAlreadyPlayed.toBool(),
        bets);
  }
}

class PlayerToScoreAnytimeDataBuilder implements OddDataBuilder {
  @override
  OddData build(
      TeamResponse homeTeam, TeamResponse awayTeam, MarketResponse market) {
    final bets = market.odds
        .map((e) => BetData(
            betId: e.id,
            points: e.points,
            text: e.name,
            hint: e.hints?.firstOrNull ?? ""))
        .toList();
    return PlayerToScoreAnytimeData(
        MarketIds.playerToScoreAnytime,
        market.marketIsFolded.toBool(),
        !market.marketIsAlreadyPlayed.toBool(),
        bets);
  }
}

class BothTeamsToScoreDataBuilder implements OddDataBuilder {
  @override
  OddData build(
      TeamResponse homeTeam, TeamResponse awayTeam, MarketResponse market) {
    final yes = market.odds.firstWhere((element) => element.name == "Yes");
    final no = market.odds.firstWhere((element) => element.name == "No");
    return BooleanOddData(
      MarketIds.bothTeamToScore,
      market.marketIsFolded.toBool(),
      !market.marketIsAlreadyPlayed.toBool(),
      yesPoints: yes.points,
      noPoints: no.points,
      yesBetId: yes.id,
      noBetId: no.id,
      noHint: no.hints?.firstOrNull ?? "",
      yesHint: yes.hints?.firstOrNull ?? "",
    );
  }
}

class HalfTimeFullTimeDataBuilder implements OddDataBuilder {
  @override
  OddData build(
      TeamResponse homeTeam, TeamResponse awayTeam, MarketResponse market) {
    getOddName(String name) {
      switch (name) {
        case "1":
          return homeTeam.name;
        case "2":
          return awayTeam.name;
        case "X":
          return "draw".tr();
        default:
          return name;
      }
    }

    final groups = market.odds.groupListsBy((element) => element.name[0]);
    final List<GroupedBets> groupedBets = [];
    groups.forEach((key, value) {
      List<BetData> bets = value
          .map((e) => BetData(
              betId: e.id,
              points: e.points,
              hint: e.hints?.first ?? "",
              text: "${getOddName(e.name[0])} / ${getOddName(e.name[2])}"))
          .toList();
      groupedBets.add(GroupedBets(bets: bets));
    });
    return HalfTimeFullTimeData(MarketIds.halfTimeFullTime,
        market.marketIsFolded.toBool(),
        !market.marketIsAlreadyPlayed.toBool(),
        groupedBets);
  }
}

class UnderOverData extends OddData {
  final Map<double, UnderOverItem> groupedBets;

  UnderOverData(super.id, super.isFolded, super.isEnabled, this.groupedBets);
}

class UnderOverItem {
  final int underBetId;
  final int overBetId;
  final int underPoints;
  final int overPoints;
  final String underHint;
  final String overHint;

  UnderOverItem(
      {required this.underBetId,
      required this.overBetId,
      required this.underPoints,
      required this.overPoints,
      required this.underHint,
      required this.overHint});
}

class UnderOverDataBuilder implements OddDataBuilder {
  @override
  OddData build(
      TeamResponse homeTeam, TeamResponse awayTeam, MarketResponse market) {
    final lines = market.odds.groupListsBy((element) => element.line);
    // filter line values that don't exist in each group
    lines.removeWhere((key, value) => value.length != 2);

    final values = lines.map((key, value) {
      final over = value.firstWhere((element) => element.name == "Over");
      final under = value.firstWhere((element) => element.name == "Under");
      return MapEntry(
          double.parse(key!),
          UnderOverItem(
              underBetId: under.id,
              overBetId: over.id,
              underPoints: under.points,
              overPoints: over.points,
              underHint: under.hints?.firstOrNull ?? "",
              overHint: over.hints?.firstOrNull ?? ""));
    });
    return UnderOverData(MarketIds.underOver, market.marketIsFolded.toBool(),
        !market.marketIsAlreadyPlayed.toBool(), values);
  }
}

class LeagueRepository {
  final ApiService _apiService;
  final Settings _settings;

  LeagueRepository(this._apiService, this._settings);

  Future<List<League>> getLeagues(
      {DateTime? matchDay, bool showAll = false}) async {
    String? formattedStartsAtDate;
    String? formattedEndsAtDate;
    if (matchDay != null) {
      final startsAt =
          DateTime(matchDay.year, matchDay.month, matchDay.day, 00, 1);
      final endsAt =
          DateTime(startsAt.year, startsAt.month, startsAt.day, 23, 59)
              .add(const Duration(days: 4));
      formattedStartsAtDate = apiDateFormatter.format(startsAt.toUtc());
      formattedEndsAtDate = apiDateFormatter.format(endsAt.toUtc());
    }
    var response = await _apiService.getLeagues(
        formattedStartsAtDate, formattedEndsAtDate, showAll ? 1 : 0);

    return response
        .map((leagueResponse) => League.fromLeagueResponse(leagueResponse))
        .toList();
  }

  Future<List<FootballMatchesByLeague>> getMatches(
      {int? publicPouleId, DateTime? matchDay, String? searchTerm}) async {
    String? startsAt;
    String? endsAt;
    if (matchDay != null) {
      final startDate =
          DateTime(matchDay.year, matchDay.month, matchDay.day, 00, 1).toUtc();
      final endDate =
          DateTime(matchDay.year, matchDay.month, matchDay.day, 23, 59).toUtc();
      startsAt = apiDateFormatter.format(startDate);
      endsAt = apiDateFormatter.format(endDate);
    }
    try {
      var response = await _apiService.getMatches(
          startsAt, endsAt, publicPouleId, searchTerm);
      return response
          .map((e) => FootballMatchesByLeague.fromMatchesByLeagueResponse(e))
          .toList();
    } catch (e) {
      if (e is NotFoundException) {
        return [];
      }
      rethrow;
    }
  }

  Future<List<FootballMatch>> getMatchesByLeague(
      int leagueId, DateTime matchDay) async {
    final startsAt =
        DateTime(matchDay.year, matchDay.month, matchDay.day, 00, 1);
    final endsAt = DateTime(startsAt.year, startsAt.month, startsAt.day, 23, 59)
        .add(const Duration(days: 4));
    var response = await _apiService.getMatchesByLeague(
        leagueId,
        apiDateFormatter.format(startsAt.toUtc()),
        apiDateFormatter.format(endsAt.toUtc()));
    return response.map((e) => FootballMatch.fromMatchResponse(e)).toList();
  }

  Future<PaginatedList<Team>> searchTeam(
      {String? searchTerm, required int page}) async {
    final response = await _apiService.searchTeam(searchTerm, page);
    final teams = response.data.map((e) => Team.fromTeamResponse(e)).toList();
    return PaginatedList(teams, response.totalPages, response.currentPage,
        response.totalItemCount);
  }

  Future<int> createFriendLeague(
      {required String name,
      required int entryFee,
      required int matchId}) async {
    try {
      final response = await _apiService.createFriendLeague(
          CreateFriendLeagueRequest(name, entryFee, matchId));
      return int.parse(response.id);
    } catch (error) {
      NotEnoughCoinsException.handleFromBadRequestException(error);
      rethrow;
    }
  }

  Future<FriendLeagueDetail> getFriendLeagueDetail(
      {required int leagueId}) async {
    var response = await _apiService.getFriendLeagueDetail(leagueId);
    final friendLeagueDetail =
        FriendLeagueDetail.fromFriendLeagueDetailResponse(response);
    final participants = friendLeagueDetail.userRankings;
    for (int i = 0; i < participants.length; i++) {
      final participant = participants[i];
      participant.index = i;
    }
    return friendLeagueDetail;
  }

  Future<LeagueDetail> getLeagueDetail(
      {required int leagueId, required PouleType type}) async {
    late final LeagueDetail leagueDetail;
    switch (type) {
      case PouleType.public:
        final response = await _apiService.getPublicLeagueDetail(leagueId);
        leagueDetail = LeagueDetail.fromPublicLeagueDetailResponse(response);
        break;
      case PouleType.friend:
        final response = await _apiService.getFriendLeagueDetail(leagueId);
        leagueDetail = LeagueDetail.fromFriendLeagueDetailResponse(response);
        break;
    }

    final participants = leagueDetail.userRankings;
    for (int i = 0; i < participants.length; i++) {
      final participant = participants[i];
      participant.index = i;
    }
    return leagueDetail;
  }

  Future<List<Friend>> getFriends() async {
    var response = await _apiService.getFriends();
    return response
        .map((friendResponse) => Friend.fromFriendResponse(friendResponse))
        .toList();
  }

  Future<List<Friend>> getFriendsByFriendLeague(int friendLeagueId) async {
    var response = await _apiService.getFriendsByFriendLeagueId(friendLeagueId);
    return response
        .map((friendResponse) => Friend.fromFriendResponse(friendResponse))
        .toList();
  }

  Future<void> checkFriendLeagueName(String friendLeagueName) async {
    await _apiService
        .checkFriendLeagueName(FriendLeagueNameRequest(friendLeagueName));
  }

  Future<OddsList> getOdds({required PouleType pouleType, required int pouleId, required int matchId}) async {
    try {
      final List<OddData> popularOdds = [];
      final List<OddData> additionalOdds = [];

      final BetInfoResponse? result;
      if (pouleType == PouleType.friend) {
        result = await _apiService.getFriendPouleOdds(matchId, pouleId);
      } else if (pouleType == PouleType.public) {
        result = await _apiService.getPublicPouleOdds(matchId, pouleId);
      } else {
        throw Exception('Missing implementation for pouletype $pouleType');
      }

      for (var marketResponse in result.popular) {
        try {
          popularOdds.add(OddDataFactory.getBuilder(marketResponse.marketId)
              .build(result.homeTeam, result.awayTeam, marketResponse));
        } on UnknownMarketException catch (e) {
          continue;
        }
      }
      for (var marketResponse in result.additional) {
        try {
          additionalOdds.add(OddDataFactory.getBuilder(marketResponse.marketId)
              .build(result.homeTeam, result.awayTeam, marketResponse));
        } on UnknownMarketException catch (e) {
          continue;
        }
      }
      return OddsList(popular: popularOdds, additional: additionalOdds);
    } catch (error) {
      if (error is BadRequestException) {
        if (error.apiErrorCode == "match_already_started") {
          throw MatchAlreadyStarted();
        }
      }
      return OddsList(popular: [], additional: []);
    }
  }

  Future<List<FriendLeague>> getFriendLeagues(
      {required bool isFinished, int baseLeagueId = 0}) async {
    var response =
        await _apiService.getFriendLeagues(baseLeagueId, isFinished ? 1 : 0);
    return response
        .map((friendLeagueResponse) =>
            FriendLeague.fromFriendLeagueResponse(friendLeagueResponse))
        .toList();
  }

  Future<List<FriendLeagueInfo>> getFriendPoules() async {
    var response = await _apiService.getFriendPoules();
    return response
        .map((friendLeagueResponse) =>
            FriendLeagueInfo.fromFriendLeagueActivePouleItem(
                friendLeagueResponse))
        .toList();
  }

  Future acceptInvite(int leagueId, PouleType pouleType) async {
    try {
      switch (pouleType) {
        case PouleType.public:
          await _apiService.acceptPublicLeagueInvite(leagueId);
          break;
        case PouleType.friend:
          await _apiService.acceptFriendLeagueInvite(leagueId);
          break;
      }
    } catch (e) {
      if (e is BadRequestException) {
        if (e.apiErrorCode == "invite_already_accepted_or_declined") {
          throw InviteAlreadyAcceptedOrDeclined();
        } else if (e.apiErrorCode == "max_limit_reached") {
          throw FriendLeagueMaxLimitReachedException();
        } else if (e.apiErrorCode == "match_already_in_progress") {
          throw MatchAlreadyInProgress();
        }
      } else if (e is NotFoundException) {
        throw PouleNotFound();
      }
      NotEnoughCoinsException.handleFromBadRequestException(e);
      rethrow;
    }
  }

  Future declineInvite(int leagueId, PouleType pouleType) async {
    try {
      switch (pouleType) {
        case PouleType.public:
          await _apiService.declinePublicLeagueInvite(leagueId);
          break;
        case PouleType.friend:
          await _apiService.declineFriendLeagueInvite(leagueId);
          break;
      }
    } catch (e) {
      if (e is BadRequestException) {
        if (e.apiErrorCode == "invite_already_accepted_or_declined") {
          throw InviteAlreadyAcceptedOrDeclined();
        }
      } else if (e is NotFoundException) {
        throw PouleNotFound();
      }
      rethrow;
    }
  }

  Future<int> selfInvite(int friendLeagueId) async {
    try {
      final response =
          await _apiService.inviteSelf(SelfInviteRequest(friendLeagueId));
      return response.id;
    } catch (error) {
      if (error is NotFoundException) {
        throw PouleNotFound();
      }
      NotEnoughCoinsException.handleFromBadRequestException(error);
      rethrow;
    }
  }

  Future<ActivePouleList> getActivePoules() async {
    var response = await _apiService.getActivePouleList();
    return ActivePouleList.fromActivePouleListResponse(response);
  }

  Future<void> removeFriendPoule(int pouleId) {
    return _apiService.removeFriendPoule(pouleId);
  }

  Future<void> removePublicPoule(int pouleId) {
    return _apiService.removePublicPoule(pouleId);
  }

  Future<List<PublicLeagueJoinInfo>> getPublicLeagues(
      {required bool joined}) async {
    var response = await _apiService.getPublicPoules(joined.toInt() ?? 0);
    return response
        .map((publicLeagueJoinInfoResponse) =>
            PublicLeagueJoinInfo.fromPublicLeagueJoinInfoResponse(
                publicLeagueJoinInfoResponse))
        .toList();
  }

  Future<void> joinPublicLeague(int pouleId) async {
    try {
      await _apiService.joinPublicLeague(pouleId);
    } catch (error) {
      NotEnoughCoinsException.handleFromBadRequestException(error);
      rethrow;
    }
  }

  Future<void> inviteToLeague(
      {required int friendId, required int leagueId, required PouleType type}) {
    switch (type) {
      case PouleType.public:
        return _apiService.inviteFriendToPublicLeague(leagueId, friendId);
      case PouleType.friend:
        return _apiService.inviteFriendToFriendLeague(leagueId, friendId);
    }
  }

  Future<void> inviteAllToLeague(
      {required int leagueId, required PouleType type}) {
    switch (type) {
      case PouleType.public:
        return _apiService.inviteAllFriendsToPublicLeague(leagueId);
      case PouleType.friend:
        return _apiService.inviteAllFriendsToFriendLeague(leagueId);
    }
  }

  void saveFriendPouleRulesVisibilityOptions(bool isVisible) {
    _settings.isFriendRulesVisible = isVisible;
  }

  bool getFriendPouleRulesVisibilityOptions() {
    return _settings.isFriendRulesVisible;
  }
}
