import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/constants/market_ids.dart';
import 'package:flutter_better_united/data/model/football_match.dart';
import 'package:flutter_better_united/data/model/match_bets.dart';
import 'package:flutter_better_united/data/model/team.dart';
import 'package:flutter_better_united/figma/colors.dart';
import 'package:flutter_better_united/pages/create_prediction/modals/confirm_exit_dialog.dart';
import 'package:flutter_better_united/pages/create_prediction/prediction_widgets/ToScoreFirst.dart';
import 'package:flutter_better_united/pages/create_prediction/prediction_widgets/both_team_to_score.dart';
import 'package:flutter_better_united/pages/create_prediction/prediction_widgets/correct_score.dart';
import 'package:flutter_better_united/pages/create_prediction/prediction_widgets/half_time_full_time.dart';
import 'package:flutter_better_united/pages/create_prediction/prediction_widgets/handicap.dart';
import 'package:flutter_better_united/pages/create_prediction/prediction_widgets/home_draw_away.dart';
import 'package:flutter_better_united/pages/create_prediction/prediction_widgets/player_to_score_anytime.dart';
import 'package:flutter_better_united/pages/create_prediction/prediction_widgets/under_over.dart';
import 'package:flutter_better_united/util/betterUnited_icons.dart';
import 'package:flutter_better_united/util/ui_util.dart';
import 'package:flutter_better_united/widgets/custom_tab_bar.dart';
import 'package:flutter_better_united/widgets/league_icon.dart';
import 'package:flutter_better_united/widgets/loading_indicator.dart';
import 'package:flutter_better_united/widgets/match_card.dart';

import '../../../data/repo/league_repository.dart';
import '../../../widgets/fixed_button.dart';
import '../../../widgets/friend_poule_icon.dart';
import '../../../widgets/regular_app_bar.dart';

/// Page for the choose prediction tutorial, with dummy data.
class DummyChoosePredictionPage extends StatefulWidget {
  const DummyChoosePredictionPage({
    required this.unblurredMatchWidgetKey,
    required this.unblurredPredictionWidgetKey,
    super.key,
  });

  static const route = "/choose_prediction_tutorial";

  final GlobalKey unblurredMatchWidgetKey;
  final GlobalKey unblurredPredictionWidgetKey;

  @override
  State<DummyChoosePredictionPage> createState() =>
      _DummyChoosePredictionPageState();
}

class _DummyChoosePredictionPageState extends State<DummyChoosePredictionPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 2, vsync: this);
  final PageController _pageController = PageController(keepPage: true);

  @override
  void initState() {
    super.initState();
    _tabController.addListener(() {
      _pageController.animateToPage(_tabController.index,
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _AppBar(
        tabController: _tabController,
        title: "createPrediction".tr(),
        child: _SelectedMatch(
            unblurredMatchWidgetKey: widget.unblurredMatchWidgetKey),
        onCloseTap: () {
          showConfirmExitDialog(context);
        },
        onBackTap: () {
          showToast('todo');
        },
      ),
      body: _Body(
          pageController: _pageController,
          unblurredPredictionWidgetKey: widget.unblurredPredictionWidgetKey),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    super.key,
    required PageController pageController,
    this.unblurredPredictionWidgetKey,
  }) : _pageController = pageController;

  final GlobalKey? unblurredPredictionWidgetKey;

  final PageController _pageController;

  @override
  Widget build(BuildContext context) {
    final betCategories = OddsList(popular: [
      HomeDrawAwayData(
        1,
        false,
        true,
        homeTeamName: 'AFC Ajax',
        awayHint: 'away hint',
        awayTeamBetId: 1,
        awayTeamName: 'Liverpool F.C.',
        awayTeamPoints: 0,
        drawBetId: 10,
        drawHint: 'draw hint',
        drawPoints: 1,
        homeHint: 'home hint',
        homeTeamBetId: 2,
        homeTeamPoints: 2,
      )
    ], additional: []);

    if (betCategories == null) {
      return const Center(
        child: LoadingIndicator(),
      );
    }
    if (betCategories.isEmpty) {
      return Center(child: Text("informationUnavailable".tr()));
    }
    return Stack(
      children: [
        PageView(
          controller: _pageController,
          children: [
            OddList(
                odds: betCategories.popular,
                unblurredPredictionWidgetKey: unblurredPredictionWidgetKey),
            OddList(odds: betCategories.additional)
          ],
        ),
      ],
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({
    Key? key,
    this.onCloseTap,
    this.onBackTap,
    this.title,
    required this.tabController,
    required this.child,
  }) : super(key: key);
  final VoidCallback? onCloseTap;
  final VoidCallback? onBackTap;
  final String? title;
  final TabController tabController;
  final Widget child;

  static const appBarHeight = 300.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: preferredSize.height,
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                    child: Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                    // Specify the image asset or network URL
                    image: AssetImage('assets/images/img_stadium.png'),
                    // Optionally, you can set the fit property
                    fit: BoxFit.cover,
                  )),
                )),
                RegularAppBar(
                  backgroundColor: Colors.transparent,
                  title: title,
                  imageOpacity: onBackTap == null ? 0.5 : 1,
                  withBackgroundImage: false,
                  prefixIcon: onBackTap != null
                      ? FixedButton(
                          iconData: BetterUnited.triangle, onTap: onBackTap)
                      : null,
                  suffixIcon: onCloseTap != null
                      ? FixedButton(
                          iconData: BetterUnited.remove, onTap: onCloseTap)
                      : null,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: child,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: CustomTabBar(
              firstTabText: "popular".tr(),
              secondTabText: "additional".tr(),
              tabController: tabController,
            ),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(appBarHeight);
}

class _MatchContainer extends StatelessWidget {
  const _MatchContainer(
      {required this.match, required this.child, this.unblurredMatchWidgetKey});

  final GlobalKey? unblurredMatchWidgetKey;

  final FootballMatch match;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 73,
      margin: const EdgeInsets.all(24),
      child: Row(
        key: unblurredMatchWidgetKey,
        children: [
          Container(
            width: 37,
            decoration: const BoxDecoration(
              color: Color(0xff222222),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
            ),
            child: Align(
              child: Transform.scale(scale: 0.6, child: child),
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                  color: AppColors.secondary),
              child: MatchCard(
                  homeTeam: match.homeTeam,
                  awayTeam: match.awayTeam,
                  matchDate: match.startsAt),
            ),
          ),
        ],
      ),
    );
  }
}

class _SelectedMatch extends StatelessWidget {
  const _SelectedMatch({Key? key, this.unblurredMatchWidgetKey})
      : super(key: key);
  final GlobalKey? unblurredMatchWidgetKey;

  @override
  Widget build(BuildContext context) {
    final selectedMatch = FootballMatch(
      1,
      DateTime.now().add(const Duration(days: 3)),
      // TODO logo url...
      Team(
        1,
        'AFC Ajax',
        null,
      ),
      Team(
        1,
        'Liverpool F.C.',
        null,
      ),
      MatchBets(
        MatchBet('matchBetName home', 0.4),
        MatchBet('matchBetName draw', 0.2),
        MatchBet('matchBetName away', 0.4),
      ),
      2,
      false,
      false,
    );
    // todo?
    final selectedPoule = null;
    late Widget icon;
    if (selectedPoule?.publicPouleData != null) {
      icon = LeagueIconWithPlaceholder(
        logoUrl: selectedPoule?.publicPouleData?.imageUrl,
      );
    } else {
      icon = const FriendPouleIcon();
    }

    return selectedMatch != null
        ? _MatchContainer(
            match: selectedMatch,
            child: icon,
            unblurredMatchWidgetKey: unblurredMatchWidgetKey,
          )
        : const SizedBox();
  }
}

class OddList extends StatelessWidget {
  const OddList(
      {Key? key, required this.odds, this.unblurredPredictionWidgetKey})
      : super(key: key);
  final GlobalKey? unblurredPredictionWidgetKey;

  final List<OddData> odds;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: odds.length,
      itemBuilder: (context, index) {
        final odd = odds[index];
        switch (odd.id) {
          case MarketIds.homeDrawAway:
            return HomeDrawAwayWidget(
              key: unblurredPredictionWidgetKey,
              data: odd as HomeDrawAwayData,
              onBetTap: (points, betId, hint) {},
            );
          case MarketIds.correctScore:
            return CorrectScoreWidget(
              data: odd as CorrectScoreData,
              onBetTap: (points, betId, hint) {},
            );
          case MarketIds.handicap:
            return HandicapWidget(
              data: odd as HandicapData,
              onBetTap: (points, betId, hint) {},
            );
          case MarketIds.firstPlayerToScore:
            return FirstPlayerToScoreWidget(
              data: odd as FirstPlayerToScoreData,
              onBetTap: (points, betId, hint) {},
            );
          case MarketIds.bothTeamToScore:
            return BothTeamToScore(
              data: odd as BooleanOddData,
              onBetTap: (points, betId, hint) {},
            );
          case MarketIds.halfTimeFullTime:
            return HalfTimeFullTimeWidget(
              data: odd as HalfTimeFullTimeData,
              onBetTap: (points, betId, hint) {},
            );
          case MarketIds.underOver:
            return UnderOverWidget(
              data: odd as UnderOverData,
              onBetTap: (points, betId, hint) {},
            );
          case MarketIds.playerToScoreAnytime:
            return PlayerToScoreAnytimeWidget(
                onBetTap: (points, betId, hint) {},
                data: odd as PlayerToScoreAnytimeData);
          default:
            return const SizedBox();
        }
      },
    );
  }
}
