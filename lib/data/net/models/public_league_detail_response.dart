import 'package:flutter_better_united/data/net/converters/date_converter.dart';
import 'package:flutter_better_united/data/net/models/league_detail_football_league_response.dart';
import 'package:flutter_better_united/data/net/models/participant_response.dart';
import 'package:flutter_better_united/data/net/models/public_match_response.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../enum/public_poule_type.dart';
import '../converters/public_poule_type_converter.dart';

import '../converters/poule_status_type_converter.dart';

part 'public_league_detail_response.g.dart';

@JsonSerializable()
@DateTimeConverter()
class PublicLeagueDetailResponse {
  final int id;
  final String name;
  final DateTime startsAt;
  final DateTime endsAt;
  final int tipCountTotal;
  final int? tipCountLost;
  final int? tipCountWon;
  final int entryFee;
  final List<ParticipantResponse> userRankings;
  final int? maximumTipCount;
  final int userTipCountTotal;
  final int poolPrizeTotal;
  final int predictionsRemaining;
  final int? poolPrizeAmountFirst;
  final int? poolPrizeAmountSecond;
  final int? poolPrizeAmountThird;
  final int? poolPrizeAmountOthers;
  final List<LeagueDetailFootballLeagueResponse> leagues;
  final String? iconUrl;
  final int maximumTipCountPerMatch;
  @PouleStatusTypeConverter()
  final bool status;
  final List<PublicMatchResponse> matches;
  @JsonKey(
      fromJson: PublicPouleTypeConverter.fromJson,
      toJson: PublicPouleTypeConverter.toJson)
  final PublicPouleType formatType;

  PublicLeagueDetailResponse(
      this.id,
      this.name,
      this.startsAt,
      this.endsAt,
      this.tipCountTotal,
      this.tipCountLost,
      this.tipCountWon,
      this.entryFee,
      this.userRankings,
      this.maximumTipCount,
      this.userTipCountTotal,
      this.poolPrizeTotal,
      this.predictionsRemaining,
      this.poolPrizeAmountFirst,
      this.poolPrizeAmountSecond,
      this.poolPrizeAmountThird,
      this.poolPrizeAmountOthers,
      this.leagues,
      this.iconUrl,
      this.maximumTipCountPerMatch,
      this.status,
      this.matches,
      this.formatType);

  factory PublicLeagueDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$PublicLeagueDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PublicLeagueDetailResponseToJson(this);
}
