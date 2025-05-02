import 'package:json_annotation/json_annotation.dart';

part 'user_response.g.dart';

@JsonSerializable()
class UserResponse {
  final int id;
  final String? nickname;
  final String? profilePictureUrl;
  final int isFollowed;
  final int userLevel;
  final String userRewardTitle;
  final int isLoggedUser;

  UserResponse(this.id, this.nickname, this.profilePictureUrl, this.isFollowed,
      this.userLevel, this.userRewardTitle, this.isLoggedUser);

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}
