import 'dart:ui';

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/data/enum/poule_type.dart';
import 'package:flutter_better_united/data/enum/tip_settlement.dart';
import 'package:flutter_better_united/data/model/filter_criteria.dart';
import 'package:flutter_better_united/data/model/league_detail.dart';
import 'package:flutter_better_united/pages/create_prediction/create_prediction_page.dart';
import 'package:flutter_better_united/pages/poules/poule_provider.dart';
import 'package:flutter_better_united/pages/profile/my_profile_page.dart';
import 'package:flutter_better_united/pages/shop/user_provider.dart';
import 'package:flutter_better_united/widgets/custom_tab_bar.dart';
import 'package:flutter_better_united/widgets/info_bubble.dart';
import 'package:flutter_better_united/widgets/prediction_card.dart';
import 'package:flutter_better_united/widgets/primary_button.dart';
import 'package:flutter_better_united/widgets/regular_app_bar.dart';
import 'package:flutter_better_united/widgets/trophy_primary_button.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

import '../../data/model/team.dart';
import '../../data/model/tip.dart';
import '../../figma/colors.dart';
import '../../util/exceptions/custom_exceptions.dart';
import '../../widgets/friend_rank_widget.dart';
import '../profile/profile_page.dart';
import '../tip/tip_provider.dart';

class UserOverviewPage extends StatefulWidget {
  const UserOverviewPage({
    Key? key,
    required this.nickname,
    required this.levelName,
    required this.rank,
    required this.points,
    required this.photoUrl,
    required this.pouleId,
    required this.pouleType,
    required this.userId,
    required this.isFollowingAuthor,
    required this.level,
    this.poule,
  }) : super(key: key);
  final String nickname;
  final String levelName;
  final String? photoUrl;
  final int? rank;
  final int points;
  final int pouleId;
  final PouleType pouleType;
  final int userId;
  final bool isFollowingAuthor;
  final int level;
  final LeagueDetail? poule;

  @override
  State<UserOverviewPage> createState() => _UserOverviewPageState();

  static Route route(
      {required String nickname,
      required String levelName,
      required int? rank,
      required int points,
      required String? photoUrl,
      required PouleType pouleType,
      required int pouleId,
      required int userId,
      required bool isFollowingAuthor,
      required int level,
      LeagueDetail? poule}) {
    return CupertinoPageRoute(
      builder: (_) => UserOverviewPage(
        pouleType: pouleType,
        pouleId: pouleId,
        nickname: nickname,
        levelName: levelName,
        rank: rank,
        points: points,
        photoUrl: photoUrl,
        userId: userId,
        isFollowingAuthor: isFollowingAuthor,
        level: level,
        poule: poule,
      ),
    );
  }
}

class _UserOverviewPageState extends State<UserOverviewPage> {
  late final TipProvider _tipProvider;
  late final int _connectedUserId;

  @override
  void initState() {
    super.initState();
    _connectedUserId = context.read<UserProvider>().user?.userId ?? -1;
    _tipProvider = TipProvider(
      context.read(),
      context.read(),
      filterCriteria: FilterCriteria(
        userId: widget.userId,
        publicLeagueId:
            widget.pouleType == PouleType.public ? widget.pouleId : null,
        friendLeagueId:
            widget.pouleType == PouleType.friend ? widget.pouleId : null,
        onlyActive: true,
        onlyHistory: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RegularAppBar.withBackButton(
        title: "predictionSharedBy".tr().toUpperCase(),
        onBackTap: () {
          context.pop();
        },
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FriendRankWidget(
                  isConnectedUser: widget.userId == _connectedUserId,
                  level: 1,
                  onProfileTap: () {
                    _openProfilePage();
                  },
                  name: widget.nickname,
                  levelName: widget.levelName,
                  profileUrl: widget.photoUrl,
                  points: widget.points,
                  wins: 22,
                  highestOdd: 33,
                  powerUpsUsed: 3,
                  rank: widget.rank,
                ),
                const SizedBox(height: 16),
                PrimaryButton(
                  text: "viewProfile".tr(),
                  onPressed: () {
                    _openProfilePage();
                  },
                  confineInSafeArea: false,
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
          const SizedBox(height: 12),
          ChangeNotifierProvider(
            create: (context) => _tipProvider,
            child: Selector<TipProvider, PagingState<int, TipDetail>>(
              selector: (p0, p1) => p1.pagingState,
              builder: (context, pagingState, child) {
                if (pagingState.status == PagingStatus.firstPageError) {
                  if (pagingState.error is TipsAreHiddenException) {
                    final poule = widget.poule;
                    if (poule != null) {
                      return _HiddenPredictions(
                        level: widget.level,
                        nickname: widget.nickname,
                        levelName: widget.levelName,
                        pouleId: widget.pouleId,
                        poule: poule,
                      );
                    }
                  }
                  return const SizedBox();
                }
                return _PredictionList(
                  pagingState: pagingState,
                  pouleName: widget.poule?.name ?? "",
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _openProfilePage() {
    if (widget.userId == _connectedUserId) {
      Navigator.of(context).push(MyProfilePage.route());
    } else {
      Navigator.of(context).push(ProfilePage.route(
        userId: widget.userId,
      ));
    }
  }
}

class _HiddenPredictions extends StatelessWidget {
  const _HiddenPredictions({
    Key? key,
    required this.level,
    this.photoUrl,
    required this.levelName,
    required this.nickname,
    required this.pouleId,
    required this.poule,
  }) : super(key: key);

  final int level;
  final String? photoUrl;
  final String levelName;
  final String nickname;
  final int pouleId;
  final LeagueDetail poule;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(height: 100, color: AppColors.background),
                PredictionCard(
                  tipSettlement: TipSettlement.won,
                  isVoided: false,
                  startsAt: DateTime.now(),
                  rank: level,
                  photoUrl: photoUrl,
                  points: 111,
                  pouleName: "Poule",
                  homeTeam: Team(1, "Ajax",
                      "https://www.thesportsdb.com/images/media/team/badge/xtvypw1473453918.png"),
                  awayTeam: Team(1, "Feyenoord",
                      "https://www.thesportsdb.com/ images/media/team/badge/xtvypw1473453918.png"),
                  leagueName: "Eredivisie",
                  createdAt: DateTime.now(),
                  levelName: levelName,
                  name: nickname,
                  odd: "3.5",
                  isConnectedUser: false,
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: InfoBubble(
              title: "interestedInViewingPrediction".tr(),
              description: "predictionViewingInterest".tr(),
              child: TrophyPrimaryButton(
                text: "createAPrediction".tr(),
                onPressed: () async {
                  await Navigator.of(context).push(
                    CreatePredictionPage.route(
                      poule: poule,
                      pouleType: poule.pouleType,
                    ),
                  );
                  context.read<PouleProvider>().refreshDetail();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PredictionList extends StatefulWidget {
  const _PredictionList({
    Key? key,
    required this.pagingState,
    required this.pouleName,
  }) : super(key: key);
  final PagingState<int, TipDetail> pagingState;
  final String pouleName;

  @override
  State<_PredictionList> createState() => _PredictionListState();
}

class _PredictionListState extends State<_PredictionList>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController = TabController(
    length: 2,
    vsync: this,
  );
  late final TipProvider _tipProvider = context.read<TipProvider>();
  late final PagingController<int, TipDetail> _pagingController;

  @override
  void initState() {
    super.initState();

    _pagingController = PagingController<int, TipDetail>(
      getNextPageKey: (state) => (state.keys?.last ?? 0) + 1,
      fetchPage: (pageKey) {
        if (_pagingController.value.keys?.contains(pageKey) == true) {
          return Future<List<TipDetail>>.value([]);
        }
        return _tipProvider.getTips(pageNumber: pageKey);
      },
    );

    if (widget.pagingState.pages != null &&
        widget.pagingState.pages!.isNotEmpty &&
        widget.pagingState.keys != null &&
        widget.pagingState.keys!.isNotEmpty) {
      _pagingController.value = widget.pagingState;
    }

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        if (_tabController.index == 0) {
          _tipProvider.updateFilterCriteria(
            FilterCriteria.copy(_tipProvider.filterCriteria)
              ..onlyActive = true
              ..onlyHistory = false,
          );
        } else {
          _tipProvider.updateFilterCriteria(
            FilterCriteria.copy(_tipProvider.filterCriteria)
              ..onlyActive = false
              ..onlyHistory = true,
          );
        }
      }
    });
  }

  @override
  dispose() {
    _pagingController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: CustomTabBar(
              tabController: _tabController,
              firstTabText: "active".tr(),
              secondTabText: "history".tr(),
            ),
          ),
          Expanded(
            child: Consumer<TipProvider>(
              builder: (context, tipProvider, child) {
                final providerState = tipProvider.pagingState;
                final hasProviderData =
                    providerState.pages != null &&
                        providerState.pages!.isNotEmpty &&
                        providerState.keys != null &&
                        providerState.keys!.isNotEmpty;

                if (hasProviderData &&
                    providerState != _pagingController.value) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _pagingController.value = providerState;
                  });
                }

                return PagingListener(
                  controller: _pagingController,
                  builder:
                      (
                      context,
                      state,
                      fetchNextPage,
                      ) => PagedListView.separated(
                    state: state,
                    fetchNextPage: fetchNextPage,
                    builderDelegate: PagedChildBuilderDelegate<TipDetail>(
                      firstPageErrorIndicatorBuilder:
                          (context) => SizedBox(),
                      noItemsFoundIndicatorBuilder:
                          (context) => const SizedBox(),
                      firstPageProgressIndicatorBuilder:
                          (context) => Center(
                        child: Container(
                          margin: const EdgeInsets.only(top: 10),
                          height: 24,
                          width: 24,
                          child: const CircularProgressIndicator(),
                        ),
                      ),
                      invisibleItemsThreshold: 3,
                      itemBuilder: (context, tip, index) {
                        return PredictionCard(
                          tipSettlement: tip.tipSettlement,
                          startsAt: tip.matchStartsAt,
                          onProfileTap:
                              () => () {
                            Navigator.of(context).push(
                              ProfilePage.route(userId: tip.userId),
                            );
                          },
                          rank: tip.userLevel,
                          photoUrl: tip.userProfilePictureUrl,
                          points: tip.points,
                          pouleName: widget.pouleName,
                          homeTeam: tip.homeTeam,
                          awayTeam: tip.awayTeam,
                          leagueName: tip.leagueName,
                          createdAt: tip.tipCreatedAt,
                          levelName: tip.userLevelName,
                          name: tip.userNickname,
                          odd: tip.hints,
                          isConnectedUser: tip.isOwn,
                          isVoided: tip.isTipVoided,
                        );
                      },
                    ),
                    padding: const EdgeInsets.only(bottom: 50, top: 20),
                    shrinkWrap: false,
                    separatorBuilder:
                        (BuildContext context, int index) =>
                    const SizedBox(height: 16),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
