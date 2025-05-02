import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_better_united/data/net/models/user_response.dart';
import 'package:flutter_better_united/util/extensions/int_extension.dart';

class OtherUser {
  final int id;
  final String nickname;
  final String? profilePictureUrl;
  bool isFollowed;
  bool isJoined = false;
  bool isInvited = false;
  bool isLoading = false;
  final int userLevel;
  final String userRewardTitle;
  final bool isLoggedUser;

  OtherUser(this.id, this.nickname, this.profilePictureUrl, this.isFollowed,
      this.userLevel, this.userRewardTitle, this.isLoggedUser);

  OtherUser.fromUserResponse(UserResponse userResponse)
      : this(
            userResponse.id,
            userResponse.nickname ?? "undefined".tr(),
            userResponse.profilePictureUrl,
            userResponse.isFollowed == 1 ? true : false,
            userResponse.userLevel,
            userResponse.userRewardTitle,
            userResponse.isLoggedUser.toBool());
}
