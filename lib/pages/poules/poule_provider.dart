import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_better_united/data/model/league_detail.dart';
import 'package:flutter_better_united/util/ui_util.dart';

import '../../data/enum/poule_type.dart';
import '../../data/model/filter_criteria.dart';
import '../../data/model/participant.dart';
import '../../data/repo/league_repository.dart';

class PouleProvider with ChangeNotifier {
  final int pouleId;
  final PouleType pouleType;
  LeagueDetail? poule;
  final int connectedUserId;
  List<Participant> _participants = [];

  late List<Participant> participants = sortParticipantList(connectedUserId);
  bool isExpanded = false;
  int collapsedPlayerLength = 4;
  late FilterCriteria filterCriteria;
  final LeagueRepository leagueRepository;

  PouleProvider(
    this.leagueRepository, {
    required this.pouleId,
    required this.connectedUserId,
    required this.pouleType,
  });

  getPouleDetail() async {
    getUserPredictions();
    final pouleDetail = await leagueRepository.getLeagueDetail(
        leagueId: pouleId, type: pouleType);
    poule = pouleDetail;
    _participants = pouleDetail.userRankings;
    if (isExpanded) {
      expandPlayerList();
    } else {
      collapsePlayerList();
    }
    notifyListeners();
  }

  getUserPredictions() {
    final friendLeagueId = pouleType == PouleType.friend ? pouleId : null;
    final publicLeagueId = pouleType == PouleType.public ? pouleId : null;
    filterCriteria = FilterCriteria(
        onlyMine: true,
        publicLeagueId: publicLeagueId,
        friendLeagueId: friendLeagueId);
    if (hasListeners) {
      notifyListeners();
    }
  }

  getOtherPredictions() {
    final friendLeagueId = pouleType == PouleType.friend ? pouleId : null;
    final publicLeagueId = pouleType == PouleType.public ? pouleId : null;
    filterCriteria = FilterCriteria(
        friendLeagueId: friendLeagueId,
        publicLeagueId: publicLeagueId,
        onlyOthers: true);
    if (hasListeners) {
      notifyListeners();
    }
  }

  List<Participant> sortParticipantList(int connectedUserId) {
    final participants = [..._participants];

    if (participants.length <= 4) {
      return participants;
    }
    int index =
        participants.indexWhere((element) => element.userId == connectedUserId);
    int lastIndex = participants.length - 1;
    final connectedUser = participants[index];

    if (lastIndex == index) {
      // user is last
      collapsedPlayerLength = 4;
      participants.removeAt(index);
      participants.insert(3, connectedUser);
    } else {
      // user is not last
      if (index < 3) {
        // user is in top 3
        collapsedPlayerLength = 4;
        final lastParticipant = participants[lastIndex];
        participants.removeAt(lastIndex);
        participants.insert(3, lastParticipant);
      } else {
        // user is not in top 4
        // move it to 4 position and move last to 5 position
        participants.removeAt(index);
        participants.insert(3, connectedUser);

        final lastParticipant = participants[lastIndex];
        participants.removeAt(lastIndex);
        participants.insert(4, lastParticipant);
        collapsedPlayerLength = 5;
      }
    }
    return participants.sublist(0, collapsedPlayerLength);
  }

  toggleExpandPlayerList() {
    if (isExpanded) {
      collapsePlayerList();
    } else {
      expandPlayerList();
    }
  }

  expandPlayerList() {
    participants = [..._participants];
    isExpanded = true;
    notifyListeners();
  }

  collapsePlayerList() {
    participants = sortParticipantList(connectedUserId);
    isExpanded = false;
    notifyListeners();
  }

  filterPredictionsByPlayerName(String query) {
    final trimmedQuery = query.trim();
    final friendLeagueId = pouleType == PouleType.friend ? pouleId : null;
    final publicLeagueId = pouleType == PouleType.public ? pouleId : null;
    filterCriteria = FilterCriteria(
        friendLeagueId: friendLeagueId,
        publicLeagueId: publicLeagueId,
        searchQuery: trimmedQuery,
        onlyOthers: true);
    if (hasListeners) {
      notifyListeners();
    }
  }

  Future<void> refreshDetail() async {
    filterCriteria =
        FilterCriteria.copy(filterCriteria..incrementRefreshCounter());
    final pouleDetail = await leagueRepository.getLeagueDetail(
        leagueId: pouleId, type: pouleType);
    poule = pouleDetail;
    _participants = pouleDetail.userRankings;
    if (isExpanded) {
      expandPlayerList();
    } else {
      collapsePlayerList();
    }
    notifyListeners();
  }

  Future<void> removePoule() async {
    final poule = this.poule;
    if (poule == null) return;
    beginLoading();
    try {
      if (poule.isPublicLeague) {
        await leagueRepository.removePublicPoule(pouleId);
      } else {
        await leagueRepository.removeFriendPoule(pouleId);
      }
    } catch (exception) {
      showGenericError(exception);
    } finally {
      endLoading();
    }
  }

  Participant? getParticipantById(int id) {
    return _participants.firstWhereOrNull((element) => element.userId == id);
  }
}
