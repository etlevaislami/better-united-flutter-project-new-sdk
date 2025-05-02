import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import 'commons.dart';

class ToScoreWidget extends StatefulWidget {
  const ToScoreWidget(
      {super.key,
      required this.homeTeam,
      required this.awayTeam,
      required this.onSelected});

  final TeamWithPlayersBet homeTeam;
  final TeamWithPlayersBet awayTeam;
  final Function(String, int) onSelected;

  @override
  State<ToScoreWidget> createState() => _ToScoreWidgetState();
}

class _ToScoreWidgetState extends State<ToScoreWidget> {
  late final list = [widget.homeTeam, widget.awayTeam];
  late TeamWithPlayersBet selectedTeam = list.first;
  @override
  Widget build(BuildContext context) {
    return PredictionContainer(
      title: "toScore".tr(),
      isEnabled: false,
      isFolded: false,
      children: [
        TeamWithPlayersBetWidget(
            onSelected: widget.onSelected,
            homeTeam: widget.homeTeam,
            awayTeam: widget.awayTeam)
      ],
    );
  }
}
