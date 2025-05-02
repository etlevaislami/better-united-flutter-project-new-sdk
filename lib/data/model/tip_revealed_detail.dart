import 'package:flutter_better_united/data/model/team.dart';
import 'package:flutter_better_united/data/net/models/tip_revealed_detail_response.dart';

class TipRevealedDetail {
  final int id;
  final String? description;
  final String finalScore;
  final int points;
  final Team homeTeam;
  final Team awayTeam;
  final String hint;
  final String? pouleIconUrl;
  final int? publicLeagueId;
  final int? friendLeagueId;
  final String pouleName;

  TipRevealedDetail(
      this.id,
      this.description,
      this.finalScore,
      this.points,
      this.homeTeam,
      this.awayTeam,
      this.hint,
      this.pouleIconUrl,
      this.publicLeagueId,
      this.friendLeagueId,
      this.pouleName);

  TipRevealedDetail.fromTipDetailResponse(
      TipRevealedDetailResponse tipDetailResponse)
      : this(
            tipDetailResponse.id,
            tipDetailResponse.description,
            tipDetailResponse.finalScore,
            tipDetailResponse.points,
            Team.fromTeamResponse(tipDetailResponse.homeTeam),
            Team.fromTeamResponse(tipDetailResponse.awayTeam),
            tipDetailResponse.hints?.join("\n") ?? "",
            tipDetailResponse.pouleIconUrl,
            tipDetailResponse.publicLeagueId,
            tipDetailResponse.friendLeagueId,
            tipDetailResponse.pouleName);

  bool get isPublicPoule => publicLeagueId != null;

  bool get isFriendPoule => friendLeagueId != null;

  int get homeTeamScore => int.parse(finalScore.split("-")[0]);

  int get awayTeamScore => int.parse(finalScore.split("-")[1]);
}
