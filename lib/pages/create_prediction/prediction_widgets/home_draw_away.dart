import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_better_united/data/repo/league_repository.dart';

import 'commons.dart';

class HomeDrawAwayData extends OddData {
  final String homeTeamName;
  final String awayTeamName;
  final int homeTeamPoints;
  final int drawPoints;
  final int awayTeamPoints;
  final int homeTeamBetId;
  final int awayTeamBetId;
  final int drawBetId;
  final String homeHint;
  final String awayHint;
  final String drawHint;

  HomeDrawAwayData(
    super.id,
    super.isFolded,
    super.isEnabled, {
    required this.homeTeamName,
    required this.awayTeamName,
    required this.homeTeamPoints,
    required this.drawPoints,
    required this.awayTeamPoints,
    required this.homeTeamBetId,
    required this.awayTeamBetId,
    required this.drawBetId,
    required this.homeHint,
    required this.awayHint,
    required this.drawHint,
  });
}

typedef OnBetTap = void Function(int points, int betId, String hint);

class HomeDrawAwayWidget extends StatelessWidget {
  const HomeDrawAwayWidget({
    super.key,
    required this.data,
    required this.onBetTap,
  });

  final HomeDrawAwayData data;
  final OnBetTap onBetTap;

  @override
  Widget build(BuildContext context) {
    return PredictionContainer(
        isFolded: data.isFolded,
        isEnabled: data.isEnabled,
        title: "homeDrawAway".tr(),
        children: [
          GestureDetector(
            onTap: () => onBetTap(
              data.homeTeamPoints,
              data.homeTeamBetId,
              data.homeHint,
            ),
            child: PointsCard(
              points: data.homeTeamPoints,
              text: data.homeTeamName,
            ),
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () =>
                onBetTap(data.drawPoints, data.drawBetId, data.drawHint),
            child: PointsCard(
              points: data.drawPoints,
              text: "draw".tr(),
            ),
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () => onBetTap(
                data.awayTeamPoints, data.awayTeamBetId, data.awayHint),
            child: PointsCard(
              points: data.awayTeamPoints,
              text: data.awayTeamName,
            ),
          ),
        ]);
  }
}
