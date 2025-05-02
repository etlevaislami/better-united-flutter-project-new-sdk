import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/constants/extended_theme.dart';

import 'avatar_widget.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget(
      {Key? key,
      required this.isFollowButtonVisible,
      required this.nickname,
      required this.leagueRank,
      this.isRankVisible = true,
      this.profileUrl = "",
      required this.level,
      this.imageAsset,
      this.gradient})
      : super(key: key);
  final bool isFollowButtonVisible;
  final bool isRankVisible;
  final String nickname;
  final String leagueRank;
  final int level;
  final String? imageAsset;
  final LinearGradient? gradient;

  //todo remove default value after API implementation
  final String? profileUrl;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AvatarWidget(
          gradient: gradient,
          isFollowButtonVisible: isFollowButtonVisible,
          isRankVisible: isRankVisible,
          profileUrl: profileUrl,
          imageAsset: imageAsset,
          level: level,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 23),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nickname,
                  maxLines: 1,
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  style: context.bodyBold.copyWith(
                    color: Colors.white,
                  ),
                ).fontSize(14),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  leagueRank,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                  style: context.buttonPrimaryUnderline.copyWith(
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.italic,
                    color: const Color(0xff989898),
                    fontSize: 12,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
