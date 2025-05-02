import 'package:flutter_better_united/data/net/models/football_league_response.dart';
import 'package:flutter_better_united/data/net/models/public_match_response.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../enum/public_poule_type.dart';
import '../converters/date_converter.dart';
import '../converters/poule_status_type_converter.dart';
import '../converters/public_poule_type_converter.dart';

part 'public_league_join_info_response.g.dart';

@JsonSerializable()
@DateTimeConverter()
class PublicLeagueJoinInfoResponse {
  final int id;
  final String name;
  final DateTime startsAt;
  final DateTime endsAt;
  final int poolPrizeTotal;
  final int poolPrizeAmountFirst;
  final int poolPrizeAmountSecond;
  final int poolPrizeAmountThird;
  final int poolPrizeAmountOthers;
  final int? predictionsRemaining;
  final String? iconUrl;
  final int? entryFee;
  final int maximumTipCountPerMatch;
  @PouleStatusTypeConverter()
  final bool status;

  final List<FootballLeagueResponse> leagues;
  final List<PublicMatchResponse> matches;
  @JsonKey(
      fromJson: PublicPouleTypeConverter.fromJson,
      toJson: PublicPouleTypeConverter.toJson)
  final PublicPouleType formatType;

  PublicLeagueJoinInfoResponse(
    this.id,
    this.name,
    this.startsAt,
    this.endsAt,
    this.iconUrl,
    this.poolPrizeTotal,
    this.poolPrizeAmountFirst,
    this.poolPrizeAmountSecond,
    this.poolPrizeAmountThird,
    this.poolPrizeAmountOthers,
    this.entryFee,
    this.leagues,
    this.predictionsRemaining,
    this.maximumTipCountPerMatch,
    this.status,
    this.matches,
    this.formatType
  );

  factory PublicLeagueJoinInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$PublicLeagueJoinInfoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PublicLeagueJoinInfoResponseToJson(this);
}
