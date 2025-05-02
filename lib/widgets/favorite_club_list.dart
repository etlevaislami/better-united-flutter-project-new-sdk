import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import '../data/model/football_match.dart';
import 'match_card.dart';

class FavoriteClubsList extends StatelessWidget {
  final ScrollController controller;
  final List<FootballMatch> matches;
  final GestureTapCallback? onTap;

  const FavoriteClubsList(
      {super.key, required this.controller, required this.matches, this.onTap});

  @override
  Widget build(BuildContext context) {
    return matches.isEmpty
        ? const SizedBox()
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 32,
                          width: 32,
                          child: Image.asset("assets/icons/ic_favorite.png"),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Text(
                            "yourFavoriteClubs".tr(),
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ListView.separated(
                        controller: controller,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final match = matches[index];
                          return GestureDetector(
                            onTap: onTap,
                            child: MatchCard(
                                matchDate: match.startsAt,
                                homeTeam: match.homeTeam,
                                awayTeam: match.awayTeam),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 16,
                          );
                        },
                        itemCount: matches.length),
                  ],
                ),
              ),
            ],
          );
  }
}
