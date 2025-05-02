import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import '../../../data/repo/league_repository.dart';
import 'commons.dart';
import 'home_draw_away.dart';

class BooleanOddData extends OddData {
  final int yesBetId;
  final int noBetId;
  final int yesPoints;
  final int noPoints;
  final String yesHint;
  final String noHint;

  BooleanOddData(super.id, super.isFolded, super.isEnabled,
      {required this.yesBetId,
      required this.noBetId,
      required this.yesPoints,
      required this.noPoints,
      required this.yesHint,
      required this.noHint});
}

class BothTeamToScore extends StatelessWidget {
  const BothTeamToScore({
    super.key,
    required this.data,
    required this.onBetTap,
  });

  final OnBetTap onBetTap;
  final BooleanOddData data;

  @override
  Widget build(BuildContext context) {
    return PredictionContainer(
      isFolded: data.isFolded,
      isEnabled: data.isEnabled,
      title: "bothTeamsToScore".tr().toUpperCase(),
      children: [
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () =>
                    onBetTap(data.yesPoints, data.yesBetId, data.yesHint),
                child: PointsCard(
                  text: "yes".tr(),
                  points: data.yesPoints,
                  widthRatio: 0.6,
                ),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => onBetTap(data.noPoints, data.noBetId, data.noHint),
                child: PointsCard(
                    text: "no".tr(), points: data.noPoints, widthRatio: 0.6),
              ),
            ),
          ],
        )
      ],
    );
  }
}
