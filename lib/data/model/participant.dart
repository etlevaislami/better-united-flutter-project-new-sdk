import 'package:easy_localization/easy_localization.dart';

import '../net/models/participant_response.dart';

class Participant {
  final int userId;
  final String userNickname;
  final String? userProfilePictureUrl;
  final int userTipCountWon;
  final double userHighestOdd;
  final int userPowerupsUsed;
  final int userExpEarned;
  final int level;
  final String levelName;
  int index = 0;
  final int? earnedCoins;
  final int userPointsEarned;
  final int? userRank;

  Participant(
    this.userId,
    this.userNickname,
    this.userProfilePictureUrl,
    this.userTipCountWon,
    this.userHighestOdd,
    this.userPowerupsUsed,
    this.userExpEarned,
    this.level,
    this.levelName,
    this.earnedCoins,
    this.userPointsEarned,
      this.userRank);

  Participant.fromParticipantResponse(ParticipantResponse participantResponse)
      : this(
            participantResponse.userId,
            participantResponse.userNickname ?? "undefined".tr(),
            participantResponse.userProfilePictureUrl,
            participantResponse.userTipCountWon ?? 0,
            (participantResponse.userHighestOdd ?? 0).toDouble(),
            0,
            participantResponse.userExpEarned,
            participantResponse.userLevel,
            participantResponse.userRewardTitle,
            null,
            participantResponse.userPointsEarned,
            participantResponse.userRank);
}
