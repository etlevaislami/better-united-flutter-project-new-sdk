import '../net/models/ranked_participant_response.dart';

class RankedParticipant {
  final int rank;
  final int userId;
  final bool isLoggedUser;
  final String? profileIconUrl;
  final int points;
  final String levelName;
  final String? nickname;

  RankedParticipant(this.rank, this.userId, this.isLoggedUser,
      this.profileIconUrl, this.points, this.levelName, this.nickname);

  RankedParticipant.fromRankedParticipantResponse(
      RankedParticipantResponse rankedParticipantResponse)
      : this(
          rankedParticipantResponse.rank,
          rankedParticipantResponse.userId,
          rankedParticipantResponse.isLoggedUser,
          rankedParticipantResponse.profileIconUrl,
          rankedParticipantResponse.pointsEarned,
          rankedParticipantResponse.levelName,
          rankedParticipantResponse.nickname,
        );
}
