// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'site_settings_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SiteSettingsResponse _$SiteSettingsResponseFromJson(
        Map<String, dynamic> json) =>
    SiteSettingsResponse(
      (json['friendLeagueCreationPrice'] as num).toInt(),
      (json['tipRevealPrice'] as num).toInt(),
    );

Map<String, dynamic> _$SiteSettingsResponseToJson(
        SiteSettingsResponse instance) =>
    <String, dynamic>{
      'friendLeagueCreationPrice': instance.friendLeagueCreationPrice,
      'tipRevealPrice': instance.tipRevealPrice,
    };
