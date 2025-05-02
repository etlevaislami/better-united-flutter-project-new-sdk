import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/constants/extended_theme.dart';
import 'package:flutter_better_united/util/extensions/int_extension.dart';
import 'package:flutter_better_united/util/ranking/ranking_util.dart';
import 'package:flutter_better_united/widgets/rank_widget.dart';

import '../figma/colors.dart';
import 'avatar_widget.dart';

class FriendRankWidget extends StatelessWidget {
  const FriendRankWidget({
    Key? key,
    required this.name,
    required this.levelName,
    required this.points,
    required this.wins,
    required this.highestOdd,
    required this.powerUpsUsed,
    required this.rank,
    this.pointColor = AppColors.primary,
    this.onProfileTap,
    this.profileUrl,
    this.drawShadow = false,
    required this.isConnectedUser,
    required this.level,
    this.drawPlus = true,
    this.coins,
  }) : super(key: key);
  final String name;
  final String? profileUrl;
  final String levelName;
  final int level;
  final int points;
  final int wins;
  final double highestOdd;
  final int powerUpsUsed;
  final int? rank;
  final Color pointColor;
  final Function? onProfileTap;
  final bool isConnectedUser;
  final bool drawShadow;
  final bool drawPlus;
  final int? coins;

  static const double avatarSize = 52.0;

  @override
  Widget build(BuildContext context) {
    final rankIfUserHasPoints = points > 0 ? rank : null;
    return Container(
      clipBehavior: isConnectedUser ? Clip.antiAlias : Clip.none,
      decoration: isConnectedUser
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: context.theme.primaryColor,
                width: 1,
              ),
            )
          : drawShadow
              ? const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x3D9AE343),
                      spreadRadius: 1,
                      blurRadius: 24,
                      offset: Offset(0, 0), // changes position of shadow
                    ),
                  ],
                )
              : null,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: CustomPaint(
          painter: BackgroundCustomPainter(
              _getRankBackgroundColor(rankIfUserHasPoints)),
          child: Container(
            margin: const EdgeInsets.all(2.5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 17.0, right: 17, bottom: 14, top: 18),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => onProfileTap?.call(),
                        child: Stack(
                          children: [
                            SizedBox(
                              child: SizedBox(
                                height: avatarSize,
                                width: avatarSize,
                                child: Stack(
                                  children: [
                                    Positioned.fill(
                                      child: Align(
                                        alignment:
                                            const FractionalOffset(-0.5, 1),
                                        child: AvatarWidget(
                                          level: level,
                                          isFollowButtonVisible: false,
                                          profileUrl: profileUrl,
                                          gradient: RankingUtil.getRankGradient(
                                              rankIfUserHasPoints,
                                              isConnectedUser),
                                          shadowColor:
                                              RankingUtil.getShadowColor(
                                                  rankIfUserHasPoints),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Transform.translate(
                              offset: const Offset(
                                  -avatarSize * 0.1, avatarSize * 0.1),
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(
                                    maxHeight: 17, minWidth: 20, minHeight: 17),
                                child: RankWidget(
                                  text: rankIfUserHasPoints == null
                                      ? " - "
                                      : rankIfUserHasPoints.toString(),
                                  linearGradient: RankingUtil.getBadgeGradient(
                                      rankIfUserHasPoints, isConnectedUser),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  (isConnectedUser ? "you".tr() : name)
                                      .toUpperCase(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 14,
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
                                const SizedBox(
                                  width: 10,
                                ),
                                coins != null
                                    ? Expanded(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Expanded(
                                              child: AutoSizeText(
                                                  (coins ?? 0).formatNumber(),
                                                  minFontSize: 1,
                                                  maxLines: 1,
                                                  textAlign: TextAlign.end,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontStyle: FontStyle.italic,
                                                    fontWeight: FontWeight.w700,
                                                    color: AppColors.primary,
                                                  )),
                                            ),
                                            Image.asset(
                                              "assets/icons/ic_coins.png",
                                              height: 24,
                                            )
                                          ],
                                        ),
                                      )
                                    : RichText(
                                        text: TextSpan(
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontStyle: FontStyle.italic,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            shadows: [
                                              Shadow(
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                                offset: const Offset(0, 2),
                                                blurRadius: 16,
                                              ),
                                            ],
                                          ),
                                          children: [
                                            TextSpan(
                                                text: points.toString(),
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontStyle: FontStyle.italic,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                  shadows: [
                                                    Shadow(
                                                      color: Colors.black
                                                          .withOpacity(0.5),
                                                      offset:
                                                          const Offset(0, 2),
                                                      blurRadius: 16,
                                                    ),
                                                  ],
                                                ).copyWith(color: pointColor)),
                                            const TextSpan(
                                              text: " ",
                                            ),
                                            TextSpan(
                                              text: "pointArgs".plural(points),
                                            ),
                                          ],
                                        ),
                                      ),
                              ],
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              levelName.toUpperCase(),
                              style: context.buttonPrimaryUnderline.copyWith(
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.italic,
                                color: const Color(0xff989898),
                                fontSize: 12,
                                shadows: [
                                  Shadow(
                                    color: Colors.black.withOpacity(0.5),
                                    offset: const Offset(0, 2),
                                    blurRadius: 16,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getRankBackgroundColor(int? rank) {
    switch (rank) {
      case 1:
        return const Color(0xffFFDF1A);
      case 2:
        return const Color(0xffE6E6E6);
      case 3:
        return const Color(0xffFD8E3A);
      default:
        return const Color(0xff353535);
    }
  }
}

class BackgroundCustomPainter extends CustomPainter {
  late final Paint _backgroundPaint;
  late final Paint _paint;

  BackgroundCustomPainter(Color color) {
    _backgroundPaint = Paint()
      ..color = const Color(0xff353535)
      ..style = PaintingStyle.fill;

    _paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width, size.height), _backgroundPaint);
    final widthPortion = size.width * 0.2;
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(widthPortion, 0)
      ..lineTo(widthPortion * 0.5, size.height)
      ..lineTo(0, size.height)
      ..moveTo(0, 0)
      ..close();
    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
