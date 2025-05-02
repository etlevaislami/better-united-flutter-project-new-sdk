import 'package:json_annotation/json_annotation.dart';

part 'add_favorite_teams_request.g.dart';

@JsonSerializable()
class AddFavoriteTeamsRequest {
  final List<int> teams;

  AddFavoriteTeamsRequest(this.teams);

  factory AddFavoriteTeamsRequest.fromJson(Map<String, dynamic> json) =>
      _$AddFavoriteTeamsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddFavoriteTeamsRequestToJson(this);
}
