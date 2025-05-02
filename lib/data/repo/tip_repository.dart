import 'package:flutter_better_united/data/enum/poule_type.dart';
import 'package:flutter_better_united/data/model/bookie_maker.dart';
import 'package:flutter_better_united/data/model/paginated_list.dart';
import 'package:flutter_better_united/data/model/tip_with_promoted_bet.dart';
import 'package:flutter_better_united/data/net/api_service.dart';
import 'package:flutter_better_united/data/net/models/create_tip_request.dart';
import 'package:flutter_better_united/util/extensions/bool_extension.dart';

import '../../util/date_util.dart';
import '../../util/exceptions/custom_exceptions.dart';
import '../enum/sort_type.dart';
import '../model/identifier.dart';
import '../model/rewards.dart';
import '../model/tip.dart';
import '../model/tip_revealed_detail.dart';
import '../net/interceptors/error_interceptor.dart';

class TipRepository {
  final ApiService _apiService;

  TipRepository(this._apiService);

  Future<TipWithPromotedBet> createTip({
    required int matchId,
    required int matchBetId,
    required int leagueId,
    required PouleType type,
    required int points,
  }) async {
    try {
      final response = await _apiService.createTip(CreateTipRequest(
        matchId,
        matchBetId,
        type == PouleType.friend ? leagueId : null,
        type == PouleType.public ? leagueId : null,
      ));
      return TipWithPromotedBet.fromTipCreatedResponse(response);
    } catch (error) {
      if (error is BadRequestException) {
        if (error.apiErrorCode == "match_already_started") {
          throw MatchAlreadyStarted();
        } else if (error.apiErrorCode == "tip_already_placed") {
          throw TipAlreadyPlaced();
        } else if (error.apiErrorCode ==
            "public_league_maximum_tips_for_match_reached") {
          throw PublicLeagueMaximumTipsForMatchReached();
        }
      }
      rethrow;
    }
  }

  Future<PaginatedList<TipDetail>> getTips({
    String? searchTerm,
    bool? onlyFollowing,
    int? leagueId,
    int? teamId,
    DateTime? date,
    required SortType sortType,
    required int page,
    int? friendLeagueId,
    bool onlyFriendLeagues = false,
    bool onlyActive = true,
    int? userId,
    bool onlyHistory = false,
    bool? onlyMine,
    bool? onlyOthers,
    int? publicLeagueId,
  }) async {
    String? formattedDate;
    if (date != null) {
      formattedDate = yearMonthDayFormatter.format(date);
    }
    try {
      var response = await _apiService.getTips(
          searchTerm,
          onlyFollowing?.toInt(),
          leagueId,
          teamId,
          formattedDate,
          sortType.name,
          page,
          friendLeagueId,
          onlyFriendLeagues.toInt(),
          onlyActive.toInt(),
          userId,
          onlyHistory.toInt(),
          onlyMine?.toInt(),
          onlyOthers?.toInt(),
          publicLeagueId);
      final tips =
          response.data.map((e) => TipDetail.fromTipDetailResponse(e)).toList();
      return PaginatedList(tips, response.totalPages, response.currentPage,
          response.totalItemCount);
    } catch (error) {
      if (error is BadRequestException) {
        if (error.apiErrorCode == "seeing_other_tips_not_allowed") {
          throw TipsAreHiddenException();
        }
      }
      rethrow;
    }
  }

  Future<void> likeTip(int tipId) {
    return _apiService.likeTip(tipId);
  }

  Future<void> unlikeTip(int tipId) {
    return _apiService.unlikeTip(tipId);
  }

  Future<void> revealTip(int id) async {
    try {
      await _apiService.revealTip(id);
    } catch (error) {
      NotEnoughCoinsException.handleFromBadRequestException(error);
      rethrow;
    }
  }

  Future<TipRevealedDetail> getRevealedTipDetail(int id) async {
    final tipRevealedDetailResponse = await _apiService.getTipDetail(id);
    return TipRevealedDetail.fromTipDetailResponse(tipRevealedDetailResponse);
  }

  Future<List<Identifier>> getUnacknowledgedTips() async {
    final response = await _apiService.getUnacknowledgedTips();
    return response.map((e) => Identifier.fromIdentifierResponse(e)).toList();
  }

  Future<Rewards> getRewards(int id) async {
    final response = await _apiService.getRewards(id);
    return Rewards.fromRewardsResponse(response);
  }

  Future<void> acknowledgeTip(int tipId) {
    return _apiService.acknowledgeTip(tipId);
  }

  Future<List<BookieMaker>?> getAdditionalBets(int tipId) async {
    try {
      final bookieResponse = await _apiService.getAdditionalBets(tipId);
      return bookieResponse
          .map((e) => BookieMaker.fromBookieMakerResponse(e))
          .toList();
    } catch (exception) {
      return null;
    }
  }

  Future<List<BookieMaker>?> getClickableBets(int tipId) async {
    try {
      final bookieResponse = await _apiService.getClickableBets(tipId);
      return bookieResponse
          .map((e) => BookieMaker.fromBookieMakerResponse(e))
          .toList();
    } catch (exception) {
      return null;
    }
  }
}