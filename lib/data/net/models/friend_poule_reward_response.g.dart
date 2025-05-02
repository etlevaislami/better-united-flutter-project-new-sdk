// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_poule_reward_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FriendPouleRewardResponse _$FriendPouleRewardResponseFromJson(
        Map<String, dynamic> json) =>
    FriendPouleRewardResponse(
      (json['userRank'] as num?)?.toInt(),
      json['userNickname'] as String,
      json['userRewardTitle'] as String,
      (json['userExpEarned'] as num).toInt(),
      json['userProfilePictureUrl'] as String?,
      json['pouleIconUrl'] as String?,
      (json['predictionShared'] as num).toInt(),
      (json['predictionWon'] as num).toInt(),
      (json['prize'] as num?)?.toInt(),
      (json['userPointsEarned'] as num).toInt(),
      json['pouleName'] as String,
      (json['otherUsersWithSameRank'] as num).toInt(),
      (json['pouleHasNoWinners'] as num).toInt(),
    );

Map<String, dynamic> _$FriendPouleRewardResponseToJson(
        FriendPouleRewardResponse instance) =>
    <String, dynamic>{
      'userRank': instance.userRank,
      'userNickname': instance.userNickname,
      'userRewardTitle': instance.userRewardTitle,
      'userExpEarned': instance.userExpEarned,
      'userProfilePictureUrl': instance.userProfilePictureUrl,
      'pouleIconUrl': instance.pouleIconUrl,
      'predictionShared': instance.predictionShared,
      'predictionWon': instance.predictionWon,
      'prize': instance.prize,
      'userPointsEarned': instance.userPointsEarned,
      'pouleName': instance.pouleName,
      'otherUsersWithSameRank': instance.otherUsersWithSameRank,
      'pouleHasNoWinners': instance.pouleHasNoWinners,
    };
