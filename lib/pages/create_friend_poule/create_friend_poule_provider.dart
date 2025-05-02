import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_better_united/data/model/league.dart';
import 'package:flutter_better_united/util/date_util.dart';
import 'package:flutter_better_united/util/ui_util.dart';
import 'package:rxdart/rxdart.dart';

import '../../constants/friend_poule_prizes.dart' as friend_poule_prizes;
import '../../data/model/football_match.dart';
import '../../data/model/football_matches_by_league.dart';
import '../../data/net/interceptors/error_interceptor.dart';
import '../../data/repo/league_repository.dart';
import '../../run.dart';
import '../../util/exceptions/custom_exceptions.dart';
import '../shop/user_provider.dart';

enum CreateFriendPouleStep {
  rules,
  selectMatch,
  nameAndPrize,
  success,
  notEnoughCredit
}

class GroupedMatches {
  final League league;
  final List<FootballMatch> matches;

  GroupedMatches(this.league, this.matches);
}

class CreateFriendPouleProvider with ChangeNotifier {
  final LeagueRepository leagueRepository;
  final UserProvider userProvider;
  int activeStepIndex = CreateFriendPouleStep.rules.index;
  final BehaviorSubject<CreateFriendPouleStep> redirectionSubject =
      BehaviorSubject<CreateFriendPouleStep>();
  final todayDate = DateTime.now().untilMidnight();
  late DateTime? selectedDate = todayDate;
  late final DateTime endDate = todayDate.add(const Duration(days: 40));
  late final DateTime startDate = todayDate.add(const Duration(days: -40));
  List<FootballMatch> matchesFromFavoriteClubs = [];
  List<FootballMatchesByLeague>? matchesByLeagues;
  FootballMatch? selectedMatch;
  String? pouleName;
  String? pouleNameValidationError;
  final prizePools = friend_poule_prizes.prizePools;
  late int selectedPrizePool = prizePools.first;
  late int selectedPrizePoolIndex = 0;
  bool showBox = false;

  CreateFriendPouleProvider(this.userProvider, this.leagueRepository);

  fetchMatches({DateTime? date, String? searchTerm}) async {
    matchesByLeagues = null;
    matchesFromFavoriteClubs = [];
    notifyListeners();
    final data = await leagueRepository.getMatches(
        matchDay: date, searchTerm: searchTerm);
    matchesByLeagues = data;
    matchesFromFavoriteClubs = data
        .expand((element) => element.matches)
        .where((element) => element.hasFavouriteTeam)
        .toList();
    if (hasListeners) {
      notifyListeners();
    }
  }

  onNextClicked() async {
    activeStepIndex++;
    redirectionSubject.value = CreateFriendPouleStep.values[activeStepIndex];
  }

  onBackClicked() {
    activeStepIndex--;
    redirectionSubject.value = CreateFriendPouleStep.values[activeStepIndex];
    notifyListeners();
  }

  onDateSelected(DateTime date) {
    if (date.isBefore(todayDate)) {
      return;
    }
    selectedDate = date;
    notifyListeners();
    fetchMatches(date: date);
  }

  onMatchSelected(FootballMatch match) {
    selectedMatch = match;
    onNextClicked();
    notifyListeners();
  }

  onPouleNameChanged(String value) {
    pouleName = value;
  }

  _validatePouleName() async {
    if (pouleName == null || pouleName!.isEmpty) {
      pouleNameValidationError = "pouleNameRequired".tr();
    } else {
      beginLoading();
      try {
        await leagueRepository.checkFriendLeagueName(pouleName!);
        pouleNameValidationError = null;
        notifyListeners();
      } on ConflictException {
        pouleNameValidationError = "pouleNameAlreadyTaken".tr();
        notifyListeners();
      } catch (exception) {
        showGenericError(exception);
      } finally {
        endLoading();
      }
    }
    notifyListeners();
    if (pouleNameValidationError != null) {
      throw Exception(pouleNameValidationError!);
    }
  }

  Future<int> onCreatePoule() async {
    await _validatePouleName();
    if (userProvider.userCoins < selectedPrizePool) {
      throw NotEnoughCoinsException();
    }
    try {
      beginLoading();
      final pouleId = await leagueRepository.createFriendLeague(
        name: pouleName!,
        matchId: selectedMatch!.id,
        entryFee: selectedPrizePool,
      );
      userProvider.syncUserProfile();
      logger.e(pouleId);
      return pouleId;
    } on ConflictException {
      pouleNameValidationError = "pouleNameAlreadyTaken".tr();
      activeStepIndex = CreateFriendPouleStep.values
          .indexOf(CreateFriendPouleStep.nameAndPrize);
      redirectionSubject.value = CreateFriendPouleStep.nameAndPrize;
      showError("pouleNameAlreadyTaken".tr());
      notifyListeners();
      rethrow;
    } catch (err) {
      logger.e(err);
      rethrow;
    } finally {
      endLoading();
    }
  }

  onPouleCreated() {
    redirectionSubject.value = CreateFriendPouleStep.success;
  }

  onPrizePoolSelected(int index) {
    selectedPrizePoolIndex = index;
    selectedPrizePool = prizePools[index];
    notifyListeners();
  }

  bool isSearchEnabled = false;

  onSearchMatch(String query) {
    final searchTerm = query.trim();
    if (searchTerm.isNotEmpty) {
      selectedDate = null;
      fetchMatches(searchTerm: searchTerm);
    }
  }

  setRulesShowBox(bool value) {
    showBox = value;
    notifyListeners();
    leagueRepository.saveFriendPouleRulesVisibilityOptions(!showBox);
  }

  bool getFriendPouleRulesVisibilityOptions() {
    return leagueRepository.getFriendPouleRulesVisibilityOptions();
  }
}
