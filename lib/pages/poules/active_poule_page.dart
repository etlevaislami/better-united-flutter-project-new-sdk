import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/pages/create_prediction/create_prediction_page.dart';
import 'package:flutter_better_united/pages/poules/poule_page.dart';
import 'package:flutter_better_united/pages/poules/poules_provider.dart';
import 'package:flutter_better_united/pages/poules/public_poule_preview_page.dart';
import 'package:flutter_better_united/widgets/custom_tab_bar.dart';
import 'package:flutter_better_united/widgets/loading_indicator.dart';
import 'package:flutter_better_united/widgets/poule_card_detail.dart';
import 'package:flutter_better_united/widgets/regular_app_bar.dart';
import 'package:provider/provider.dart';

import '../../data/enum/poule_type.dart';
import '../../widgets/league_icon.dart';
import '../../widgets/trophy_primary_button.dart';
import 'friend_poule_preview_page.dart';

class ActivePoulePage extends StatefulWidget {
  const ActivePoulePage({Key? key}) : super(key: key);

  @override
  State<ActivePoulePage> createState() => _ActivePoulePageState();

  static Route route() {
    return CupertinoPageRoute(
        fullscreenDialog: true, builder: (_) => const ActivePoulePage());
  }
}

class _ActivePoulePageState extends State<ActivePoulePage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 2, vsync: this);

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RegularAppBar.fromModal(
          onCloseTap: () {
            Navigator.of(context).pop();
          },
          title: "activePoules".tr()),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 12,
                  ),
                  CustomTabBar(
                    firstTabText: "public".tr(),
                    secondTabText: "friends".tr(),
                    tabController: _tabController,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TrophyPrimaryButton(
                    text: "createAPrediction".tr(),
                    onPressed: () {
                      final pouleType = _tabController.index == 0
                          ? PouleType.public
                          : PouleType.friend;
                      Navigator.of(context).push(
                          CreatePredictionPage.route(pouleType: pouleType));
                    },
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                ],
              ),
            ),
            Expanded(
                child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: const [_PublicPouleList(), _FriendPouleList()],
            )),
          ],
        ),
      ),
    );
  }
}

class _PublicPouleList extends StatelessWidget {
  const _PublicPouleList();

  @override
  Widget build(BuildContext context) {
    final poules = context.watch<PoulesProvider>().activePublicPoules;
    if (poules == null) {
      return LoadingIndicator();
    }
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      itemCount: poules.length,
      itemBuilder: (context, index) {
        final data = poules[index];
        return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                  PoulePage.route(pouleId: data.id, type: PouleType.public));
            },
            child: PublicPouleInfoWidget(
              isFinished: data.isFinished,
              onInfoTap: () {
                Navigator.of(context).push(PublicPoulePreviewPage.route(
                    pouleId: data.id,
                    data: PublicPoulePreviewData(
                        matches: data.matches,
                        logoUrl: data.iconUrl,
                        prizePool: data.poolPrize,
                        coinsForFirst: data.coinsForFirst,
                        coinsForSecond: data.coinsForSecond,
                        coinsForThird: data.coinsForThird,
                        coinsForOthers: data.coinsForOthers,
                        leagues: data.leagues)));
              },
              daysLeft: data.endsAt.difference(DateTime.now()).inDays,
              playerNumbers: data.userCount,
              pouleName: data.name,
              predictionNumbers: data.predictionsLeft,
              rank: data.userRank,
              image: LeagueIconWithPlaceholder(logoUrl: data.iconUrl),
            ));
      },
      separatorBuilder: (context, index) => const SizedBox(
        height: 17,
      ),
    );
  }
}

class _FriendPouleList extends StatelessWidget {
  const _FriendPouleList();

  @override
  Widget build(BuildContext context) {
    final poules = context.watch<PoulesProvider>().activeFriendPoules;
    if (poules == null) {
      return const LoadingIndicator();
    }
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      itemCount: poules.length,
      itemBuilder: (context, index) {
        final data = poules[index];
        return GestureDetector(
          onTap: () async {
            Navigator.of(context).push(
                PoulePage.route(pouleId: data.id, type: PouleType.friend));
          },
          child: FriendPouleWidget(
            isFinished: data.isFinished,
            daysLeft: data.endsAt.difference(DateTime.now()).inDays,
            playerNumbers: data.userCount,
            pouleName: data.name,
            predictionNumbers: data.predictionsLeft,
            rank: data.userRank,
            homeTeam: data.match.homeTeam.name,
            awayTeam: data.match.awayTeam.name,
            matchDate: data.match.startsAt,
            awayTeamLogoUrl: data.match.awayTeam.logoUrl,
            homeTeamLogoUrl: data.match.homeTeam.logoUrl,
            onInfoTap: () {
              Navigator.of(context).push(FriendPoulePreviewPage.route(
                pouleId: data.id,
                data: FriendPoulePreviewData(
                    pouleName: data.name,
                    match: data.match,
                    poolPrize: data.poolPrize),
                isFromOverview: true,
              ));
            },
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        height: 17,
      ),
    );
  }
}
