import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/constants/extended_theme.dart';
import 'package:flutter_better_united/data/enum/ranking_type.dart';
import 'package:flutter_better_united/data/model/ranked_participant.dart';
import 'package:flutter_better_united/data/model/ranking_overview.dart';
import 'package:flutter_better_united/data/model/team_of_season.dart';
import 'package:flutter_better_united/data/model/team_of_week.dart';
import 'package:flutter_better_united/figma/colors.dart';
import 'package:flutter_better_united/pages/ranking/ranking_info_dialog.dart';
import 'package:flutter_better_united/pages/ranking/team_of_season/ranking_team_of_season_page.dart';
import 'package:flutter_better_united/pages/ranking/team_of_week/ranking_team_of_week_page.dart';
import 'package:flutter_better_united/util/date_util.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../util/betterUnited_icons.dart';
import '../../widgets/background_container.dart';
import '../../widgets/custom_tab_bar.dart';
import '../../widgets/fixed_button.dart';
import '../../widgets/friend_rank_widget.dart';
import '../../widgets/regular_app_bar.dart';
import '../../widgets/see_more_button.dart';
import '../../widgets/stat_widgets.dart';
import '../nav_page.dart';
import '../profile/my_profile_page.dart';
import '../profile/profile_page.dart';

/// Ranking page showing fake data, for tutorials.
class DummyRankingPage extends StatefulWidget {
  const DummyRankingPage({Key? key, this.unblurredWeeklyRankingSectionKey}) : super(key: key);
  final GlobalKey? unblurredWeeklyRankingSectionKey;

  @override
  State<DummyRankingPage> createState() => _DummyRankingPageState();
}

class _DummyRankingPageState extends State<DummyRankingPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.only(
        bottom: NavPage.navBarHeight,
      ),
      child: Scaffold(
          bottomNavigationBar: const _BottomNavigationBar(),
          appBar: RegularAppBar(
            suffixIcon: FixedButton(
              iconData: BetterUnited.info,
              onTap: () {
                RankingInfoDialog.displayDialog(context);
              },
            ),
            prefixIcon: Row(
              children: [
                const Icon(
                  BetterUnited.ranking,
                  color: AppColors.primary,
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  "ranking".tr().toUpperCase(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      shadows: [
                        Shadow(
                          offset: Offset(0, 2),
                          blurRadius: 16,
                          color: Color.fromRGBO(0, 0, 0, 0.5),
                        ),
                      ],
                      fontSize: 18,
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
          ),
          body: _RankingOverview(
            unblurredWeeklyRankingSectionKey: widget.unblurredWeeklyRankingSectionKey,
          )),
    );
  }
}

class _PaginatedParticipants extends StatefulWidget {
  const _PaginatedParticipants({
    Key? key,
  }) : super(key: key);

  @override
  State<_PaginatedParticipants> createState() => _PaginatedParticipantsState();
}

class _PaginatedParticipantsState extends State<_PaginatedParticipants> {
  final _pagingController = PagingController<int, RankedParticipant>(
    firstPageKey: 1,
  );

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const pagingState = PagingState<int, RankedParticipant>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: PagedListView.separated(
        builderDelegate: PagedChildBuilderDelegate<RankedParticipant>(
          firstPageErrorIndicatorBuilder: (context) => const SizedBox(),
          noItemsFoundIndicatorBuilder: (context) => const SizedBox(),
          firstPageProgressIndicatorBuilder: (context) => Center(
            child: Container(
                margin: const EdgeInsets.only(top: 10),
                height: 24,
                width: 24,
                child: const CircularProgressIndicator()),
          ),
          itemBuilder: (context, participant, index) {
            return FriendRankWidget(
              drawPlus: false,
              coins: null,
              isConnectedUser: participant.isLoggedUser,
              level: -1,
              name: participant.nickname ?? "undefined".tr(),
              levelName: participant.levelName,
              profileUrl: participant.profileIconUrl,
              points: participant.points,
              onProfileTap: () {
                if (participant.isLoggedUser) {
                  Navigator.of(context).push(MyProfilePage.route());
                } else {
                  Navigator.of(context)
                      .push(ProfilePage.route(userId: participant.userId));
                }
              },
              wins: -1,
              highestOdd: -1,
              powerUpsUsed: -1,
              rank: participant.rank,
            );
          },
        ),
        padding: const EdgeInsets.only(bottom: 50),
        shrinkWrap: false,
        separatorBuilder: (BuildContext context, int index) => const SizedBox(
          height: 16,
        ),
        pagingController: _pagingController..value = pagingState,
      ),
    );
  }
}

class _BottomNavigationBar extends StatelessWidget {
  const _BottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}

class _RankingOverview extends StatefulWidget {
  const _RankingOverview({Key? key, this.unblurredWeeklyRankingSectionKey}) : super(key: key);
  final GlobalKey? unblurredWeeklyRankingSectionKey;

  @override
  State<_RankingOverview> createState() => _RankingOverviewState();
}

class _RankingOverviewState extends State<_RankingOverview>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 2, vsync: this);

  @override
  dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _Banner(
                  teamOfWeek: RankingDummyData.teamOfWeek,
                  teamOfSeason: RankingDummyData.teamOfSeason),
              const SizedBox(
                height: 16,
              ),
              Column(
                key: widget.unblurredWeeklyRankingSectionKey,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomTabBar(
                    firstTabText: "weekly".tr(),
                    secondTabText: "seasonal".tr(),
                    tabController: _tabController,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const _PeriodContainer(),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) {
                      final maxIndex = RankingDummyData.participants.length - 1;
                      late final bool shouldDrawSeperator;
                      if (index == maxIndex) {
                        shouldDrawSeperator = false;
                      } else {
                        final currentParticiapnt =
                            RankingDummyData.participants[index];
                        final nextParticipant =
                            RankingDummyData.participants[index + 1];
                        if ((nextParticipant.rank - currentParticiapnt.rank) >
                            1) {
                          shouldDrawSeperator = true;
                        } else {
                          shouldDrawSeperator = false;
                        }
                      }
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(
                            height: 8,
                          ),
                          shouldDrawSeperator
                              ? Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        height: 8,
                                        width: 8,
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColors.buttonInnactive),
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Container(
                                        height: 8,
                                        width: 8,
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColors.buttonInnactive),
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Container(
                                        height: 8,
                                        width: 8,
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColors.buttonInnactive),
                                      ),
                                    ],
                                  ),
                                )
                              : const SizedBox()
                        ],
                      );
                    },
                    itemBuilder: (context, index) {
                      final participant = RankingDummyData.participants[index];
                      final isConnectedUser = participant.isLoggedUser;
                      return FriendRankWidget(
                        drawPlus: false,
                        coins: null,
                        isConnectedUser: isConnectedUser,
                        level: -1,
                        name: participant.nickname ?? "undefined".tr(),
                        levelName: participant.levelName,
                        profileUrl: participant.profileIconUrl,
                        points: participant.points,
                        wins: -1,
                        highestOdd: -1,
                        powerUpsUsed: -1,
                        rank: (participant.rank),
                        onProfileTap: () {
                          if (participant.isLoggedUser) {
                            Navigator.of(context).push(MyProfilePage.route());
                          } else {
                            Navigator.of(context).push(
                                ProfilePage.route(userId: participant.userId));
                          }
                        },
                      );
                    },
                    itemCount: RankingDummyData.participants.length,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 23.0),
                    child: GestureDetector(
                        onTap: () {},
                        child: const SeeMoreButton(
                          isExpanded: false,
                        )),
                  ),
                  PredictionStatWidget(
                      totalPredictions:
                          RankingDummyData.weeklyRanking.totalPredictions,
                      wonPredictions:
                          RankingDummyData.weeklyRanking.totalPredictionsWon,
                      lostPredictions:
                          RankingDummyData.weeklyRanking.totalPredictionsLost,
                      title: "predictionOverview".tr()),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Banner extends StatelessWidget {
  const _Banner(
      {Key? key, required this.teamOfWeek, required this.teamOfSeason})
      : super(key: key);
  final TeamOfWeek? teamOfWeek;
  final TeamOfSeason? teamOfSeason;

  @override
  Widget build(BuildContext context) {
    const RankingType rankingType = RankingType.weekly;
    final isWeekly = rankingType == RankingType.weekly;
    return GestureDetector(
      onTap: teamOfWeek != null && teamOfSeason != null
          ? () {
              if (isWeekly) {
                _navigateToTeamOfWeekPage(context, teamOfWeek!);
              } else {
                _navigateToTeamOfSeasonPage(context, teamOfSeason!);
              }
            }
          : null,
      child: Container(
        padding: const EdgeInsets.all(18),
        alignment: Alignment.centerLeft,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: AppColors.background,
          image: DecorationImage(
            image: AssetImage(isWeekly
                ? "assets/images/img_week.png"
                : "assets/images/img_seasonal.png"),
            fit: BoxFit.cover,
          ),
          border: const GradientBoxBorder(
            gradient: LinearGradient(colors: [
              Color(0xff585858),
              Color(0xff353535),
            ]),
            width: 4,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              (isWeekly ? "teamOfTheWeekMultiLine" : "teamOfTheSeasonMultiLine")
                  .tr()
                  .toUpperCase(),
              style: context.titleH1White,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              (isWeekly
                      ? "topElevenPlayersOfTheWeek"
                      : "topElevenPlayersOfTheSeason")
                  .tr(),
              style: context.labelRegular,
            )
          ],
        ),
      ),
    );
  }

  void _navigateToTeamOfWeekPage(BuildContext context, TeamOfWeek teamOfWeek) {
    Navigator.of(context, rootNavigator: true)
        .push(RankingTeamOfWeekPage.route(teamOfWeek: teamOfWeek));
  }

  void _navigateToTeamOfSeasonPage(
      BuildContext context, TeamOfSeason teamOfSeason) {
    Navigator.of(context, rootNavigator: true)
        .push(RankingTeamOfSeasonPage.route(teamOfSeason: teamOfSeason));
  }
}

class _PeriodContainer extends StatelessWidget {
  const _PeriodContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final weeklyRanking = RankingDummyData.weeklyRanking;
    const rankingType = RankingType.weekly;

    if (weeklyRanking == null) {
      return const SizedBox();
    }
    return BackgroundContainer(
      isInclinationReversed: false,
      widthRatio: 0.75,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      foregroundColor: AppColors.primary,
      backgroundColor: AppColors.secondary,
      leadingChild: Text(
        _formatDatePeriod(
            weeklyRanking.startDate, weeklyRanking.endDate, rankingType),
        style: context.bodyBold.copyWith(color: Colors.white),
      ),
      trailingChild: Text(
        daysLeftFormatted(weeklyRanking.daysLeft),
        textAlign: TextAlign.center,
        style: context.bodyBold.copyWith(color: Colors.white),
      ),
    );
  }

  String _formatWeeklyPeriod(DateTime date) {
    // Get the week of the month
    int weekOfMonth = ((date.day - 1) / 7).floor() + 1;
    // Format the month and year
    String month = DateFormat('MMMM').format(date);
    String year = DateFormat('yyyy').format(date);

    // Determine the ordinal indicator for the week
    String weekIndicator = '';
    switch (weekOfMonth) {
      case 1:
        weekIndicator = "firstWeekIndicator".tr();
        break;
      case 2:
        weekIndicator = "secondWeekIndicator".tr();
        break;
      case 3:
        weekIndicator = "thirdWeekIndicator".tr();
        break;
      case 4:
        weekIndicator = "fourthWeekIndicator".tr();
        break;
      case 5:
        weekIndicator = "fifthWeekIndicator".tr();
        break;
    }

    return "weeklyPeriod".tr(namedArgs: {
      "weekIndicator": weekIndicator,
      "month": month,
      "year": year
    });
  }

  String _formatDatePeriod(
      DateTime start, DateTime end, RankingType rankingType) {
    if (rankingType == RankingType.seasonal) {
      return formatSeasonalPeriod(start, end);
    } else if (rankingType == RankingType.weekly) {
      return _formatWeeklyPeriod(start);
    }
    return "";
  }
}

class RankingDummyData {
  static final dummyTopUsers = [
    RankedParticipant(
      1,
      1,
      false,
      null,
      1670,
      'CLUB LEGEND',
      'GIORNO GIOVANNA',
    ),
    RankedParticipant(
      2,
      2,
      false,
      null,
      1084,
      'CLUB LEGEND',
      'JEROME POLANDO',
    ),
    RankedParticipant(
      3,
      3,
      false,
      null,
      791,
      'STAR PLAYER',
      'KEVIN SANJAYANO',
    ),
    RankedParticipant(
      4,
      4,
      false,
      null,
      631,
      'GRAND STAND',
      'CAITLIN HUIJNEN',
    ),
    RankedParticipant(
      5,
      5,
      false,
      null,
      405,
      'SUPER SUB',
      'BRANDON',
    ),
  ];
  static final weeklyRanking = RankingOverview(
      endDate: DateTime.now().add(const Duration(days: 3)),
      startDate: DateTime.now().add(const Duration(days: -4)),
      totalPredictions: 10,
      totalPredictionsLost: 3,
      totalPredictionsWon: 7,
      rankings: dummyTopUsers);

  static final participants = dummyTopUsers;
  static final teamOfWeek = TeamOfWeek(
    amountToClaim: 50,
    endDate: DateTime.now().add(const Duration(days: 3)),
    isClaimed: false,
    startDate: DateTime.now().add(const Duration(days: -4)),
    team: dummyTopUsers,
    userHasWon: false,
  );
  static final teamOfSeason = TeamOfSeason(
    amountToClaim: 50,
    endDate: DateTime.now().add(const Duration(days: 3)),
    isClaimed: false,
    startDate: DateTime.now().add(const Duration(days: -4)),
    team: dummyTopUsers,
    userHasWon: false,
  );
}
