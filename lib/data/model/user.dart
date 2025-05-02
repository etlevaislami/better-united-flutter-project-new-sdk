import 'package:flutter_better_united/data/model/team.dart';
import 'package:flutter_better_united/data/net/models/profile_response.dart';
import 'package:flutter_better_united/util/extensions/int_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final int userId;
  String? nickname;
  String? profilePictureUrl;
  String? dateOfBirth;
  int coinBalance;
  int expAmount;
  int level;
  int nextLevelExpAmount;
  int followerCount;
  bool hasCreatedTips = false;
  @JsonKey(includeFromJson: false)
  bool isFollowingAuthor = false;
  final double winRate;
  final double averagePoints;

  final int sharedTipsCount;

  final int highestPoints;
  final int languageId;
  final String? rewardTitle;

  @JsonKey(includeFromJson: false)
  List<Team> favoriteTeams = [];

  final int amountJoinedPoules;

  final int wonPublicPoules;

  final int wonFriendPoules;
  final int coinsEarned;
  final int pointsAmount;

  User(
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
    this.amountJoinedPoules,
    this.wonPublicPoules,
    this.wonFriendPoules,
    this.coinsEarned,
    this.pointsAmount,
  );

  factory User.fromProfileResponse(ProfileResponse profile) {
    return User(
        profile.userId,
        profile.nickname,
        profile.profilePictureUrl,
        profile.coinBalance,
        profile.expAmount,
        profile.level,
        profile.nextLevelExpAmount,
        profile.followerCount,
        profile.dateOfBirth,
        profile.winRate,
        profile.averagePoints,
        profile.sharedTipsCount,
        profile.highestPoints,
        profile.languageId,
        profile.rewardTitle,
        profile.amountJoinedPoules,
        profile.wonPublicPoules,
        profile.wonFriendPoules,
        profile.coinsEarned,
        profile.pointsAmount)
      ..isFollowingAuthor = profile.isFollowed.toBool()
      ..favoriteTeams = profile.favouriteTeams
          .map((teamResponse) => Team.fromTeamResponse(teamResponse))
          .toList();
  }

  User.fromLocal(String nickName, String? profilePictureUrl)
      : this(-1, nickName, profilePictureUrl, -1, 0, 0, -1, -1, null, 0, 0, 0,
            0, 0, "", 0, 0, 0, 0, 0);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
