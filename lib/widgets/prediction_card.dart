import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/constants/extended_theme.dart';
import 'package:flutter_better_united/data/enum/tip_settlement.dart';
import 'package:flutter_better_united/widgets/prediction_result_card.dart';
import 'package:flutter_better_united/widgets/team_icon.dart';
import 'package:timeago/timeago.dart' as time_ago;

import '../data/model/team.dart';
import '../util/date_util.dart';
import 'avatar_widget.dart';

class PredictionCard extends StatelessWidget {
  const PredictionCard(
      {Key? key,
      required this.isConnectedUser,
      required this.name,
      required this.rank,
      required this.levelName,
      required this.pouleName,
      required this.photoUrl,
      this.createdAt,
      required this.odd,
      required this.points,
      required this.homeTeam,
      required this.awayTeam,
      required this.leagueName,
      this.onProfileTap,
      required this.startsAt,
      required this.isVoided,
      required this.tipSettlement})
      : super(key: key);

  final bool isConnectedUser;
  final String name;
  final int rank;
  final String levelName;
  final String pouleName;
  final String? photoUrl;
  final DateTime? createdAt;
  final String odd;
  final int points;
  final Team homeTeam;
  final Team awayTeam;
  final String leagueName;
  final GestureTapCallback? onProfileTap;
  final DateTime startsAt;
  final bool isVoided;
  final TipSettlement tipSettlement;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 420,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            color: const Color(0xff292929),
            child: Row(
              children: [
                GestureDetector(
                  onTap: onProfileTap,
                  child: AvatarWidget(
                    level: rank,
                    isFollowButtonVisible: false,
                    profileUrl: photoUrl,
                    gradient: _getRankGradient(rank),
                    shadowColor: const Color(0xffFFA800).withOpacity(0.5),
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
                            isConnectedUser ? "you".tr() : name,
                            style: context.bodyBold.copyWith(
                              color: Colors.white,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          createdAt == null
                              ? const SizedBox()
                              : Text(
                                  time_ago.format(createdAt!),
                                  style: context.labelRegular
                                      .copyWith(color: Colors.white),
                                )
                        ],
                      ),
                      Text(
                        levelName,
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
              ],
            ),
          ),
          Container(
            height: 238,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/football-field.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 11.0, horizontal: 24),
                    child: Text(
                      "$pouleName - $leagueName",
                      style: context.labelRegular.copyWith(color: Colors.white),
                    ),
                  ),
                ),
                Align(
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TeamIcon(
                              height: 53,
                              logoUrl: homeTeam.logoUrl,
                              invertColor: true,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              homeTeam.name,
                              style: context.bodyBold
                                  .copyWith(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                      Text(
                        "VS",
                        style: context.titleH1White,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TeamIcon(
                              height: 53,
                              logoUrl: awayTeam.logoUrl,
                              invertColor: true,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(awayTeam.name,
                                style: context.bodyBold
                                    .copyWith(color: Colors.white))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        LayoutBuilder(builder: (context, constraints) {
                          return Container(
                            width: constraints.maxWidth * 0.5,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 24),
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              color: Color(0xff353535),
                              borderRadius: BorderRadius.all(
                                Radius.circular(32),
                              ),
                            ),
                            child: Text(
                                dayMonthYearHoursFormatter.format(startsAt),
                                style: context.labelRegular.copyWith(
                                  color: Colors.white,
                                )),
                          );
                        }),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: PredictionResultCard(
                isVoided: isVoided,
                odd: odd,
                points: points,
                tipSettlement: tipSettlement,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  LinearGradient _getRankGradient(int rank) {
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
}
