// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'public_league_join_info_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PublicLeagueJoinInfoResponse _$PublicLeagueJoinInfoResponseFromJson(
        Map<String, dynamic> json) =>
    PublicLeagueJoinInfoResponse(
      (json['id'] as num).toInt(),
      json['name'] as String,
      const DateTimeConverter().fromJson(json['startsAt'] as String),
      const DateTimeConverter().fromJson(json['endsAt'] as String),
      json['iconUrl'] as String?,
      (json['poolPrizeTotal'] as num).toInt(),
      (json['poolPrizeAmountFirst'] as num).toInt(),
      (json['poolPrizeAmountSecond'] as num).toInt(),
      (json['poolPrizeAmountThird'] as num).toInt(),
      (json['poolPrizeAmountOthers'] as num).toInt(),
      (json['entryFee'] as num?)?.toInt(),
      (json['leagues'] as List<dynamic>)
          .map(
              (e) => FootballLeagueResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['predictionsRemaining'] as num?)?.toInt(),
      (json['maximumTipCountPerMatch'] as num).toInt(),
      const PouleStatusTypeConverter().fromJson(json['status'] as String),
      (json['matches'] as List<dynamic>)
          .map((e) => PublicMatchResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      PublicPouleTypeConverter.fromJson(json['formatType'] as String),
    );

Map<String, dynamic> _$PublicLeagueJoinInfoResponseToJson(
        PublicLeagueJoinInfoResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'startsAt': const DateTimeConverter().toJson(instance.startsAt),
      'endsAt': const DateTimeConverter().toJson(instance.endsAt),
      'poolPrizeTotal': instance.poolPrizeTotal,
      'poolPrizeAmountFirst': instance.poolPrizeAmountFirst,
      'poolPrizeAmountSecond': instance.poolPrizeAmountSecond,
      'poolPrizeAmountThird': instance.poolPrizeAmountThird,
      'poolPrizeAmountOthers': instance.poolPrizeAmountOthers,
      'predictionsRemaining': instance.predictionsRemaining,
      'iconUrl': instance.iconUrl,
      'entryFee': instance.entryFee,
      'maximumTipCountPerMatch': instance.maximumTipCountPerMatch,
      'status': const PouleStatusTypeConverter().toJson(instance.status),
      'leagues': instance.leagues,
      'matches': instance.matches,
      'formatType': PublicPouleTypeConverter.toJson(instance.formatType),
    };
