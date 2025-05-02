import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import 'commons.dart';

class HandicapWidget extends StatefulWidget {
  const HandicapWidget(
      {super.key,
      required this.homeTeam,
      required this.awayTeam,
      required this.onSelected});

  final TeamWithPlayersBet homeTeam;
  final TeamWithPlayersBet awayTeam;
  final Function(String, int) onSelected;

  @override
  State<HandicapWidget> createState() => _HandicapWidgetState();
}

class _HandicapWidgetState extends State<HandicapWidget> {
  late final list = [widget.homeTeam, widget.awayTeam];
  late TeamWithPlayersBet selectedTeam = list.first;

  @override
  Widget build(BuildContext context) {
    return PredictionContainer(
      isFolded: false,
      isEnabled: true,
      title: "toScore".tr(),
      children: [
        TeamWithPlayersBetWidget(
            onSelected: widget.onSelected,
            homeTeam: widget.homeTeam,
            awayTeam: widget.awayTeam)
      ],
    );
  }
}
