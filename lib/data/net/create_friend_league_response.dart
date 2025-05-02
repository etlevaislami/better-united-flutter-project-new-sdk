import 'package:json_annotation/json_annotation.dart';

part 'create_friend_league_response.g.dart';

@JsonSerializable()
class CreateFriendLeagueResponse {
  final String id;

  CreateFriendLeagueResponse(this.id);

  factory CreateFriendLeagueResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateFriendLeagueResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreateFriendLeagueResponseToJson(this);
}
