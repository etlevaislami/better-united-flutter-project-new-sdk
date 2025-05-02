import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/constants/app_colors.dart';
import 'package:flutter_better_united/data/model/ranked_participant.dart';
import 'package:flutter_better_united/figma/dimensions.dart';
import 'package:flutter_better_united/pages/shop/user_provider.dart';
import 'package:flutter_better_united/util/ranking/ranking_util.dart';
import 'package:flutter_better_united/widgets/avatar_widget.dart';
import 'package:flutter_better_united/widgets/rank_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

/// Football field that shows the top-ranked 11 players
class RankingField extends StatefulWidget {
  const RankingField({
    Key? key,
    required this.rankings,
  }) : super(key: key);

  final List<RankedParticipant> rankings;

  @override
  State<RankingField> createState() => _RankingFieldState();
}

class _RankingFieldState extends State<RankingField> {
  late final int _connectedUserId;

  @override
  void initState() {
    _connectedUserId = context.read<UserProvider>().user?.userId ?? -1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final constraintMaxWidth = constraints.maxWidth;
        final constraintMaxHeight = constraints.maxHeight;

        const fieldAspectRatio = 0.7313;
        double fieldWidth = 0;
        double fieldHeight = 0;

        final constraintsAspectRatio = constraintMaxWidth / constraintMaxHeight;

        if (constraintsAspectRatio > fieldAspectRatio) {
          /// This is the case for the dialog
          // available height is larger then the field image height (compared to width).
          // the field will take full width of available space. Define height based on width.
          fieldHeight = constraintMaxHeight;
          fieldWidth = fieldAspectRatio * constraintMaxHeight;
        } else {
          /// This is the case for the full screen
          fieldWidth = constraintMaxWidth;
          fieldHeight = constraintMaxWidth / fieldAspectRatio;
        }

        final avatarSize =
            AppDimensions.teamOfWeekPlayerSize * fieldHeight * 0.0015;

        return Center(
          child: Container(
            height: fieldHeight,
            width: fieldWidth,
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              // fit: StackFit.passthrough,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 0.02 * fieldHeight,
                      horizontal: 0.01 * fieldWidth),
                  child: SvgPicture.asset(
                    "assets/other/bg_field.svg",
                    fit: BoxFit.contain,
                  ),
                ),
                if (widget.rankings.isNotEmpty)
                  Positioned(
                      top: 0.02 * fieldHeight -0.5 * avatarSize,
                      child: _buildPlayer(widget.rankings[0], avatarSize)),
                if (widget.rankings.length > 1)
                  Positioned(
                      top: 0.14 * fieldHeight - 0.5 * avatarSize,
                      left: 0.17 * fieldWidth,
                      child: _buildPlayer(widget.rankings[1], avatarSize)),
                if (widget.rankings.length > 2)
                  Positioned(
                      top: 0.14 * fieldHeight - 0.5 * avatarSize,
                      right: 0.17 * fieldWidth,
                      child: _buildPlayer(widget.rankings[2], avatarSize)),
                if (widget.rankings.length > 3)
                  Positioned(
                      top: 0.31 * fieldHeight - 0.5 * avatarSize,
                      left: 0.25 * fieldWidth,
                      child: _buildPlayer(widget.rankings[3], avatarSize)),
                if (widget.rankings.length > 4)
                  Positioned(
                      top: 0.31 * fieldHeight - 0.5 * avatarSize,
                      right: 0.25 * fieldWidth,
                      child: _buildPlayer(widget.rankings[4], avatarSize)),
                // This is the center spot.
                if (widget.rankings.length > 5)
                  Positioned(
                      top: 0.5 * fieldHeight - 0.5 * avatarSize,
                      child: _buildPlayer(widget.rankings[5], avatarSize)),
                if (widget.rankings.length > 6)
                  Positioned(
                      bottom: 0.29 * fieldHeight + 0.5 * avatarSize,
                      left: 0.12 * fieldWidth,
                      child: _buildPlayer(widget.rankings[6], avatarSize)),
                if (widget.rankings.length > 7)
                  Positioned(
                      bottom: 0.29 * fieldHeight + 0.5 * avatarSize,
                      right: 0.12 * fieldWidth,
                      child: _buildPlayer(widget.rankings[7], avatarSize)),
                if (widget.rankings.length > 8)
                  Positioned(
                      bottom: 0.13 * fieldHeight + 0.5 * avatarSize,
                      left: 0.33 * fieldWidth,
                      child: _buildPlayer(widget.rankings[8], avatarSize)),
                if (widget.rankings.length > 9)
                  Positioned(
                      bottom: 0.13 * fieldHeight + 0.5 * avatarSize,
                      right: 0.33 * fieldWidth,
                      child: _buildPlayer(widget.rankings[9], avatarSize)),
                if (widget.rankings.length > 10)
                  Positioned(
                      bottom: 0.02 * fieldHeight -0.5 * avatarSize,
                      child: _buildPlayer(widget.rankings[10], avatarSize)),
              ],
            ),
          ),
        );
      },
    );
  }

  _buildPlayer(RankedParticipant participant, double avatarSize) {
    final isConnectedUser = participant.userId == _connectedUserId;
    final labelHeight = avatarSize / 2.7;
    return SizedBox(
      height: avatarSize,
      width: avatarSize,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          if (isConnectedUser)
            Align(
              alignment: Alignment.center,
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                    AppColors.primaryColor.withOpacity(0.7), BlendMode.srcATop),
                child: Transform.translate(
                  // translate a tiny bit down because the lottie file seems to be not perfectly centered. 
                  offset:  Offset(0, avatarSize * 0.05),
                  child: Transform.scale(
                      scale: 1.7,
                      child: Lottie.asset(
                        'assets/animations/daily-rewards.json',
                      )),
                ),
              ),
            ),
          Container(
            width: avatarSize,
            child: AvatarWidget(
              level: participant.rank,
              isFollowButtonVisible: false,
              profileUrl: participant.profileIconUrl,
              gradient: RankingUtil.getRankGradient(
                  participant.rank, isConnectedUser),
              shadowColor: RankingUtil.getShadowColor(participant.rank),
              defaultSize: avatarSize,
              isRankVisible: false,
              border: GradientBoxBorder(
                gradient: RankingUtil.getRankGradient(
                    participant.rank, isConnectedUser),
                width: avatarSize / 64,
              ),
            ),
          ),
          Positioned(
            bottom: -0.9 * labelHeight,
            child: Container(
              height: labelHeight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RankWidget(
                    text: participant.rank.toString(),
                    linearGradient: RankingUtil.getBadgeGradient(
                        participant.rank, isConnectedUser),
                  ),
                  Text(
                    (isConnectedUser
                            ? "you".tr()
                            : participant.nickname ?? '')
                        .toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                      fontSize: labelHeight / 1.4,
                      fontWeight: FontWeight.w700,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.5),
                          offset: const Offset(0, 2),
                          blurRadius: 16,
                        ),
                      ],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
