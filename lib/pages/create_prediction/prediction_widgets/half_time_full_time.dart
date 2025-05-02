import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/data/repo/league_repository.dart';

import 'commons.dart';
import 'handicap.dart';
import 'home_draw_away.dart';

class HalfTimeFullTimeData extends OddData {
  final List<GroupedBets> bets;

  HalfTimeFullTimeData(super.id, super.isFolded, super.isEnabled, this.bets);
}

class HalfTimeFullTimeWidget extends StatelessWidget {
  final HalfTimeFullTimeData data;
  final OnBetTap onBetTap;

  const HalfTimeFullTimeWidget({
    super.key,
    required this.data,
    required this.onBetTap,
  });

  @override
  Widget build(BuildContext context) {
    return PredictionContainer(
        title: "halfTimeFullTime".tr(),
        isFolded: data.isFolded,
        isEnabled: data.isEnabled,
        children: [
          ListView.separated(
            separatorBuilder: (context, index) {
              return const SizedBox(height: 24);
            },
            physics: const NeverScrollableScrollPhysics(),
            itemCount: data.bets.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final group = data.bets[index];
              return GroupedList(bets: group, onBetTap: onBetTap);
            },
          )
        ]);
  }
}
