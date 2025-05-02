import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import 'commons.dart';

class HalfEndResult extends StatelessWidget {
  final String homeTeam;
  final String awayTeam;
  final Function onSelected;

  const HalfEndResult(
      {super.key,
      required this.homeTeam,
      required this.awayTeam,
      required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return PredictionContainer(
      isFolded: false,
      isEnabled: true,
      title: "halfEndResult".tr(),
      children: [
        GestureDetector(
            onTap: () => onSelected(),
            child: PointsCard(text: "$homeTeam / $homeTeam", points: 12)),
        const SizedBox(
          height: 12,
        ),
        GestureDetector(
            onTap: () => onSelected(),
            child: PointsCard(text: "$homeTeam / ${"draw".tr()}", points: 12)),
        const SizedBox(
          height: 12,
        ),
        GestureDetector(
            onTap: () => onSelected(),
            child: PointsCard(text: "$homeTeam / $awayTeam", points: 12)),
        const SizedBox(
          height: 24,
        ),
        GestureDetector(
            onTap: () => onSelected(),
            child: PointsCard(text: "${"draw".tr()} / $awayTeam", points: 12)),
        const SizedBox(
          height: 12,
        ),
        GestureDetector(
            onTap: () => onSelected(),
            child: PointsCard(
                text: "${"draw".tr()} / ${"draw".tr()}", points: 12)),
        const SizedBox(
          height: 12,
        ),
        GestureDetector(
            onTap: () => onSelected(),
            child: PointsCard(text: "${"draw".tr()} / $homeTeam", points: 12)),
        const SizedBox(
          height: 24,
        ),
        GestureDetector(
          onTap: () => onSelected(),
          child: PointsCard(text: "$awayTeam / $homeTeam", points: 12),
        ),
        const SizedBox(
          height: 12,
        ),
        GestureDetector(
          onTap: () => onSelected(),
          child: PointsCard(text: "$awayTeam / ${"draw".tr()}", points: 12),
        ),
        const SizedBox(
          height: 12,
        ),
        GestureDetector(
          onTap: () => onSelected(),
          child: PointsCard(text: "$awayTeam / $awayTeam", points: 12),
        ),
      ],
    );
  }
}
