import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/constants/extended_theme.dart';
import 'package:flutter_better_united/data/repo/league_repository.dart';

import 'commons.dart';
import 'home_draw_away.dart';

class HandicapData extends OddData {
  final List<GroupedBets> bets;

  HandicapData(super.id, super.isFolded, super.isEnabled, this.bets);
}

class BetData {
  final int betId;
  final int points;
  final String text;
  final String hint;

  BetData(
      {required this.betId,
      required this.points,
      required this.text,
      required this.hint});
}

class GroupedBets {
  final String? groupName;
  final List<BetData> bets;

  GroupedBets({this.groupName, required this.bets});
}

class HandicapWidget extends StatelessWidget {
  final HandicapData data;
  final OnBetTap onBetTap;

  const HandicapWidget({
    super.key,
    required this.data,
    required this.onBetTap,
  });

  @override
  Widget build(BuildContext context) {
    return PredictionContainer(
        title: "europeanHandicap".tr(),
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
              return GroupedList(
                bets: group,
                onBetTap: onBetTap,
              );
            },
          )
        ]);
  }
}

class GroupedList extends StatelessWidget {
  const GroupedList({Key? key, required this.bets, required this.onBetTap})
      : super(key: key);
  final GroupedBets bets;
  final OnBetTap onBetTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        bets.groupName != null
            ? Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Text(
                    bets.groupName!,
                    textAlign: TextAlign.start,
                    style: context.labelBold.copyWith(color: Colors.white),
                  ),
                ),
              )
            : const SizedBox(),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: bets.bets.length,
          separatorBuilder: (context, index) {
            return const SizedBox(height: 12);
          },
          itemBuilder: (context, index) {
            final bet = bets.bets[index];
            return GestureDetector(
              onTap: () => onBetTap(bet.points, bet.betId, bet.hint),
              child: PointsCard(
                points: bet.points,
                text: bet.text,
              ),
            );
          },
        ),
      ],
    );
  }
}
