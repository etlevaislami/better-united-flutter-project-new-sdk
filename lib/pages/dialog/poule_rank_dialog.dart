import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/constants/extended_theme.dart';
import 'package:flutter_better_united/data/model/poule_reward.dart';
import 'package:flutter_better_united/figma/colors.dart';
import 'package:flutter_better_united/pages/dialog/user_xp_progress_indicator.dart';
import 'package:flutter_better_united/util/betterUnited_icons.dart';
import 'package:flutter_better_united/widgets/fixed_button.dart';
import 'package:flutter_better_united/widgets/friend_poule_icon_with_name.dart';
import 'package:flutter_better_united/widgets/league_icon.dart';
import 'package:flutter_better_united/widgets/primary_button.dart';
import 'package:provider/provider.dart';

import '../../data/enum/poule_type.dart';
import '../../widgets/avatar_widget.dart';
import '../../widgets/full_screen_base_dialog.dart';
import '../../widgets/rank_widget.dart';
import '../../widgets/user_coins.dart';
import '../profile/my_profile_page.dart';
import '../shop/user_provider.dart';

class PouleRankDialog extends StatefulWidget {
  const PouleRankDialog({
    Key? key,
    required this.pouleReward,
  }) : super(key: key);

  final PouleReward pouleReward;

  @override
  State<PouleRankDialog> createState() => _PouleRankDialogState();
}

class _PouleRankDialogState extends State<PouleRankDialog> {
  @override
  void initState() {
    super.initState();

    int? addedCoins = widget.pouleReward.prize;
    if (addedCoins != null) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        context.read<UserProvider>().addUserCoins(addedCoins);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isUserWon = widget.pouleReward.isUserWon;

    return WillPopScope(
      onWillPop: () async {
        _acknowledgeReward(context);
        return false;
      },
      child: Stack(
        children: [
          FullscreenBaseDialog(
            withConfetti: isUserWon,
            icon: widget.pouleReward.pouleType == PouleType.public
                ? LeagueIconWithPlaceholder(
                    logoUrl: widget.pouleReward.pouleIconUrl)
                : widget.pouleReward.pouleType == PouleType.friend
                    ? FriendPouleIconWithName(
                        name: widget.pouleReward.pouleName ?? '',
                      )
                    : const SizedBox(),
            withAnimation: true,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        SingleChildScrollView(
                          padding: const EdgeInsets.only(top: 62),
                          child: Column(
                            children: [
                              /// Defined as percentage of width because the size of the margin needs to scale along with the icon size, which is calculated based on context.width.
                              SizedBox(height: 0.03 * context.width),
                              Text(
                                (isUserWon
                                        ? "congratulations"
                                        : "betterNextTime")
                                    .tr()
                                    .toUpperCase(),
                                style: context.titleH1White.copyWith(
                                  shadows: [
                                    Shadow(
                                      color: Colors.black.withOpacity(0.5),
                                      offset: const Offset(0, 2),
                                      blurRadius: 16,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              isUserWon
                                  ? RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        text:
                                            "youHave".tr().toUpperCase() + " ",
                                        style: context.labelBold
                                            .copyWith(color: Colors.white),
                                        children: [
                                          TextSpan(
                                            text: "ranked".tr(args: [
                                              widget.pouleReward.userRank
                                                  .toString()
                                            ]).toUpperCase(),
                                            style: context.labelBold.copyWith(
                                              color: AppColors.primary,
                                            ),
                                          ),
                                          TextSpan(
                                            text: " " +
                                                "inThe".tr().toUpperCase() +
                                                "  ",
                                            style: context.labelBoldItalic,
                                          ),
                                          TextSpan(
                                            text: widget.pouleReward.pouleName
                                                ?.toUpperCase(),
                                            style: context.labelBold.copyWith(
                                              color: AppColors.primary,
                                            ),
                                          ),
                                          const TextSpan(
                                            text: ".",
                                          ),
                                        ],
                                      ),
                                    )
                                  : RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        text:
                                            "thereIs".tr().toUpperCase() + " ",
                                        style: context.labelBold
                                            .copyWith(color: Colors.white),
                                        children: [
                                          TextSpan(
                                            text: "noWinner".tr(args: [
                                              widget.pouleReward.userRank
                                                  .toString()
                                            ]).toUpperCase(),
                                            style: context.labelBold.copyWith(
                                              color: AppColors.primary,
                                            ),
                                          ),
                                          TextSpan(
                                            text: " " +
                                                "inThe".tr().toUpperCase() +
                                                "  ",
                                            style: context.labelBoldItalic,
                                          ),
                                          TextSpan(
                                            text: widget.pouleReward.pouleName
                                                ?.toUpperCase(),
                                            style: context.labelBold.copyWith(
                                              color: AppColors.primary,
                                            ),
                                          ),
                                          const TextSpan(
                                            text: ".",
                                          ),
                                        ],
                                      ),
                                    ),
                              const SizedBox(
                                height: 32,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: _RankWidget(
                                  rank: widget.pouleReward.userRank,
                                  isWon: isUserWon,
                                  profileUrl:
                                      widget.pouleReward.userProfilePictureUrl,
                                  onProfileTap: () {
                                    Navigator.of(context)
                                        .push(MyProfilePage.route());
                                  },
                                  drawShadow: true,
                                  name: widget.pouleReward.userNickname,
                                  levelName: widget.pouleReward.userRewardTitle,
                                  points: widget.pouleReward.userPointsEarned,
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Text(
                                "rewards".tr().toUpperCase(),
                                style: context.titleH2
                                    .copyWith(color: Colors.white),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 16),
                                decoration: const BoxDecoration(
                                  color: Color(0xff1D1D1D),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "sharedPredictionsTitle"
                                                  .tr()
                                                  .toUpperCase(),
                                              style: context.labelBold.copyWith(
                                                  color: Colors.white),
                                            ),
                                            Text(
                                                "SharedWon".tr(args: [
                                                  widget.pouleReward
                                                      .userTipCountTotal
                                                      .toString(),
                                                  widget.pouleReward
                                                      .userTipCountWon
                                                      .toString()
                                                ]),
                                                style: context.bodyBold
                                                    .copyWith(
                                                        color:
                                                            AppColors.primary))
                                          ],
                                        ),
                                        Text(
                                            "expReward".tr(args: [
                                              widget.pouleReward.userExpEarned
                                                  .toString()
                                            ]),
                                            style: context.bodyBold.copyWith(
                                                color: AppColors.primary))
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    LayoutBuilder(
                                        builder: (context, constraints) {
                                      return SizedBox(
                                          width: constraints.maxWidth * 0.8,
                                          child:
                                              const UserXpProgressIndicator());
                                    }),
                                    isUserWon
                                        ? _WinningPouleCoins(
                                            reward: widget.pouleReward)
                                        : const SizedBox()
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: FixedButton(
                                iconData: BetterUnited.remove,
                                onTap: () {
                                  _acknowledgeReward(context);
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: PrimaryButton(
                        onPressed: () {
                          _acknowledgeReward(context);
                        },
                        text: "getReward".tr()),
                  )
                ],
              ),
            ),
          ),
          isUserWon
              ? const Positioned(
                  right: 20,
                  child: UserCoins(),
                )
              : const SizedBox()
        ],
      ),
    );
  }

  _acknowledgeReward(BuildContext context) async {
    final userProvider = context.read<UserProvider>();
    await userProvider.acknowledgePouleReward(
        widget.pouleReward.pouleId, widget.pouleReward.pouleType);
    await userProvider.syncUserProfile();
    context.pop();
  }
}

class _WinningPouleCoins extends StatelessWidget {
  const _WinningPouleCoins({required this.reward});

  final PouleReward reward;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: AutoSizeText(
                  "winningPoule".tr().toUpperCase(),
                  maxLines: 1,
                  minFontSize: 1,
                  style: context.labelBold.copyWith(color: Colors.white),
                ),
              ),
              Row(
                children: [
                  Image.asset(
                    "assets/icons/ic_coins.png",
                    height: 24,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  AutoSizeText(
                    reward.prize.toString(),
                    style: context.bodyBold.copyWith(color: AppColors.primary),
                    maxLines: 1,
                    minFontSize: 1,
                  ),
                ],
              )
            ],
          ),
          reward.otherUsersWithSameRank > 0
              ? Text("sharedRank".tr(args: [
                  reward.otherUsersWithSameRank.toString(),
                  reward.userRank.toString()
                ]))
              : const SizedBox()
        ],
      ),
    );
  }
}

class _RankWidget extends StatelessWidget {
  const _RankWidget({
    Key? key,
    required this.name,
    required this.levelName,
    required this.points,
    this.onProfileTap,
    this.profileUrl,
    this.drawShadow = false,
    this.rank,
    required this.isWon,
  }) : super(key: key);
  final String name;
  final String? profileUrl;
  final String levelName;
  final int points;

  final int? rank;

  final Function? onProfileTap;
  final bool drawShadow;

  static const double avatarSize = 52.0;
  final bool isWon;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0x3D9AE343),
            spreadRadius: 1,
            blurRadius: 24,
            offset: Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: CustomPaint(
          painter: BackgroundCustomPainter(
              isWon ? _getRankBackgroundColor(rank) : const Color(0xff505050)),
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
                                          isRankVisible: false,
                                          level: 1,
                                          profileUrl: profileUrl,
                                          shadowColor: isWon
                                              ? _getShadowColor(rank)
                                              : const Color(0xffFFF396)
                                                  .withOpacity(0.5),
                                          gradient: isWon
                                              ? _getRankGradient(rank)
                                              : null,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            isWon
                                ? Transform.translate(
                                    offset: const Offset(
                                        -avatarSize * 0.1, avatarSize * 0.1),
                                    child: ConstrainedBox(
                                      constraints: const BoxConstraints(
                                          maxHeight: 17,
                                          minWidth: 20,
                                          minHeight: 17),
                                      child: RankWidget(
                                        text: rank == null
                                            ? " - "
                                            : rank.toString(),
                                        linearGradient: _getBadgeGradient(rank),
                                      ),
                                    ),
                                  )
                                : const SizedBox()
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
                                  name.toUpperCase(),
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
                                isWon
                                    ? RichText(
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
                                                ).copyWith(
                                                    color: AppColors.primary)),
                                            const TextSpan(
                                              text: " ",
                                            ),
                                            TextSpan(
                                              text: "pointArgs".plural(points),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Text(
                                        "lose".tr().toUpperCase(),
                                        style: context.labelMedium?.copyWith(
                                            shadows: [
                                              Shadow(
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                                offset: const Offset(0, 2),
                                                blurRadius: 16,
                                              ),
                                            ],
                                            color: AppColors.textError,
                                            fontStyle: FontStyle.italic),
                                      )
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

  LinearGradient _getRankGradient(int? rank) {
    switch (rank) {
      case 1:
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xffFFF6C6),
            Color(0xffFFD703),
            Color(0xffFFAE01),
          ],
        );
      case 2:
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xffD7D7D7), Color(0xffBBBBBB), Color(0xff979797)],
        );
      case 3:
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xffF98B39), Color(0xffE57D32), Color(0xffBB5821)],
        );
      default:
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff838383),
            Color(0xff4C4C4C),
          ],
        );
    }
  }

  Color _getShadowColor(int? rank) {
    switch (rank) {
      case 1:
        return const Color(0x80FFF396);
      case 2:
        return const Color(0x80C1C1C1);
      case 3:
        return const Color(0xffFD8E3A);
      default:
        return Colors.transparent;
    }
  }

  LinearGradient _getBadgeGradient(int? rank) {
    switch (rank) {
      case 1:
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xffFFE93B), Color(0xffFFCF1B)],
        );
      case 2:
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xffD6D6D6),
            Color(0xffB9B9B9),
          ],
        );
      case 3:
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xffFF903B),
            Color(0xffC65F24),
          ],
        );
      default:
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff353535),
            Color(0xff353535),
          ],
        );
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
