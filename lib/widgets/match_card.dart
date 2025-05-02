import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/constants/extended_theme.dart';
import 'package:flutter_better_united/data/model/team.dart';
import 'package:flutter_better_united/figma/colors.dart';
import 'package:flutter_better_united/widgets/team_icon.dart';

import '../util/date_util.dart';
import 'background_container.dart';

class MatchCard extends StatelessWidget {
  const MatchCard({
    super.key,
    required this.homeTeam,
    required this.awayTeam,
    required this.matchDate,
    this.foregroundColor = const Color(0xff353535),
  });

  final Team homeTeam;
  final Team awayTeam;
  final DateTime matchDate;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 73,
      child: BackgroundContainer(
        gradientEndColor: AppColors.primary,
        leadingChild: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                matchDate.isBefore(DateTime.now())
                    ? "ended".tr()
                    : dayMonthYearFormatter.format(matchDate),
                style: context.labelBold.copyWith(color: Colors.white),
              ),
              if (matchDate.isAfter(DateTime.now()))
                Text(
                  hoursMinutesFormatter.format(matchDate),
                  style: const TextStyle(
                      fontWeight: FontWeight.w400, fontSize: 12),
                )
            ],
          ),
        ),
        trailingChild: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _TeamRow(
                name: homeTeam.name,
                logoUrl: homeTeam.logoUrl,
              ),
              const SizedBox(
                height: 8,
              ),
              _TeamRow(
                name: awayTeam.name,
                logoUrl: awayTeam.logoUrl,
              ),
            ],
          ),
        ),
        widthRatio: 0.4,
        withShadow: true,
        isInclinationReversed: true,
        foregroundColor: foregroundColor,
        backgroundColor: const Color(0xff535353),
      ),
    );
  }
}

class _TeamRow extends StatelessWidget {
  final String? logoUrl;
  final String name;

  const _TeamRow({
    required this.logoUrl,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TeamIcon(height: 16, invertColor: true, logoUrl: logoUrl),
        const SizedBox(
          width: 11,
        ),
        Expanded(
            child: Text(
          name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: context.labelBold.copyWith(color: Colors.white),
        ))
      ],
    );
  }
}
