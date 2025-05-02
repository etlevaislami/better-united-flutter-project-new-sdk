import 'package:flutter_better_united/data/net/converters/date_converter.dart';
import 'package:flutter_better_united/data/net/models/participant_response.dart';
import 'package:json_annotation/json_annotation.dart';

import '../converters/poule_status_type_converter.dart';

part 'friend_league_detail_response.g.dart';

@JsonSerializable()
@DateTimeConverter()
class FriendLeagueDetailResponse {
  final int id;
  final String name;
  final DateTime startsAt;
  final DateTime endsAt;
  final int tipCountTotal;
  final int? tipCountLost;
  final int? tipCountWon;
  final List<ParticipantResponse> userRankings;
  final int maximumTipCount;
  final int userTipCountTotal;
  final int matchId;
  final DateTime matchStartsAt;
  final String homeTeamName;
  final String awayTeamName;
  final String? homeTeamLogoUrl;
  final String? awayTeamLogoUrl;
  final int? prizePool;
  final String? leagueName;
  final int predictionsRemaining;
  final int entryFee;
  @PouleStatusTypeConverter()
  final bool status;

  FriendLeagueDetailResponse(
      this.id,
      this.name,
      this.startsAt,
      this.endsAt,
      this.tipCountTotal,
      this.tipCountLost,
      this.tipCountWon,
      this.userRankings,
      this.maximumTipCount,
      this.userTipCountTotal,
      this.matchId,
      this.matchStartsAt,
      this.homeTeamName,
      this.awayTeamName,
      this.homeTeamLogoUrl,
      this.awayTeamLogoUrl,
      this.prizePool,
      this.leagueName,
      this.predictionsRemaining,
      this.entryFee,
      this.status);

  factory FriendLeagueDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$FriendLeagueDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FriendLeagueDetailResponseToJson(this);
}
