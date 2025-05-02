// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      (json['userId'] as num).toInt(),
      json['nickname'] as String?,
      json['profilePictureUrl'] as String?,
      (json['coinBalance'] as num).toInt(),
      (json['expAmount'] as num).toInt(),
      (json['level'] as num).toInt(),
      (json['nextLevelExpAmount'] as num).toInt(),
      (json['followerCount'] as num).toInt(),
      json['dateOfBirth'] as String?,
      (json['winRate'] as num).toDouble(),
      (json['averagePoints'] as num).toDouble(),
      (json['sharedTipsCount'] as num).toInt(),
      (json['highestPoints'] as num).toInt(),
      (json['languageId'] as num).toInt(),
      json['rewardTitle'] as String?,
      (json['amountJoinedPoules'] as num).toInt(),
      (json['wonPublicPoules'] as num).toInt(),
      (json['wonFriendPoules'] as num).toInt(),
      (json['coinsEarned'] as num).toInt(),
      (json['pointsAmount'] as num).toInt(),
    )..hasCreatedTips = json['hasCreatedTips'] as bool;

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'userId': instance.userId,
      'nickname': instance.nickname,
      'profilePictureUrl': instance.profilePictureUrl,
      'dateOfBirth': instance.dateOfBirth,
      'coinBalance': instance.coinBalance,
      'expAmount': instance.expAmount,
      'level': instance.level,
      'nextLevelExpAmount': instance.nextLevelExpAmount,
      'followerCount': instance.followerCount,
      'hasCreatedTips': instance.hasCreatedTips,
      'winRate': instance.winRate,
      'averagePoints': instance.averagePoints,
      'sharedTipsCount': instance.sharedTipsCount,
      'highestPoints': instance.highestPoints,
      'languageId': instance.languageId,
      'rewardTitle': instance.rewardTitle,
      'amountJoinedPoules': instance.amountJoinedPoules,
      'wonPublicPoules': instance.wonPublicPoules,
      'wonFriendPoules': instance.wonFriendPoules,
      'coinsEarned': instance.coinsEarned,
      'pointsAmount': instance.pointsAmount,
    };
