import 'package:flutter_better_united/data/net/converters/date_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'power_up_response.g.dart';

@JsonSerializable()
@DateTimeConverter()
class PowerUpResponse {
  final int id;
  final int powerupTypeId;
  final String name;
  final int price;
  final String iconUrl;
  final double multiplier;
  final String description;
  final int powerupCount;

  factory PowerUpResponse.fromJson(Map<String, dynamic> json) =>
      _$PowerUpResponseFromJson(json);

  PowerUpResponse(this.id, this.powerupTypeId, this.name, this.price,
      this.iconUrl, this.multiplier, this.description, this.powerupCount);

  Map<String, dynamic> toJson() => _$PowerUpResponseToJson(this);
}
