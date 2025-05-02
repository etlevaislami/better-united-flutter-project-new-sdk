// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) => UserResponse(
      (json['id'] as num).toInt(),
      json['nickname'] as String?,
      json['profilePictureUrl'] as String?,
      (json['isFollowed'] as num).toInt(),
      (json['userLevel'] as num).toInt(),
      json['userRewardTitle'] as String,
      (json['isLoggedUser'] as num).toInt(),
    );

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nickname': instance.nickname,
      'profilePictureUrl': instance.profilePictureUrl,
      'isFollowed': instance.isFollowed,
      'userLevel': instance.userLevel,
      'userRewardTitle': instance.userRewardTitle,
      'isLoggedUser': instance.isLoggedUser,
    };
