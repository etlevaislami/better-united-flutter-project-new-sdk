// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileResponse _$ProfileResponseFromJson(Map<String, dynamic> json) =>
    ProfileResponse(
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
      (json['favouriteTeams'] as List<dynamic>)
          .map((e) => TeamResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['amountJoinedPoules'] as num).toInt(),
      (json['wonPublicPoules'] as num).toInt(),
      (json['wonFriendPoules'] as num).toInt(),
      (json['coinsEarned'] as num).toInt(),
      (json['pointsAmount'] as num).toInt(),
      (json['isFollowed'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ProfileResponseToJson(ProfileResponse instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'nickname': instance.nickname,
      'profilePictureUrl': instance.profilePictureUrl,
      'dateOfBirth': instance.dateOfBirth,
      'coinBalance': instance.coinBalance,
      'expAmount': instance.expAmount,
      'level': instance.level,
      'nextLevelExpAmount': instance.nextLevelExpAmount,
      'followerCount': instance.followerCount,
      'winRate': instance.winRate,
      'averagePoints': instance.averagePoints,
      'sharedTipsCount': instance.sharedTipsCount,
      'highestPoints': instance.highestPoints,
      'languageId': instance.languageId,
      'rewardTitle': instance.rewardTitle,
      'favouriteTeams': instance.favouriteTeams,
      'amountJoinedPoules': instance.amountJoinedPoules,
      'wonPublicPoules': instance.wonPublicPoules,
      'wonFriendPoules': instance.wonFriendPoules,
      'coinsEarned': instance.coinsEarned,
      'pointsAmount': instance.pointsAmount,
      'isFollowed': instance.isFollowed,
    };
