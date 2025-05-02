import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_better_united/data/enum/tip_settlement.dart';
import 'package:flutter_better_united/data/model/power_up.dart';
import 'package:flutter_better_united/data/model/team.dart';
import 'package:flutter_better_united/data/net/models/tip_detail_response.dart';
import 'package:flutter_better_united/data/net/models/tip_response.dart';

class Tip {
  int? tipId;
  final int matchId;
  final int matchBetId;
  final int points;

  Tip(this.matchId, this.matchBetId, this.points);

  Tip.fromTipResponse(TipResponse tipResponse)
      : tipId = tipResponse.id,
        matchId = tipResponse.matchId,
        matchBetId = tipResponse.matchBetId,
        points = tipResponse.points;
}

class TipDetail {
  final int id;
  final DateTime tipCreatedAt;
  final double odds;
  final int matchId;
  final DateTime matchStartsAt;
  final int userId;
  final String userNickname;
  final String? userProfilePictureUrl;
  final Team homeTeam;
  final Team awayTeam;
  final bool isOwn;
  final List<PowerUp> powerUps;
  final String leagueName;
  final TipSettlement tipSettlement;
  final int points;
  bool isFollowingAuthor;
  String? finalScore;
  final int userLevel;
  final String userLevelName;
  final String hints;
  final List<String> friendLeagueNames;
  final int leagueId;
  final bool isTipVoided;

  TipDetail(
      this.id,
      this.tipCreatedAt,
      this.odds,
      this.matchId,
      this.matchStartsAt,
      this.userId,
      this.userNickname,
      this.userProfilePictureUrl,
      this.homeTeam,
      this.awayTeam,
      this.isOwn,
      this.isFollowingAuthor,
      this.powerUps,
      this.leagueName,
      this.tipSettlement,
      this.points,
      this.userLevel,
      this.userLevelName,
      this.hints,
      this.friendLeagueNames,
      this.leagueId,
      this.isTipVoided);

  TipDetail.fromTipDetailResponse(TipDetailResponse tipDetailResponse)
      : this(
      tipDetailResponse.id,
            tipDetailResponse.tipCreatedAt,
            tipDetailResponse.odds,
            tipDetailResponse.matchId,
            tipDetailResponse.matchStartsAt,
            tipDetailResponse.userId,
            tipDetailResponse.userNickname ?? "undefined".tr(),
            tipDetailResponse.userProfilePictureUrl,
            Team.fromTeamResponse(tipDetailResponse.homeTeam),
            Team.fromTeamResponse(tipDetailResponse.awayTeam),
            tipDetailResponse.isOwn == 1 ? true : false,
            tipDetailResponse.isFollowingAuthor == 1 ? true : false,
            [],
            tipDetailResponse.leagueName,
            tipDetailResponse.tipSettlement,
            tipDetailResponse.points,
            tipDetailResponse.userLevel,
            tipDetailResponse.userRewardTitle,
            tipDetailResponse.hints?.join("\n") ?? "",
            [],
            tipDetailResponse.publicLeagueId ??
                tipDetailResponse.friendLeagueId ??
                -1,
            tipDetailResponse.isTipVoided == 1 ? true : false);

  bool get isTipWon => tipSettlement == TipSettlement.won;
}
