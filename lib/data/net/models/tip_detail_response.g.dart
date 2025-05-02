// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tip_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TipDetailResponse _$TipDetailResponseFromJson(Map<String, dynamic> json) =>
    TipDetailResponse(
      (json['id'] as num).toInt(),
      const DateTimeConverter().fromJson(json['tipCreatedAt'] as String),
      (json['odds'] as num).toDouble(),
      (json['matchId'] as num).toInt(),
      const DateTimeConverter().fromJson(json['matchStartsAt'] as String),
      (json['userId'] as num).toInt(),
      json['userNickname'] as String?,
      json['userProfilePictureUrl'] as String?,
      TeamResponse.fromJson(json['homeTeam'] as Map<String, dynamic>),
      TeamResponse.fromJson(json['awayTeam'] as Map<String, dynamic>),
      (json['isOwn'] as num).toInt(),
      (json['isFollowingAuthor'] as num).toInt(),
      json['leagueName'] as String,
      intToTipSettlement((json['tipSettlement'] as num?)?.toInt()),
      (json['expEarned'] as num).toInt(),
      (json['userLevel'] as num).toInt(),
      json['userRewardTitle'] as String,
      (json['hints'] as List<dynamic>?)?.map((e) => e as String).toList(),
      (json['expEarnedFriendLeague'] as num).toInt(),
      (json['friendLeagueId'] as num?)?.toInt(),
      (json['publicLeagueId'] as num?)?.toInt(),
      (json['points'] as num).toInt(),
      (json['isTipVoided'] as num).toInt(),
    );

Map<String, dynamic> _$TipDetailResponseToJson(TipDetailResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tipCreatedAt': const DateTimeConverter().toJson(instance.tipCreatedAt),
      'odds': instance.odds,
      'matchId': instance.matchId,
      'matchStartsAt': const DateTimeConverter().toJson(instance.matchStartsAt),
      'userId': instance.userId,
      'userNickname': instance.userNickname,
      'userProfilePictureUrl': instance.userProfilePictureUrl,
      'homeTeam': instance.homeTeam,
      'awayTeam': instance.awayTeam,
      'isOwn': instance.isOwn,
      'isFollowingAuthor': instance.isFollowingAuthor,
      'leagueName': instance.leagueName,
      'expEarned': instance.expEarned,
      'userLevel': instance.userLevel,
      'userRewardTitle': instance.userRewardTitle,
      'hints': instance.hints,
      'tipSettlement': tipSettlementFromInt(instance.tipSettlement),
      'expEarnedFriendLeague': instance.expEarnedFriendLeague,
      'friendLeagueId': instance.friendLeagueId,
      'publicLeagueId': instance.publicLeagueId,
      'points': instance.points,
      'isTipVoided': instance.isTipVoided,
    };
