// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'public_match_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PublicMatchResponse _$PublicMatchResponseFromJson(Map<String, dynamic> json) =>
    PublicMatchResponse(
      (json['id'] as num).toInt(),
      const DateTimeConverter().fromJson(json['startsAt'] as String),
      TeamResponse.fromJson(json['homeTeam'] as Map<String, dynamic>),
      TeamResponse.fromJson(json['awayTeam'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PublicMatchResponseToJson(
        PublicMatchResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'startsAt': const DateTimeConverter().toJson(instance.startsAt),
      'homeTeam': instance.homeTeam,
      'awayTeam': instance.awayTeam,
    };
