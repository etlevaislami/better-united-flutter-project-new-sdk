import 'package:json_annotation/json_annotation.dart';

part 'friend_league_info_response.g.dart';

@JsonSerializable()
class FriendLeagueInfoResponse {
  final int id;
  final String name;

  factory FriendLeagueInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$FriendLeagueInfoResponseFromJson(json);

  FriendLeagueInfoResponse(this.id, this.name);

  Map<String, dynamic> toJson() => _$FriendLeagueInfoResponseToJson(this);
}
