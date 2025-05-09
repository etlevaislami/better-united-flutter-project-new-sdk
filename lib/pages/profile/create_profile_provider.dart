import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_better_united/data/net/auth_manager.dart';
import 'package:flutter_better_united/data/net/interceptors/error_interceptor.dart';
import 'package:flutter_better_united/data/net/models/birthday_request.dart';
import 'package:flutter_better_united/data/net/models/nickname_request.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:rxdart/rxdart.dart';

import '../../data/model/team.dart';
import '../../data/repo/league_repository.dart';
import '../../data/repo/profile_repository.dart';
import '../../util/date_util.dart';
import '../../util/ui_util.dart';

enum ProfileStep {
  nicknameStep,
  birthdateStep,
  photoStep,
  favoriteClubsStep,
  successStep
}

enum CoachState { neutral, happy, sad }

class ProfileProvider with ChangeNotifier {
  final ProfileRepository _profileRepository;
  final AuthenticatorManager _authenticatorManager;
  final LeagueRepository _leagueRepository;
  final minimumAgeRestriction = 24;
  int currentStepIndex = ProfileStep.nicknameStep.index;
  CoachState nicknameCoachState = CoachState.neutral;
  CoachState birthdateCoachState = CoachState.neutral;
  MemoryImage? profilePicture;
  String nickname = "";
  bool isNextAllowed = false;
  bool isNicknameInUse = false;
  bool isBirthdateValid = false;
  DateTime? birthdate;
  String searchTerm = "";
  List<Team>? allTeams;
  List<Team> teams = [];

  final BehaviorSubject<ProfileStep> redirectionSubject =
      BehaviorSubject<ProfileStep>();

  ProfileProvider(this._profileRepository, this._authenticatorManager,
      this._leagueRepository,
      {List<int>? favoriteTeamIds}) {
    if (favoriteTeamIds != null) {
      userFavoriteTeamIds = favoriteTeamIds;
    }
  }

  @override
  void dispose() {
    super.dispose();
    redirectionSubject.close();
  }

  validateNicknameField() {
    isNextAllowed = nickname.isNotEmpty;
    nicknameCoachState = isNextAllowed ? CoachState.happy : CoachState.neutral;
    isNicknameInUse = false;
    notifyListeners();
  }

  validateBirthdateField() {
    if (birthdate == null) {
      isNextAllowed = false;
      notifyListeners();
      return;
    }
    DateTime today = DateTime.now();
    int yearDiff = today.year - birthdate!.year;
    int monthDiff = today.month - birthdate!.month;
    int dayDiff = today.day - birthdate!.day;
    isBirthdateValid = yearDiff > minimumAgeRestriction ||
        yearDiff == minimumAgeRestriction && monthDiff >= 0 && dayDiff >= 0;
    isNextAllowed = isBirthdateValid;
    birthdateCoachState = isNextAllowed ? CoachState.happy : CoachState.sad;
    notifyListeners();
  }

  onBirthdateStep() async {
    beginLoading();
    try {
      await _profileRepository.setBirthday(BirthdayRequest(birthdate!));
      final user = _authenticatorManager.connectedUser
        ?..dateOfBirth = yearMonthDayFormatter.format(birthdate!);
      _authenticatorManager.connectedUser = user;
      currentStepIndex++;
      redirectionSubject.value = ProfileStep.values[currentStepIndex];
      isNextAllowed = true;
      notifyListeners();
    } catch (exception) {
      showGenericError(exception);
    } finally {
      endLoading();
    }
  }

  onPictureStep() {
    currentStepIndex++;
    redirectionSubject.value = ProfileStep.values[currentStepIndex];
    isNextAllowed = true;
    notifyListeners();
  }

  onNicknameStep() async {
    beginLoading();
    try {
      await _profileRepository.setNickname(NicknameRequest(nickname));
      final user = _authenticatorManager.connectedUser?..nickname = nickname;
      _authenticatorManager.connectedUser = user;
      currentStepIndex++;
      redirectionSubject.value = ProfileStep.values[currentStepIndex];
      isNextAllowed = true;
      isNicknameInUse = false;
      notifyListeners();
    } on ConflictException {
      isNextAllowed = false;
      isNicknameInUse = true;
      nicknameCoachState = CoachState.sad;
      notifyListeners();
    } catch (exception) {
      showGenericError(exception);
    } finally {
      endLoading();
    }
  }

  _uploadProfilePhoto() async {
    final picture = profilePicture;
    if (picture == null) {
      showError("unknownError".tr());
      return;
    }
    await _profileRepository.uploadProfilePhoto(picture);
  }

  onBackClicked() {
    currentStepIndex--;
    redirectionSubject.value = ProfileStep.values[currentStepIndex];
    isNextAllowed = true;
    notifyListeners();
  }

  setProfileImage(MemoryImage image) {
    profilePicture = image;
    notifyListeners();
  }

  finishOnboarding() async {
    try {
      beginLoading();
      if (profilePicture != null) {
        await _uploadProfilePhoto();
      }

      if (userFavoriteTeamIds != null && userFavoriteTeamIds!.isNotEmpty) {
        _profileRepository.addFavoriteTeams(userFavoriteTeamIds ?? []);
      }

      final user = await _profileRepository.getProfile();
      _authenticatorManager.connectedUser = user;
      redirectionSubject.value = ProfileStep.successStep;
    } catch (exception) {
      showGenericError(exception);
    } finally {
      endLoading();
    }
  }

  setBirthdate(DateTime dateTime) {
    birthdate = dateTime;
    validateBirthdateField();
  }

  loadTeams() async {
    if (allTeams == null) {
      teams = [...?allTeams];
      notifyListeners();
    }
  }

  searchTeam(String searchTerm) async {
    this.searchTerm = searchTerm;
    pagingState = PagingState<int, Team>(
        pages: <List<Team>>[],
        keys: <int>[],
        hasNextPage: true,
        isLoading: true,
        error: null);
    notifyListeners();

    await getTeams(searchTerm: searchTerm, pageNumber: 1);
  }

  toggleTeam(Team team) {
    team.isAddedToFavorite = !team.isAddedToFavorite;
    if (team.isAddedToFavorite) {
      userFavoriteTeamIds?.add(team.id);
    } else {
      userFavoriteTeamIds?.remove(team.id);
    }
    final allItems = pagingState.items;
    if (allItems?.isNotEmpty ?? false) {
      final itemsList = allItems?.toList() ?? [];
      _sortByFavoriteTeams(itemsList);

      final updatedPages = <List<Team>>[itemsList];
      final updatedKeys = <int>[1];

      pagingState = PagingState<int, Team>(
          pages: updatedPages,
          keys: updatedKeys,
          hasNextPage: pagingState.hasNextPage,
          isLoading: pagingState.isLoading,
          error: pagingState.error);
    }

    notifyListeners();
  }

  PagingState<int, Team> pagingState = PagingState<int, Team>(
      pages: <List<Team>>[],
      keys: <int>[],
      hasNextPage: true,
      isLoading: false,
      error: null);
  List<int>? userFavoriteTeamIds;

  getTeams({String? searchTerm, required int pageNumber}) async {
    if (userFavoriteTeamIds != null) {
      if (kDebugMode) {
        print("sycning not needed");
      }
    }
    userFavoriteTeamIds ??= (await _profileRepository.getProfile())
        .favoriteTeams
        .map((e) => e.id)
        .toList();

    final paginatedTips = await _leagueRepository.searchTeam(
      searchTerm: searchTerm,
      page: pageNumber,
    );

    List<List<Team>> currentPages =
        List<List<Team>>.from(pagingState.pages ?? []);
    List<int> currentKeys = List<int>.from(pagingState.keys ?? []);

    if (pageNumber == 1) {
      currentPages = [];
      currentKeys = [];
    }

    for (var team in paginatedTips.data) {
      team.isAddedToFavorite = userFavoriteTeamIds?.contains(team.id) ?? false;
    }

    _sortByFavoriteTeams(paginatedTips.data);

    currentPages.add(paginatedTips.data);
    currentKeys.add(pageNumber);

    pagingState = PagingState<int, Team>(
      pages: currentPages,
      keys: currentKeys,
      hasNextPage: !paginatedTips.isLastPage(),
      error: null,
      isLoading: false,
    );
    notifyListeners();
  }

  _sortByFavoriteTeams(List<Team> teams) {
    teams.sort((a, b) => b.isAddedToFavorite == a.isAddedToFavorite
        ? 0
        : b.isAddedToFavorite
            ? 1
            : -1);
  }

  getFavoriteTeams() {
    _profileRepository.getProfile();
  }

  Future<void> addFavoriteTeams() async {
    beginLoading();
    try {
      await _profileRepository.addFavoriteTeams(userFavoriteTeamIds ?? []);
    } catch (exception) {
      showGenericError(exception);
    } finally {
      endLoading();
    }
  }
}
