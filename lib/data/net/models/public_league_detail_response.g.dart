// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'public_league_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PublicLeagueDetailResponse _$PublicLeagueDetailResponseFromJson(
        Map<String, dynamic> json) =>
    PublicLeagueDetailResponse(
      (json['id'] as num).toInt(),
      json['name'] as String,
      const DateTimeConverter().fromJson(json['startsAt'] as String),
      const DateTimeConverter().fromJson(json['endsAt'] as String),
      (json['tipCountTotal'] as num).toInt(),
      (json['tipCountLost'] as num?)?.toInt(),
      (json['tipCountWon'] as num?)?.toInt(),
      (json['entryFee'] as num).toInt(),
      (json['userRankings'] as List<dynamic>)
          .map((e) => ParticipantResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['maximumTipCount'] as num?)?.toInt(),
      (json['userTipCountTotal'] as num).toInt(),
      (json['poolPrizeTotal'] as num).toInt(),
      (json['predictionsRemaining'] as num).toInt(),
      (json['poolPrizeAmountFirst'] as num?)?.toInt(),
      (json['poolPrizeAmountSecond'] as num?)?.toInt(),
      (json['poolPrizeAmountThird'] as num?)?.toInt(),
      (json['poolPrizeAmountOthers'] as num?)?.toInt(),
      (json['leagues'] as List<dynamic>)
          .map((e) => LeagueDetailFootballLeagueResponse.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      json['iconUrl'] as String?,
      (json['maximumTipCountPerMatch'] as num).toInt(),
      const PouleStatusTypeConverter().fromJson(json['status'] as String),
      (json['matches'] as List<dynamic>)
          .map((e) => PublicMatchResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      PublicPouleTypeConverter.fromJson(json['formatType'] as String),
    );

Map<String, dynamic> _$PublicLeagueDetailResponseToJson(
        PublicLeagueDetailResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'startsAt': const DateTimeConverter().toJson(instance.startsAt),
      'endsAt': const DateTimeConverter().toJson(instance.endsAt),
      'tipCountTotal': instance.tipCountTotal,
      'tipCountLost': instance.tipCountLost,
      'tipCountWon': instance.tipCountWon,
      'entryFee': instance.entryFee,
      'userRankings': instance.userRankings,
      'maximumTipCount': instance.maximumTipCount,
      'userTipCountTotal': instance.userTipCountTotal,
      'poolPrizeTotal': instance.poolPrizeTotal,
      'predictionsRemaining': instance.predictionsRemaining,
      'poolPrizeAmountFirst': instance.poolPrizeAmountFirst,
      'poolPrizeAmountSecond': instance.poolPrizeAmountSecond,
      'poolPrizeAmountThird': instance.poolPrizeAmountThird,
      'poolPrizeAmountOthers': instance.poolPrizeAmountOthers,
      'leagues': instance.leagues,
      'iconUrl': instance.iconUrl,
      'maximumTipCountPerMatch': instance.maximumTipCountPerMatch,
      'status': const PouleStatusTypeConverter().toJson(instance.status),
      'matches': instance.matches,
      'formatType': PublicPouleTypeConverter.toJson(instance.formatType),
    };
