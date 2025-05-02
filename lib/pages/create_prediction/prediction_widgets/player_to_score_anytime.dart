import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_better_united/pages/create_prediction/prediction_widgets/handicap.dart';

import '../../../data/repo/league_repository.dart';
import 'commons.dart';
import 'home_draw_away.dart';

class PlayerToScoreAnytimeData extends OddData {
  final List<BetData> bets;

  PlayerToScoreAnytimeData(
      super.id, super.isFolded, super.isEnabled, this.bets);
}

class PlayerToScoreAnytimeWidget extends StatelessWidget {
  const PlayerToScoreAnytimeWidget(
      {Key? key, required this.data, required this.onBetTap})
      : super(key: key);
  final PlayerToScoreAnytimeData data;
  final OnBetTap onBetTap;

  @override
  Widget build(BuildContext context) {
    return PredictionContainer(
      isFolded: data.isFolded,
      isEnabled: data.isEnabled,
      title: "playerToScoreAnytime".tr(),
      children: [
        PlayersBetWidget(
          data: data.bets,
          onBetTap: onBetTap,
        )
      ],
    );
  }
}
