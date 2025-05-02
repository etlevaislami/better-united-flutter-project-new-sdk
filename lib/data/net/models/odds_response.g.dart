// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'odds_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OddsResponse _$OddsResponseFromJson(Map<String, dynamic> json) => OddsResponse(
      (json['id'] as num).toInt(),
      json['name'] as String,
      (json['points'] as num).toInt(),
      json['line'] as String?,
      json['baseLine'] as String?,
      (json['hints'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$OddsResponseToJson(OddsResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'line': instance.line,
      'baseLine': instance.baseLine,
      'points': instance.points,
      'hints': instance.hints,
    };
