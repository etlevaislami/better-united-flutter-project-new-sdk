import 'dart:math';
import 'dart:ui';

import 'package:flutter_better_united/constants/app_colors.dart';
import 'package:flutter_better_united/data/model/friend_league_detail.dart';
import 'package:flutter_better_united/data/net/models/friend_league_response.dart';

import 'league.dart';

class FriendLeague {
  final int id;
  final String name;
  final int tipCountTotal;
  final int tipCountLost;
  final int tipCountWon;
  final int maximumTipCount;
  final int userTipCountTotal;
  final DateTime startsAt;
  final DateTime endsAt;
  List<League>? leagues;
  bool isSelected = false;
  final bool isFinished;

  FriendLeague(
    this.id,
    this.name,
    this.tipCountTotal,
    this.tipCountLost,
    this.tipCountWon,
    this.maximumTipCount,
    this.userTipCountTotal,
    this.startsAt,
    this.endsAt,
    this.isFinished,
  );

  FriendLeague.fromFriendLeagueResponse(
      FriendLeagueResponse friendLeagueResponse)
      : this(
            friendLeagueResponse.id,
            friendLeagueResponse.name,
            friendLeagueResponse.tipCountTotal ?? 0,
            friendLeagueResponse.tipCountLost ?? 0,
            friendLeagueResponse.tipCountWon ?? 0,
            friendLeagueResponse.maximumTipCount,
            friendLeagueResponse.userTipCountTotal,
            friendLeagueResponse.startsAt,
            friendLeagueResponse.endsAt,
            friendLeagueResponse.status);

  FriendLeague.fromFriendLeagueDetail(FriendLeagueDetail friendLeagueDetail)
      : this(
            friendLeagueDetail.id,
            friendLeagueDetail.name,
            friendLeagueDetail.tipCountTotal,
            friendLeagueDetail.tipCountLost ?? 0,
            friendLeagueDetail.tipCountWon ?? 0,
            friendLeagueDetail.maximumTipCount,
            friendLeagueDetail.tipCountTotal,
            friendLeagueDetail.startsAt,
            friendLeagueDetail.endsAt,
            friendLeagueDetail.isFinished);

  Color getColor(int index) {
    final remaining = (index + 1) % 3;
    if (remaining == 0) {
      return AppColors.shimmer;
    }

    if (remaining == 1) {
      return AppColors.goldenHandshake;
    }

    return AppColors.salamiSlice;
  }

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! FriendLeague) return false;
    return other.id == id;
  }

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  int get hashCode => id.hashCode;

  int get tipAmountLeft => max(maximumTipCount - userTipCountTotal, 0);
}
