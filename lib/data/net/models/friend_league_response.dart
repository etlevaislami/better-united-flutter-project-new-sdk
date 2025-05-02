import 'package:flutter_better_united/data/net/converters/date_converter.dart';
import 'package:json_annotation/json_annotation.dart';

import '../converters/poule_status_type_converter.dart';

part 'friend_league_response.g.dart';

@JsonSerializable()
@DateTimeConverter()
class FriendLeagueResponse {
  final int id;
  final String name;
  final int? tipCountTotal;
  final int? tipCountLost;
  final int? tipCountWon;
  final int maximumTipCount;
  final int userTipCountTotal;
  final DateTime startsAt;
  final DateTime endsAt;
  @PouleStatusTypeConverter()
  final bool status;

  factory FriendLeagueResponse.fromJson(Map<String, dynamic> json) =>
      _$FriendLeagueResponseFromJson(json);

  FriendLeagueResponse(
      this.id,
      this.name,
      this.tipCountTotal,
      this.tipCountLost,
      this.tipCountWon,
      this.maximumTipCount,
      this.userTipCountTotal,
      this.startsAt,
      this.endsAt,
      this.status);

  Map<String, dynamic> toJson() => _$FriendLeagueResponseToJson(this);
}
