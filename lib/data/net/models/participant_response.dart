import 'package:json_annotation/json_annotation.dart';

part 'participant_response.g.dart';

@JsonSerializable()
class ParticipantResponse {
  final int userId;
  final String? userNickname;
  final String? userProfilePictureUrl;
  final int? userTipCountWon;
  final double? userHighestOdd;
  final int userExpEarned;
  final int userLevel;
  final String userRewardTitle;
  final int userPointsEarned;
  final int? userRank;

  ParticipantResponse(
      this.userId,
      this.userNickname,
      this.userProfilePictureUrl,
      this.userTipCountWon,
      this.userHighestOdd,
      this.userExpEarned,
      this.userLevel,
      this.userRewardTitle,
      this.userPointsEarned,
      this.userRank);

  factory ParticipantResponse.fromJson(Map<String, dynamic> json) =>
      _$ParticipantResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ParticipantResponseToJson(this);
}
