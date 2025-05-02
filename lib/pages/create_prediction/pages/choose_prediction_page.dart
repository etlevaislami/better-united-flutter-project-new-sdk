import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/constants/market_ids.dart';
import 'package:flutter_better_united/data/model/football_match.dart';
import 'package:flutter_better_united/figma/colors.dart';
import 'package:flutter_better_united/pages/create_prediction/modals/confirm_exit_dialog.dart';
import 'package:flutter_better_united/pages/create_prediction/prediction_widgets/both_team_to_score.dart';
import 'package:flutter_better_united/pages/create_prediction/prediction_widgets/correct_score.dart';
import 'package:flutter_better_united/pages/create_prediction/prediction_widgets/home_draw_away.dart';
import 'package:flutter_better_united/pages/create_prediction/prediction_widgets/player_to_score_anytime.dart';
import 'package:flutter_better_united/pages/create_prediction/prediction_widgets/under_over.dart';
import 'package:flutter_better_united/util/betterUnited_icons.dart';
import 'package:flutter_better_united/util/exceptions/custom_exceptions.dart';
import 'package:flutter_better_united/util/ui_util.dart';
import 'package:flutter_better_united/widgets/custom_tab_bar.dart';
import 'package:flutter_better_united/widgets/league_icon.dart';
import 'package:flutter_better_united/widgets/loading_indicator.dart';
import 'package:flutter_better_united/widgets/match_card.dart';
import 'package:provider/provider.dart';

import '../../../data/repo/league_repository.dart';
import '../../../widgets/fixed_button.dart';
import '../../../widgets/friend_poule_icon.dart';
import '../../../widgets/regular_app_bar.dart';
import '../create_prediction_provider.dart';
import '../prediction_widgets/ToScoreFirst.dart';
import '../prediction_widgets/half_time_full_time.dart';
import '../prediction_widgets/handicap.dart';

class ChoosePredictionPage extends StatefulWidget {
  const ChoosePredictionPage({super.key});

  @override
  State<ChoosePredictionPage> createState() => _ChoosePredictionPageState();
}

class _ChoosePredictionPageState extends State<ChoosePredictionPage>
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
    _fetchOdds();
  }

  _fetchOdds() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      try {
        await context.read<CreatePredictionProvider>().fetchOdds();
      } on MatchAlreadyStarted {
        showToast("matchAlreadyStarted".tr());
        if (mounted) {
          context.read<CreatePredictionProvider>().clearMatch();
          context.read<CreatePredictionProvider>().onBackClicked();
        }
      }
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
        child: const _SelectedMatch(),
        onCloseTap: () {
          showConfirmExitDialog(context);
        },
        onBackTap: context.read<CreatePredictionProvider>().steps.first !=
                CreatePredictionStep.selectPrediction
            ? () {
                context.read<CreatePredictionProvider>().onBackClicked();
              }
            : null,
      ),
      body: _Body(pageController: _pageController),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    super.key,
    required PageController pageController,
  }) : _pageController = pageController;

  final PageController _pageController;

  @override
  Widget build(BuildContext context) {
    final betCategories =
        context.watch<CreatePredictionProvider>().betCategories;
    if (betCategories == null) {
      return const Center(
        child: LoadingIndicator(),
      );
    }
    if (betCategories.isEmpty) {
      return Center(child: Text("informationUnavailable".tr()));
    }
    return PageView(
      controller: _pageController,
      children: [
        OddList(odds: betCategories.popular),
        OddList(odds: betCategories.additional)
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
  const _MatchContainer({required this.match, required this.child});

  final FootballMatch match;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 73,
      margin: const EdgeInsets.all(24),
      child: Row(
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
  const _SelectedMatch();

  @override
  Widget build(BuildContext context) {
    final selectedMatch =
        context.watch<CreatePredictionProvider>().selectedMatch;
    final selectedPoule =
        context.watch<CreatePredictionProvider>().selectedPoule;
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
          )
        : const SizedBox();
  }
}

class OddList extends StatelessWidget {
  const OddList({Key? key, required this.odds}) : super(key: key);
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
              data: odd as HomeDrawAwayData,
              onBetTap: (points, betId, hint) {
                context
                    .read<CreatePredictionProvider>()
                    .onPredictionSelected(betId, points, hint);
              },
            );
          case MarketIds.correctScore:
            return CorrectScoreWidget(
              data: odd as CorrectScoreData,
              onBetTap: (points, betId, hint) {
                context
                    .read<CreatePredictionProvider>()
                    .onPredictionSelected(betId, points, hint);
              },
            );
          case MarketIds.handicap:
            return HandicapWidget(
              data: odd as HandicapData,
              onBetTap: (points, betId, hint) {
                context
                    .read<CreatePredictionProvider>()
                    .onPredictionSelected(betId, points, hint);
              },
            );
          case MarketIds.firstPlayerToScore:
            return FirstPlayerToScoreWidget(
              data: odd as FirstPlayerToScoreData,
              onBetTap: (points, betId, hint) {
                context
                    .read<CreatePredictionProvider>()
                    .onPredictionSelected(betId, points, hint);
              },
            );
          case MarketIds.bothTeamToScore:
            return BothTeamToScore(
              data: odd as BooleanOddData,
              onBetTap: (points, betId, hint) {
                context
                    .read<CreatePredictionProvider>()
                    .onPredictionSelected(betId, points, hint);
              },
            );
          case MarketIds.halfTimeFullTime:
            return HalfTimeFullTimeWidget(
              data: odd as HalfTimeFullTimeData,
              onBetTap: (points, betId, hint) {
                context
                    .read<CreatePredictionProvider>()
                    .onPredictionSelected(betId, points, hint);
              },
            );
          case MarketIds.underOver:
            return UnderOverWidget(
              data: odd as UnderOverData,
              onBetTap: (points, betId, hint) {
                context
                    .read<CreatePredictionProvider>()
                    .onPredictionSelected(betId, points, hint);
              },
            );
          case MarketIds.playerToScoreAnytime:
            return PlayerToScoreAnytimeWidget(
                onBetTap: (points, betId, hint) {
                  context
                      .read<CreatePredictionProvider>()
                      .onPredictionSelected(betId, points, hint);
                },
                data: odd as PlayerToScoreAnytimeData);
          default:
            return const SizedBox();
        }
      },
    );
  }
}
