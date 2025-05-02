import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import 'commons.dart';

class ToGiveAssist extends StatelessWidget {
  const ToGiveAssist(
      {super.key,
      required this.homeTeam,
      required this.awayTeam,
      required this.onSelected});

  final TeamWithPlayersBet homeTeam;
  final TeamWithPlayersBet awayTeam;
  final Function(String, int) onSelected;

  @override
  Widget build(BuildContext context) {
    return PredictionContainer(
      isFolded: false,
      isEnabled: true,
      title: "toGiveAnAssist".tr().toUpperCase(),
      children: [
        TeamWithPlayersBetWidget(
          homeTeam: homeTeam,
          awayTeam: awayTeam,
          onSelected: onSelected,
        )
      ],
    );
  }
}
