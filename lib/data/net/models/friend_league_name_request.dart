import 'package:json_annotation/json_annotation.dart';

part 'friend_league_name_request.g.dart';

@JsonSerializable()
class FriendLeagueNameRequest {
  final String name;

  factory FriendLeagueNameRequest.fromJson(Map<String, dynamic> json) =>
      _$FriendLeagueNameRequestFromJson(json);

  FriendLeagueNameRequest(this.name);

  Map<String, dynamic> toJson() => _$FriendLeagueNameRequestToJson(this);
}
