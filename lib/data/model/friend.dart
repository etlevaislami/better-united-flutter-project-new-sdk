import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_better_united/data/model/participant.dart';
import 'package:flutter_better_united/data/net/models/friend_response.dart';
import 'package:flutter_better_united/util/extensions/int_extension.dart';

import 'other_user.dart';

class Friend {
  final int id;
  final String nickname;
  final String? profilePictureUrl;
  bool isInvited = false;
  bool isLoading = false;
  final int level;
  final String levelName;
  final bool isJoined;

  Friend(this.id, this.nickname, this.profilePictureUrl, this.isInvited,
      this.level, this.levelName,
      {this.isJoined = false});

  Friend.fromFriendResponse(FriendResponse friendResponse)
      : this(
            friendResponse.id,
            friendResponse.nickname ?? "undefined".tr(),
            friendResponse.profilePictureUrl,
            friendResponse.isInvited.toBool(),
            friendResponse.userLevel,
            friendResponse.userRewardTitle);

  Friend.fromParticipant(Participant participant)
      : this(
            participant.userId,
            participant.userNickname,
            participant.userProfilePictureUrl,
            true,
            participant.level,
            participant.levelName);

  Friend.fromOtherUser(OtherUser otherUser)
      : this(otherUser.id, otherUser.nickname, otherUser.profilePictureUrl,
            false, otherUser.userLevel, otherUser.userRewardTitle,
            isJoined: otherUser.isJoined);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Friend) return false;
    return other.id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
