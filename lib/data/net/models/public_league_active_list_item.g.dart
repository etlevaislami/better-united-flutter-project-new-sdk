// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'public_league_active_list_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PublicLeagueActivePouleItem _$PublicLeagueActivePouleItemFromJson(
        Map<String, dynamic> json) =>
    PublicLeagueActivePouleItem(
      (json['id'] as num).toInt(),
      json['name'] as String,
      const DateTimeConverter().fromJson(json['startsAt'] as String),
      const DateTimeConverter().fromJson(json['endsAt'] as String),
      (json['userCount'] as num).toInt(),
      (json['userRank'] as num?)?.toInt(),
      (json['predictionsRemaining'] as num).toInt(),
      json['iconUrl'] as String?,
      (json['poolPrizeTotal'] as num).toInt(),
      (json['poolPrizeAmountFirst'] as num).toInt(),
      (json['poolPrizeAmountSecond'] as num).toInt(),
      (json['poolPrizeAmountThird'] as num).toInt(),
      (json['poolPrizeAmountOthers'] as num).toInt(),
      (json['leagues'] as List<dynamic>)
          .map(
              (e) => FootballLeagueResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      const PouleStatusTypeConverter().fromJson(json['status'] as String),
      (json['matches'] as List<dynamic>)
          .map((e) => PublicMatchResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      PublicPouleTypeConverter.fromJson(json['formatType'] as String),
    );

Map<String, dynamic> _$PublicLeagueActivePouleItemToJson(
        PublicLeagueActivePouleItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'startsAt': const DateTimeConverter().toJson(instance.startsAt),
      'endsAt': const DateTimeConverter().toJson(instance.endsAt),
      'userCount': instance.userCount,
      'userRank': instance.userRank,
      'predictionsRemaining': instance.predictionsRemaining,
      'poolPrizeTotal': instance.poolPrizeTotal,
      'poolPrizeAmountFirst': instance.poolPrizeAmountFirst,
      'poolPrizeAmountSecond': instance.poolPrizeAmountSecond,
      'poolPrizeAmountThird': instance.poolPrizeAmountThird,
      'poolPrizeAmountOthers': instance.poolPrizeAmountOthers,
      'iconUrl': instance.iconUrl,
      'leagues': instance.leagues,
      'status': const PouleStatusTypeConverter().toJson(instance.status),
      'matches': instance.matches,
      'formatType': PublicPouleTypeConverter.toJson(instance.formatType),
    };
