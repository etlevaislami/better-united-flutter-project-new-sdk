import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_better_united/pages/create_prediction/prediction_widgets/handicap.dart';

import '../../../data/repo/league_repository.dart';
import 'commons.dart';
import 'home_draw_away.dart';

class FirstPlayerToScoreData extends OddData {
  final List<BetData> bets;

  FirstPlayerToScoreData(super.id, super.isFolded, super.isEnabled, this.bets);
}

class FirstPlayerToScoreWidget extends StatelessWidget {
  const FirstPlayerToScoreWidget(
      {Key? key, required this.data, required this.onBetTap})
      : super(key: key);
  final FirstPlayerToScoreData data;
  final OnBetTap onBetTap;

  @override
  Widget build(BuildContext context) {
    return PredictionContainer(
      title: "firstPlayerToScore".tr(),
      isFolded: true,
      isEnabled: data.isEnabled,
      children: [
        PlayersBetWidget(
          data: data.bets,
          onBetTap: onBetTap,
        )
      ],
    );
  }
}
