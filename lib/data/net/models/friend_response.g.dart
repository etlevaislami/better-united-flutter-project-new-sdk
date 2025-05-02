// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FriendResponse _$FriendResponseFromJson(Map<String, dynamic> json) =>
    FriendResponse(
      (json['id'] as num).toInt(),
      json['nickname'] as String?,
      json['profilePictureUrl'] as String?,
      (json['isInvited'] as num?)?.toInt(),
      (json['userLevel'] as num).toInt(),
      json['userRewardTitle'] as String,
    );

Map<String, dynamic> _$FriendResponseToJson(FriendResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nickname': instance.nickname,
      'profilePictureUrl': instance.profilePictureUrl,
      'isInvited': instance.isInvited,
      'userLevel': instance.userLevel,
      'userRewardTitle': instance.userRewardTitle,
    };
