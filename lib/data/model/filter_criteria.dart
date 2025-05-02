import 'package:flutter_better_united/data/model/team.dart';

import '../enum/sort_type.dart';

class FilterCriteria {
  int? leagueId;
  Team? team;
  SortType sortType;
  DateTime? matchDay;
  String? searchQuery;
  bool onlyFollowing;
  int? friendLeagueId;
  bool onlyFriendLeagues;
  bool onlyActive;
  int? userId;
  bool onlyHistory;
  bool? onlyMine;
  bool? onlyOthers;
  int? publicLeagueId;
  int _refreshCounter = 0;

  FilterCriteria(
      {this.leagueId,
      this.team,
      this.searchQuery,
      this.sortType = SortType.mostRecent,
      this.onlyFollowing = false,
      this.matchDay,
      this.friendLeagueId,
      this.onlyFriendLeagues = false,
      this.onlyActive = false,
      this.userId,
      this.onlyHistory = false,
      this.onlyMine,
      this.onlyOthers,
      this.publicLeagueId});

  FilterCriteria.copy(FilterCriteria filterCriteria)
      : this(
            leagueId: filterCriteria.leagueId,
            team: filterCriteria.team,
            searchQuery: filterCriteria.searchQuery,
            sortType: filterCriteria.sortType,
            onlyFollowing: filterCriteria.onlyFollowing,
            matchDay: filterCriteria.matchDay,
            friendLeagueId: filterCriteria.friendLeagueId,
            onlyFriendLeagues: filterCriteria.onlyFriendLeagues,
            onlyActive: filterCriteria.onlyActive,
            userId: filterCriteria.userId,
            onlyHistory: filterCriteria.onlyHistory,
            onlyMine: filterCriteria.onlyMine,
            onlyOthers: filterCriteria.onlyOthers,
            publicLeagueId: filterCriteria.publicLeagueId);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FilterCriteria &&
          runtimeType == other.runtimeType &&
          leagueId == other.leagueId &&
          team == other.team &&
          sortType == other.sortType &&
          matchDay == other.matchDay &&
          searchQuery == other.searchQuery &&
          onlyFollowing == other.onlyFollowing &&
          friendLeagueId == other.friendLeagueId &&
          onlyFriendLeagues == other.onlyFriendLeagues &&
          onlyActive == other.onlyActive &&
          userId == other.userId &&
          onlyHistory == other.onlyHistory &&
          onlyMine == other.onlyMine &&
          onlyOthers == other.onlyOthers &&
          publicLeagueId == other.publicLeagueId &&
          _refreshCounter == other._refreshCounter;

  @override
  int get hashCode =>
      leagueId.hashCode ^
      team.hashCode ^
      sortType.hashCode ^
      matchDay.hashCode ^
      searchQuery.hashCode ^
      onlyFollowing.hashCode ^
      friendLeagueId.hashCode ^
      onlyFriendLeagues.hashCode ^
      onlyActive.hashCode ^
      userId.hashCode ^
      onlyHistory.hashCode ^
      onlyMine.hashCode ^
      onlyOthers.hashCode ^
      publicLeagueId.hashCode ^
      _refreshCounter.hashCode;

  // Used to force refreshing the tips since the hashcode of the object will change
  incrementRefreshCounter() {
    _refreshCounter++;
  }
}
