import 'package:flutter_better_united/data/net/models/match_response.dart';
import 'package:json_annotation/json_annotation.dart';

import '../converters/date_converter.dart';
import '../converters/poule_status_type_converter.dart';

part 'friend_league_active_list_item.g.dart';

@JsonSerializable()
@DateTimeConverter()
class FriendLeagueActivePouleItem {
  final int id;
  final String name;
  final DateTime startsAt;
  final DateTime endsAt;
  final DateTime matchStartsAt;
  final TeamResponse homeTeam;
  final TeamResponse awayTeam;
  final int userCount;
  final int? userRank;
  final int predictionsRemaining;
  final int poolPrize;
  final String? iconUrl;
  final int entryFee;
  final int matchId;
  @PouleStatusTypeConverter()
  final bool status;

  FriendLeagueActivePouleItem(
      this.id,
      this.name,
      this.startsAt,
      this.endsAt,
      this.matchStartsAt,
      this.homeTeam,
      this.awayTeam,
      this.userCount,
      this.userRank,
      this.predictionsRemaining,
      this.poolPrize,
      this.iconUrl,
      this.entryFee,
      this.matchId,
      this.status);

  factory FriendLeagueActivePouleItem.fromJson(Map<String, dynamic> json) =>
      _$FriendLeagueActivePouleItemFromJson(json);

  Map<String, dynamic> toJson() => _$FriendLeagueActivePouleItemToJson(this);
}
