import 'package:json_annotation/json_annotation.dart';

import '../converters/date_converter.dart';

part 'tip_response.g.dart';

@JsonSerializable()
@DateTimeConverter()
class TipResponse {
  final int id;
  final int appUserId;
  final int matchId;
  final DateTime createdAt;
  final int status;
  final int matchBetId;
  final int points;
  final int? friendLeagueId;
  final int? publicLeagueId;

  factory TipResponse.fromJson(Map<String, dynamic> json) =>
      _$TipResponseFromJson(json);

  TipResponse(
      this.id,
      this.appUserId,
      this.matchId,
      this.createdAt,
      this.status,
      this.matchBetId,
      this.points,
      this.friendLeagueId,
      this.publicLeagueId);

  Map<String, dynamic> toJson() => _$TipResponseToJson(this);
}
