// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'participant_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParticipantResponse _$ParticipantResponseFromJson(Map<String, dynamic> json) =>
    ParticipantResponse(
      (json['userId'] as num).toInt(),
      json['userNickname'] as String?,
      json['userProfilePictureUrl'] as String?,
      (json['userTipCountWon'] as num?)?.toInt(),
      (json['userHighestOdd'] as num?)?.toDouble(),
      (json['userExpEarned'] as num).toInt(),
      (json['userLevel'] as num).toInt(),
      json['userRewardTitle'] as String,
      (json['userPointsEarned'] as num).toInt(),
      (json['userRank'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ParticipantResponseToJson(
        ParticipantResponse instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'userNickname': instance.userNickname,
      'userProfilePictureUrl': instance.userProfilePictureUrl,
      'userTipCountWon': instance.userTipCountWon,
      'userHighestOdd': instance.userHighestOdd,
      'userExpEarned': instance.userExpEarned,
      'userLevel': instance.userLevel,
      'userRewardTitle': instance.userRewardTitle,
      'userPointsEarned': instance.userPointsEarned,
      'userRank': instance.userRank,
    };
