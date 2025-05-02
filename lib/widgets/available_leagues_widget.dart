import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/widgets/detail_header.dart';

import '../data/model/league.dart';
import 'LeagueFromDetailCard.dart';

class AvailableLeaguesWidget extends StatelessWidget {
  const AvailableLeaguesWidget({super.key, required this.leagues});

  final List<League> leagues;

  @override
  Widget build(BuildContext context) {
    return leagues.isNotEmpty
        ? Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: DetailHeader(
                  text: "availableLeagues".tr().toUpperCase(),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 164,
                child: ListView.separated(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  itemCount: leagues.length,
                  itemBuilder: (context, index) {
                    final league = leagues[index];
                    return GestureDetector(
                      onTap: () {},
                      child: LeagueFromDetail(
                        teamName: league.name,
                        logoUrl: league.logoUrl,
                      ),
                    );
                  },
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(width: 24);
                  },
                ),
              ),
            ],
          )
        : const SizedBox();
  }
}
