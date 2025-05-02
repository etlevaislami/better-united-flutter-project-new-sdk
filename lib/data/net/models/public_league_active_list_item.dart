import 'package:flutter_better_united/data/net/models/public_match_response.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../enum/public_poule_type.dart';
import '../converters/date_converter.dart';
import '../converters/poule_status_type_converter.dart';
import '../converters/public_poule_type_converter.dart';
import 'football_league_response.dart';

part 'public_league_active_list_item.g.dart';

@JsonSerializable()
@DateTimeConverter()
class PublicLeagueActivePouleItem {
  final int id;
  final String name;
  final DateTime startsAt;
  final DateTime endsAt;
  final int userCount;
  final int? userRank;
  final int predictionsRemaining;
  final int poolPrizeTotal;
  final int poolPrizeAmountFirst;
  final int poolPrizeAmountSecond;
  final int poolPrizeAmountThird;
  final int poolPrizeAmountOthers;
  final String? iconUrl;
  final List<FootballLeagueResponse> leagues;
  @PouleStatusTypeConverter()
  final bool status;
  final List<PublicMatchResponse> matches;
  @JsonKey(
      fromJson: PublicPouleTypeConverter.fromJson,
      toJson: PublicPouleTypeConverter.toJson)
  final PublicPouleType formatType;

  PublicLeagueActivePouleItem(
      this.id,
      this.name,
      this.startsAt,
      this.endsAt,
      this.userCount,
      this.userRank,
      this.predictionsRemaining,
      this.iconUrl,
      this.poolPrizeTotal,
      this.poolPrizeAmountFirst,
      this.poolPrizeAmountSecond,
      this.poolPrizeAmountThird,
      this.poolPrizeAmountOthers,
      this.leagues,
      this.status,
      this.matches,
      this.formatType);

  factory PublicLeagueActivePouleItem.fromJson(Map<String, dynamic> json) =>
      _$PublicLeagueActivePouleItemFromJson(json);

  Map<String, dynamic> toJson() => _$PublicLeagueActivePouleItemToJson(this);
}
