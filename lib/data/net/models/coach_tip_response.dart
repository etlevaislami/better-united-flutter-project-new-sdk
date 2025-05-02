import 'package:json_annotation/json_annotation.dart';

import '../converters/date_converter.dart';

part 'coach_tip_response.g.dart';

@JsonSerializable()
@DateTimeConverter()
class CoachTipResponse {
  final int id;
  final String text;
  final int announceAfterMinutes;
  final DateTime expiresAt;
  final String imageUrl;

  factory CoachTipResponse.fromJson(Map<String, dynamic> json) =>
      _$CoachTipResponseFromJson(json);

  CoachTipResponse(this.id, this.text, this.announceAfterMinutes,
      this.expiresAt, this.imageUrl);

  Map<String, dynamic> toJson() => _$CoachTipResponseToJson(this);
}
