import 'package:json_annotation/json_annotation.dart';

part 'site_settings_response.g.dart';

@JsonSerializable()
class SiteSettingsResponse {
  final int friendLeagueCreationPrice;
  final int tipRevealPrice;

  SiteSettingsResponse(this.friendLeagueCreationPrice, this.tipRevealPrice);

  factory SiteSettingsResponse.fromJson(Map<String, dynamic> json) =>
      _$SiteSettingsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SiteSettingsResponseToJson(this);
}
