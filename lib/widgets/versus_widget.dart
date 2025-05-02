import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/widgets/team_icon.dart';

import '../constants/app_colors.dart';
import '../data/model/team.dart';
import '../util/date_util.dart';

class VersusWidget extends StatelessWidget {
  const VersusWidget({
    Key? key,
    required this.homeTeam,
    required this.awayTeam,
    required this.startsAt,
  }) : super(key: key);

  final Team homeTeam;
  final Team awayTeam;
  final DateTime startsAt;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 70),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    TeamIcon(
                      height: 53,
                      logoUrl: homeTeam.logoUrl,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      homeTeam.name,
                      style: context.titleLarge,
                      textAlign: TextAlign.center,
                    ).fontSize(14)
                  ],
                ),
              ),
              Text(
                "vs",
                style: context.titleLarge,
                textAlign: TextAlign.center,
              ),
              Expanded(
                child: Column(
                  children: [
                    TeamIcon(
                      height: 53,
                      logoUrl: awayTeam.logoUrl,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      awayTeam.name,
                      style: context.titleLarge,
                      textAlign: TextAlign.center,
                    ).fontSize(14)
                  ],
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                margin:
                    const EdgeInsets.symmetric(horizontal: 70, vertical: 20),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: AppColors.whiteout,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Text(
                  dayMonthYearHoursFormatter.format(startsAt),
                ).fontSize(11).textColor(AppColors.lunarBase),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
