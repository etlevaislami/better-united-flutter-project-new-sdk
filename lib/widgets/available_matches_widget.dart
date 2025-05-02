import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/constants/extended_theme.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

import '../data/model/football_match.dart';
import '../figma/colors.dart';
import 'match_card.dart';

class AvailableMatchesWidget extends StatelessWidget {
  const AvailableMatchesWidget({super.key, required this.matches, this.showTitle = true});

  final List<FootballMatch> matches;
  final bool showTitle;

  @override
  Widget build(BuildContext context) {
    return matches.isNotEmpty
        ? Column(
            children: [
              Visibility(
                visible: showTitle,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "publicPouleAvailableMatches".tr().toUpperCase(),
                      style: context.bodyBold.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              matches.length == 1
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: MatchCard(
                        foregroundColor: AppColors.background,
                        matchDate: matches.first.startsAt,
                        homeTeam: matches.first.homeTeam,
                        awayTeam: matches.first.awayTeam,
                      ),
                    )
                  : FlutterCarousel.builder(
                      itemCount: matches.length,
                      itemBuilder: (context, index, realIndex) {
                        final match = matches[index];
                        return MatchCard(
                          foregroundColor: AppColors.background,
                          matchDate: match.startsAt,
                          homeTeam: match.homeTeam,
                          awayTeam: match.awayTeam,
                        );
                      },
                      options: CarouselOptions(
                        disableCenter: false,
                        initialPage: 0,
                        indicatorMargin: 8,
                        floatingIndicator: false,
                        height: 100,
                        viewportFraction: 0.8,
                        showIndicator: true,
                        enlargeCenterPage: true,
                        slideIndicator: const CircularSlideIndicator(
                            itemSpacing: 12,
                            indicatorRadius: 4,
                            currentIndicatorColor: AppColors.primary,
                            indicatorBackgroundColor:
                                AppColors.buttonInnactive),
                      ),
                    )
            ],
          )
        : const SizedBox();
  }
}
