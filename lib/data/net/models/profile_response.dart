import 'package:json_annotation/json_annotation.dart';

import 'match_response.dart';

part 'profile_response.g.dart';

@JsonSerializable()
class ProfileResponse {
  final int userId;
  final String? nickname;
  final String? profilePictureUrl;
  final String? dateOfBirth;
  final int coinBalance;
  final int expAmount;
  final int level;
  final int nextLevelExpAmount;
  final int followerCount;
  final double winRate;
  final double averagePoints;
  final int sharedTipsCount;

  final int highestPoints;
  final int languageId;
  final String? rewardTitle;
  final List<TeamResponse> favouriteTeams;
  final int amountJoinedPoules;
  final int wonPublicPoules;
  final int wonFriendPoules;
  final int coinsEarned;
  final int pointsAmount;
  final int? isFollowed;

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return _$ProfileResponseFromJson(json);
  }

  ProfileResponse(
      this.userId,
      this.nickname,
      this.profilePictureUrl,
      this.coinBalance,
      this.expAmount,
      this.level,
      this.nextLevelExpAmount,
      this.followerCount,
      this.dateOfBirth,
      this.winRate,
      this.averagePoints,
      this.sharedTipsCount,
      this.highestPoints,
      this.languageId,
      this.rewardTitle,
      this.favouriteTeams,
      this.amountJoinedPoules,
      this.wonPublicPoules,
      this.wonFriendPoules,
      this.coinsEarned,
      this.pointsAmount,
      this.isFollowed);

  Map<String, dynamic> toJson() => _$ProfileResponseToJson(this);
}