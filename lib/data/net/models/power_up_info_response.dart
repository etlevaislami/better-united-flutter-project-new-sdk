import 'package:json_annotation/json_annotation.dart';

part 'power_up_info_response.g.dart';

@JsonSerializable()
class PowerUpInfoResponse {
  final int powerupTypeId;
  final String powerupName;
  final String powerupIconUrl;
  final double powerupMultiplier;

  factory PowerUpInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$PowerUpInfoResponseFromJson(json);

  PowerUpInfoResponse(this.powerupTypeId, this.powerupName, this.powerupIconUrl,
      this.powerupMultiplier);

  Map<String, dynamic> toJson() => _$PowerUpInfoResponseToJson(this);
}
