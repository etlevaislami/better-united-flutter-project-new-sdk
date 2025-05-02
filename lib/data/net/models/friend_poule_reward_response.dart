import 'package:json_annotation/json_annotation.dart';

part 'friend_poule_reward_response.g.dart';

@JsonSerializable()
class FriendPouleRewardResponse {
  final int? userRank;
  final String userNickname;
  final String userRewardTitle;
  final int userExpEarned;
  final String? userProfilePictureUrl;
  final String? pouleIconUrl;
  final int predictionShared;
  final int predictionWon;
  final int? prize;
  final int userPointsEarned;
  final String pouleName;
  final int otherUsersWithSameRank;
  final int pouleHasNoWinners;

  FriendPouleRewardResponse(
      this.userRank,
      this.userNickname,
      this.userRewardTitle,
      this.userExpEarned,
      this.userProfilePictureUrl,
      this.pouleIconUrl,
      this.predictionShared,
      this.predictionWon,
      this.prize,
      this.userPointsEarned,
      this.pouleName,
      this.otherUsersWithSameRank,
      this.pouleHasNoWinners);

  factory FriendPouleRewardResponse.fromJson(Map<String, dynamic> json) =>
      _$FriendPouleRewardResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FriendPouleRewardResponseToJson(this);
}
