import 'package:json_annotation/json_annotation.dart';

part 'friend_response.g.dart';

@JsonSerializable()
class FriendResponse {
  final int id;
  final String? nickname;
  final String? profilePictureUrl;
  final int? isInvited;
  final int userLevel;
  final String userRewardTitle;

  FriendResponse(this.id, this.nickname, this.profilePictureUrl, this.isInvited,
      this.userLevel, this.userRewardTitle);

  factory FriendResponse.fromJson(Map<String, dynamic> json) =>
      _$FriendResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FriendResponseToJson(this);
}
