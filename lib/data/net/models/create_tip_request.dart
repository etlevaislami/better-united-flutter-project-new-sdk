import 'package:json_annotation/json_annotation.dart';

part 'create_tip_request.g.dart';

@JsonSerializable()
class CreateTipRequest {
  final int matchId;
  final int matchBetId;
  final int? friendLeagueId;
  final int? publicLeagueId;

  factory CreateTipRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateTipRequestFromJson(json);

  CreateTipRequest(
      this.matchId, this.matchBetId, this.friendLeagueId, this.publicLeagueId);

  Map<String, dynamic> toJson() => _$CreateTipRequestToJson(this);
}
