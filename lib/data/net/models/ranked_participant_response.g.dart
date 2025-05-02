// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ranked_participant_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RankedParticipantResponse _$RankedParticipantResponseFromJson(
        Map<String, dynamic> json) =>
    RankedParticipantResponse(
      (json['rank'] as num).toInt(),
      (json['userId'] as num).toInt(),
      json['isLoggedUser'] as bool,
      json['profileIconUrl'] as String?,
      (json['pointsEarned'] as num).toInt(),
      json['levelName'] as String,
      json['nickname'] as String?,
    );

Map<String, dynamic> _$RankedParticipantResponseToJson(
        RankedParticipantResponse instance) =>
    <String, dynamic>{
      'rank': instance.rank,
      'userId': instance.userId,
      'isLoggedUser': instance.isLoggedUser,
      'profileIconUrl': instance.profileIconUrl,
      'pointsEarned': instance.pointsEarned,
      'levelName': instance.levelName,
      'nickname': instance.nickname,
    };
