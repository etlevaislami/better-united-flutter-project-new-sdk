import 'package:flutter_better_united/util/extensions/int_extension.dart';

import '../enum/poule_type.dart';
import '../net/models/friend_poule_reward_response.dart';
import '../net/models/public_poule_reward_response.dart';

class PouleReward {
  final int? userRank;
  final String userNickname;
  final String userRewardTitle;
  final int userExpEarned;
  final String? userProfilePictureUrl;
  final String? pouleIconUrl;
  final int userTipCountTotal;
  final int userTipCountWon;
  final int? prize;
  final String? pouleName;
  final PouleType pouleType;
  final int pouleId;
  final int userPointsEarned;
  final int otherUsersWithSameRank;
  final bool isUserWon;

  PouleReward(
      this.userRank,
      this.userNickname,
      this.userRewardTitle,
      this.userExpEarned,
      this.userProfilePictureUrl,
      this.pouleIconUrl,
      this.userTipCountTotal,
      this.userTipCountWon,
      this.prize,
      this.pouleName,
      this.pouleType,
      this.pouleId,
      this.userPointsEarned,
      this.otherUsersWithSameRank,
      this.isUserWon);

  PouleReward.fromPublicPouleRewardResponse(
      int id, PublicPouleRewardResponse response)
      : this(
            response.userRank,
            response.userNickname,
            response.userRewardTitle,
            response.userExpEarned,
            response.userProfilePictureUrl,
            response.pouleIconUrl,
            response.predictionShared,
            response.predictionWon,
            response.prize,
            response.pouleName,
            PouleType.public,
            id,
            response.userPointsEarned,
            response.otherUsersWithSameRank,
            response.pouleHasNoWinners.toBool() ? false : true);

  PouleReward.fromFriendPouleRewardResponse(
      int id, FriendPouleRewardResponse response)
      : this(
            response.userRank,
            response.userNickname,
            response.userRewardTitle,
            response.userExpEarned,
            response.userProfilePictureUrl,
            response.pouleIconUrl,
            response.predictionShared,
            response.predictionWon,
            response.prize ?? 0,
            response.pouleName,
            PouleType.friend,
            id,
            response.userPointsEarned,
            response.otherUsersWithSameRank,
            response.pouleHasNoWinners.toBool() ? false : true);
}
