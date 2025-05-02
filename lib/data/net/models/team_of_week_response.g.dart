// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_of_week_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamOfWeekResponse _$TeamOfWeekResponseFromJson(Map<String, dynamic> json) =>
    TeamOfWeekResponse(
      json['userHasWon'] as bool?,
      json['isClaimed'] as bool?,
      (json['amountToClaim'] as num?)?.toDouble(),
      (json['team'] as List<dynamic>)
          .map((e) =>
              RankedParticipantResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      DateTime.parse(json['startDate'] as String),
      DateTime.parse(json['endDate'] as String),
    );

Map<String, dynamic> _$TeamOfWeekResponseToJson(TeamOfWeekResponse instance) =>
    <String, dynamic>{
      'userHasWon': instance.userHasWon,
      'isClaimed': instance.isClaimed,
      'amountToClaim': instance.amountToClaim,
      'team': instance.team,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
    };
