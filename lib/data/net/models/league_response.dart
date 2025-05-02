import 'package:json_annotation/json_annotation.dart';

part 'league_response.g.dart';

@JsonSerializable()
class LeagueResponse {
  final int id;
  final String? name;
  final String? logoUrl;
  final int matchCount;
  final int tipCount;
  final String countryName;

  LeagueResponse(this.id, this.name, this.logoUrl, this.matchCount,
      this.tipCount, this.countryName);

  factory LeagueResponse.fromJson(Map<String, dynamic> json) =>
      _$LeagueResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LeagueResponseToJson(this);
}
