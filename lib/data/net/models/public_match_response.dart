import 'package:flutter_better_united/data/net/converters/date_converter.dart';
import 'package:json_annotation/json_annotation.dart';

import 'match_response.dart';

part 'public_match_response.g.dart';

@JsonSerializable()
@DateTimeConverter()
class PublicMatchResponse {
  final int id;
  final DateTime startsAt;
  final TeamResponse homeTeam;
  final TeamResponse awayTeam;

  factory PublicMatchResponse.fromJson(Map<String, dynamic> json) =>
      _$PublicMatchResponseFromJson(json);

  PublicMatchResponse(
    this.id,
    this.startsAt,
    this.homeTeam,
    this.awayTeam,
  );

  Map<String, dynamic> toJson() => _$PublicMatchResponseToJson(this);
}
