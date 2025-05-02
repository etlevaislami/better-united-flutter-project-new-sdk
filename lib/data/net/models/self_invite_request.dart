import 'package:json_annotation/json_annotation.dart';

part 'self_invite_request.g.dart';

@JsonSerializable()
class SelfInviteRequest {
  final int friendLeagueId;

  SelfInviteRequest(this.friendLeagueId);

  factory SelfInviteRequest.fromJson(Map<String, dynamic> json) =>
      _$SelfInviteRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SelfInviteRequestToJson(this);
}
