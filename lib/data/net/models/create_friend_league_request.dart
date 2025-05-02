import 'package:flutter_better_united/data/net/converters/date_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_friend_league_request.g.dart';

@JsonSerializable()
@DateTimeConverter()
class CreateFriendLeagueRequest {
  final String name;
  final int entryFee;
  final int matchId;

  factory CreateFriendLeagueRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateFriendLeagueRequestFromJson(json);

  CreateFriendLeagueRequest(this.name, this.entryFee, this.matchId);

  Map<String, dynamic> toJson() => _$CreateFriendLeagueRequestToJson(this);
}
