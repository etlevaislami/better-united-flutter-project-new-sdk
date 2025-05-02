import 'package:json_annotation/json_annotation.dart';

part 'public_poule_reward_response.g.dart';

@JsonSerializable()
class PublicPouleRewardResponse {
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

  PublicPouleRewardResponse(
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

  factory PublicPouleRewardResponse.fromJson(Map<String, dynamic> json) =>
      _$PublicPouleRewardResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PublicPouleRewardResponseToJson(this);
}
