// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_of_season_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamOfSeasonResponse _$TeamOfSeasonResponseFromJson(
        Map<String, dynamic> json) =>
    TeamOfSeasonResponse(
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

Map<String, dynamic> _$TeamOfSeasonResponseToJson(
        TeamOfSeasonResponse instance) =>
    <String, dynamic>{
      'userHasWon': instance.userHasWon,
      'isClaimed': instance.isClaimed,
      'amountToClaim': instance.amountToClaim,
      'team': instance.team,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
    };
