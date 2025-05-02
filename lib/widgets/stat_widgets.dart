import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/constants/extended_theme.dart';
import 'package:flutter_better_united/figma/dimensions.dart';
import 'package:flutter_better_united/util/extensions/string_extension.dart';
import 'package:flutter_better_united/widgets/rounded_container.dart';
import 'package:flutter_better_united/widgets/team_icon.dart';

import '../data/model/team.dart';
import '../figma/colors.dart';

class PointsEarned extends StatelessWidget {
  const PointsEarned({super.key, required this.points, required this.coins});

  final int points;
  final int coins;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(8),
      ),
      height: 83,
      child: Row(
        children: [
          Expanded(
            child: _Item(
              title: "pointsEarned".plural(points),
              value: points.toDouble(),
            ),
          ),
          const _Divider(),
          Expanded(
            child: _Item(
              title: "coinsEarned".plural(coins),
              value: coins.toDouble(),
            ),
          )
        ],
      ),
    );
  }
}

class PouleStats extends StatelessWidget {
  const PouleStats(
      {super.key,
      required this.joinedPoules,
      required this.publicPouleWins,
      required this.friendPouleWins});

  final int joinedPoules;
  final int publicPouleWins;
  final int friendPouleWins;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppDimensions.profilePagePouleStatsWidgetHeight,
      child: Row(
        children: [
          Expanded(
            child: RoundedContainer(
              backgroundColor: AppColors.background,
              radius: 8,
              child: Align(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Transform.translate(
                      offset: const Offset(2, 0),
                      child: Image.asset(
                        "assets/icons/ic_public_league_badge.png",
                        height: 48,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    _Item(
                      title: "pouleJoinedArgs".plural(joinedPoules),
                      value: joinedPoules.toDouble(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: _StatCard(
                    publicPouleWins,
                    "publicPoulesWins".plural(publicPouleWins),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Expanded(
                  child: _StatCard(
                    friendPouleWins,
                    "friendPoulesWins".plural(friendPouleWins),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class PredictionOverview extends StatelessWidget {
  const PredictionOverview(
      {super.key, required this.predictions, required this.averageWinPoints});

  final int predictions;
  final double averageWinPoints;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              color: AppColors.secondary,
              width: double.infinity,
              child: Text(
                "predictionOverview".tr().toUpperCase(),
                textAlign: TextAlign.center,
                style: context.bodyBold.copyWith(color: Colors.white),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              height: 70,
              color: AppColors.background,
              child: Row(
                children: [
                  Expanded(
                    child: _Item(
                      title: "sharedPredictions".plural(predictions),
                      value: predictions.toDouble(),
                    ),
                  ),
                  const _Divider(),
                  Expanded(
                    child: _Item(
                      title: "averageWinPoints".tr(),
                      value: averageWinPoints,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PredictionStatWidget extends StatelessWidget {
  const PredictionStatWidget(
      {Key? key,
      required this.totalPredictions,
      required this.wonPredictions,
      required this.lostPredictions,
      required this.title})
      : super(key: key);
  final int totalPredictions;
  final int wonPredictions;
  final int lostPredictions;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              color: const Color(0xff535353),
              width: double.infinity,
              child: Text(
                title.toUpperCase(),
                textAlign: TextAlign.center,
                style: context.bodyBold.copyWith(color: Colors.white),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              height: 70,
              color: const Color(0xff353535),
              child: Row(
                children: [
                  Expanded(
                    child: _Item(
                      title: "totalPredictions".tr(),
                      value: totalPredictions.toDouble(),
                    ),
                  ),
                  const _Divider(),
                  Expanded(
                    child: _Item(
                      title: "wonPredictions".tr(),
                      value: wonPredictions.toDouble(),
                    ),
                  ),
                  const _Divider(),
                  Expanded(
                    child: _Item(
                      title: "lostPredictions".tr(),
                      value: lostPredictions.toDouble(),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({Key? key, required this.title, required this.value})
      : super(key: key);
  final String title;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (bounds) => const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xffCAFF8B), Color(0xff9AE343)],
            ).createShader(
              Rect.fromLTWH(0, 0, bounds.width, bounds.height),
            ),
            child: Text(
              //intentionally left spaces around the value
              " ${value.toString().removeTrailingZeros()} ",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,

              style: const TextStyle(
                fontFamily: "Montserrat",
                fontSize: 28,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          AutoSizeText(
            title,
            maxLines: 1,
            minFontSize: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard(this.value, this.title);

  final int value;
  final String title;

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      backgroundColor: AppColors.background,
      radius: 8,
      child: Align(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (bounds) => const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xffCAFF8B), Color(0xff9AE343)],
              ).createShader(
                Rect.fromLTWH(0, 0, bounds.width, bounds.height),
              ),
              child: Text(
                //intentionally left spaces around the value
                " ${value.toString()} ",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontFamily: "Montserrat",
                  fontSize: 28,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            AutoSizeText(
              title,
              maxLines: 1,
              minFontSize: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      width: 1,
      color: const Color(0xff535353),
    );
  }
}

class FavoriteClubs extends StatelessWidget {
  const FavoriteClubs({
    super.key,
    required this.favoriteTeams,
  });

  final List<Team> favoriteTeams;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(8),
      ),
      height: 83,
      child: Row(
        children: [
          Expanded(
            child: Text(
              "favoriteClubs".tr(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: _Divider(),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: ListView.separated(
                itemCount: favoriteTeams.length,
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    width: 12,
                  );
                },
                itemBuilder: (context, index) {
                  final team = favoriteTeams[index];
                  return TeamIcon(
                    logoUrl: team.logoUrl,
                    invertColor: true,
                    height: 32,
                  );
                },
                padding: const EdgeInsets.symmetric(horizontal: 28),
                scrollDirection: Axis.horizontal,
              ),
            ),
          )
        ],
      ),
    );
  }
}
