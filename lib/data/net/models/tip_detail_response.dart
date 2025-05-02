import 'package:flutter_better_united/data/enum/tip_settlement.dart';
import 'package:flutter_better_united/data/net/converters/date_converter.dart';
import 'package:flutter_better_united/data/net/models/match_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tip_detail_response.g.dart';

@JsonSerializable()
@DateTimeConverter()
class TipDetailResponse {
  final int id;
  final DateTime tipCreatedAt;
  final double odds;
  final int matchId;
  final DateTime matchStartsAt;
  final int userId;
  final String? userNickname;
  final String? userProfilePictureUrl;
  final TeamResponse homeTeam;
  final TeamResponse awayTeam;
  final int isOwn;
  final int isFollowingAuthor;
  final String leagueName;
  final int expEarned;
  final int userLevel;
  final String userRewardTitle;
  final List<String>? hints;
  @JsonKey(fromJson: intToTipSettlement, toJson: tipSettlementFromInt)
  final TipSettlement tipSettlement;

  final int expEarnedFriendLeague;
  final int? friendLeagueId;
  final int? publicLeagueId;
  final int points;
  final int isTipVoided;

  factory TipDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$TipDetailResponseFromJson(json);

  TipDetailResponse(
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
      this.leagueName,
      this.tipSettlement,
      this.expEarned,
      this.userLevel,
      this.userRewardTitle,
      this.hints,
      this.expEarnedFriendLeague,
      this.friendLeagueId,
      this.publicLeagueId,
      this.points,
      this.isTipVoided);

  Map<String, dynamic> toJson() => _$TipDetailResponseToJson(this);
}
