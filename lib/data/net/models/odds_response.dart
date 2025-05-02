import 'package:json_annotation/json_annotation.dart';

part 'odds_response.g.dart';

@JsonSerializable()
class OddsResponse {
  final int id;
  final String name;
  final String? line;
  final String? baseLine;
  final int points;
  final List<String>? hints;

  OddsResponse(
      this.id, this.name, this.points, this.line, this.baseLine, this.hints);

  factory OddsResponse.fromJson(Map<String, dynamic> json) =>
      _$OddsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OddsResponseToJson(this);
}
