// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_league_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FriendLeagueDetailResponse _$FriendLeagueDetailResponseFromJson(
        Map<String, dynamic> json) =>
    FriendLeagueDetailResponse(
      (json['id'] as num).toInt(),
      json['name'] as String,
      const DateTimeConverter().fromJson(json['startsAt'] as String),
      const DateTimeConverter().fromJson(json['endsAt'] as String),
      (json['tipCountTotal'] as num).toInt(),
      (json['tipCountLost'] as num?)?.toInt(),
      (json['tipCountWon'] as num?)?.toInt(),
      (json['userRankings'] as List<dynamic>)
          .map((e) => ParticipantResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['maximumTipCount'] as num).toInt(),
      (json['userTipCountTotal'] as num).toInt(),
      (json['matchId'] as num).toInt(),
      const DateTimeConverter().fromJson(json['matchStartsAt'] as String),
      json['homeTeamName'] as String,
      json['awayTeamName'] as String,
      json['homeTeamLogoUrl'] as String?,
      json['awayTeamLogoUrl'] as String?,
      (json['prizePool'] as num?)?.toInt(),
      json['leagueName'] as String?,
      (json['predictionsRemaining'] as num).toInt(),
      (json['entryFee'] as num).toInt(),
      const PouleStatusTypeConverter().fromJson(json['status'] as String),
    );

Map<String, dynamic> _$FriendLeagueDetailResponseToJson(
        FriendLeagueDetailResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'startsAt': const DateTimeConverter().toJson(instance.startsAt),
      'endsAt': const DateTimeConverter().toJson(instance.endsAt),
      'tipCountTotal': instance.tipCountTotal,
      'tipCountLost': instance.tipCountLost,
      'tipCountWon': instance.tipCountWon,
      'userRankings': instance.userRankings,
      'maximumTipCount': instance.maximumTipCount,
      'userTipCountTotal': instance.userTipCountTotal,
      'matchId': instance.matchId,
      'matchStartsAt': const DateTimeConverter().toJson(instance.matchStartsAt),
      'homeTeamName': instance.homeTeamName,
      'awayTeamName': instance.awayTeamName,
      'homeTeamLogoUrl': instance.homeTeamLogoUrl,
      'awayTeamLogoUrl': instance.awayTeamLogoUrl,
      'prizePool': instance.prizePool,
      'leagueName': instance.leagueName,
      'predictionsRemaining': instance.predictionsRemaining,
      'entryFee': instance.entryFee,
      'status': const PouleStatusTypeConverter().toJson(instance.status),
    };
