import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_better_united/data/enum/poule_type.dart';
import 'package:flutter_better_united/data/model/football_matches_by_league.dart';
import 'package:flutter_better_united/data/model/league_detail.dart';
import 'package:flutter_better_united/data/repo/tip_repository.dart';
import 'package:flutter_better_united/util/date_util.dart';
import 'package:rxdart/rxdart.dart';

import '../../data/model/filter_criteria.dart';
import '../../data/model/football_match.dart';
import '../../data/model/tip_with_promoted_bet.dart';
import '../../data/repo/league_repository.dart';
import '../../util/exceptions/custom_exceptions.dart';
import '../../util/ui_util.dart';

enum CreatePredictionStep {
  selectPoule,
  selectMatch,
  selectPrediction,
  overview,
  success,
}

class CreatePredictionProvider with ChangeNotifier {
  final LeagueRepository leagueRepository;
  final TipRepository tipRepository;
  FilterCriteria? filterCriteria;
  final List<CreatePredictionStep> steps;
  List<LeagueDetail>? poules;

  CreatePredictionProvider(this.leagueRepository, this.tipRepository,
      {required this.steps, required LeagueDetail? poule}) {
    selectedPoule = poule;
    if (poule?.pouleType == PouleType.friend) {
      selectedMatch = poule?.friendPouleData?.match;
    } else if (poule?.pouleType == PouleType.public) {
      final matches = poule?.publicPouleData?.matches;
      if (matches != null && matches.isNotEmpty && matches.length == 1) {
        selectedMatch = matches.first;
      }
    }
  }

  final todayDate = DateTime.now().untilMidnight();
  late DateTime selectedDate = todayDate;
  late final DateTime endDate = todayDate.add(const Duration(days: 40));
  late final DateTime startDate = todayDate.add(const Duration(days: -40));
  int activeStepIndex = CreatePredictionStep.selectPoule.index;
  final BehaviorSubject<CreatePredictionStep> redirectionSubject =
      BehaviorSubject<CreatePredictionStep>();
  LeagueDetail? selectedPoule;
  List<FootballMatch> matchesFromFavoriteClubs = [];
  List<FootballMatchesByLeague>? matchesByLeagues;
  FootballMatch? selectedMatch;
  OddsList? betCategories;
  int? lastSelectedMatchId;
  int? points;
  int? betId;
  String? hint;

  fetchOdds() async {
    if (selectedPoule != null && selectedMatch != null && selectedMatch?.id != lastSelectedMatchId) {
      lastSelectedMatchId = selectedMatch?.id;
      betCategories = await leagueRepository.getOdds(pouleType: selectedPoule!.pouleType, pouleId: selectedPoule!.id, matchId:  selectedMatch!.id);
      notifyListeners();
    }
  }

  fetchPoules(PouleType pouleType) async {
    if (pouleType == PouleType.friend) {
      poules = (await leagueRepository.getFriendPoules())
          .map((e) => LeagueDetail.fromFriendLeagueInfo(e))
          .toList();
    } else {
      poules = (await leagueRepository.getPublicLeagues(joined: true))
          .map((e) => LeagueDetail.fromPublicLeagueJoinInfo(e))
          .toList();
    }
    notifyListeners();
  }

  void setSelectedPoule(LeagueDetail poule) {
    selectedPoule = poule;
    notifyListeners();
    if (poule.pouleType == PouleType.friend) {
      selectedMatch = poule.friendPouleData?.match;
    } else {
      fetchMatches(selectedDate);
    }
    onNextClicked();
    notifyListeners();
  }

  onNextClicked() async {
    activeStepIndex++;
    redirectionSubject.value = steps[activeStepIndex];
  }

  onBackClicked() {
    activeStepIndex--;
    redirectionSubject.value = steps[activeStepIndex];
    notifyListeners();
  }

  clearMatch() {
    lastSelectedMatchId = null;
    notifyListeners();
  }

  onDateSelected(DateTime date) {
    if (date.isBefore(todayDate)) {
      return;
    }
    selectedDate = date;
    notifyListeners();
    fetchMatches(date);
  }

  onMatchSelected(FootballMatch match) {
    selectedMatch = match;
    onNextClicked();
    notifyListeners();
  }

  fetchMatches(DateTime date) async {
    matchesByLeagues = null;
    matchesFromFavoriteClubs = [];
    notifyListeners();
    final data = await leagueRepository.getMatches(
        matchDay: date,
        publicPouleId:
            selectedPoule?.isPublicLeague ?? false ? selectedPoule?.id : null);
    matchesByLeagues = data;
    matchesFromFavoriteClubs = data
        .expand((element) => element.matches)
        .where((element) => element.hasFavouriteTeam)
        .toList();
    if (hasListeners) {
      notifyListeners();
    }
  }

  onPredictionSelected(int betId, int points, String hint) {
    this.betId = betId;
    this.points = points;
    this.hint = hint;
    notifyListeners();
    onNextClicked();
  }

  Future<TipWithPromotedBet> sharePrediction() async {
    final selectedMatch = this.selectedMatch;
    final pouleId = selectedPoule?.id;
    final type = selectedPoule?.pouleType;
    final betId = this.betId;
    final points = this.points;
    if (type != null &&
        pouleId != null &&
        selectedMatch != null &&
        points != null &&
        betId != null) {
      try {
        beginLoading();
        final tipWithPromotedBet = await tipRepository.createTip(
          type: type,
          leagueId: pouleId,
          matchId: selectedMatch.id,
          matchBetId: betId,
          points: points,
        );
        return tipWithPromotedBet;
      } on MatchAlreadyStarted {
        showError("matchAlreadyStarted".tr());
        rethrow;
      } on TipAlreadyPlaced {
        showError("tipAlreadyPlaced".tr());
        rethrow;
      } on PublicLeagueMaximumTipsForMatchReached {
        rethrow;
      } catch (exception) {
        showGenericError(exception);
        rethrow;
      } finally {
        endLoading();
      }
    }
    throw Exception("Invalid data");
  }
}
