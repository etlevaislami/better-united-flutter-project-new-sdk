import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/constants/extended_theme.dart';
import 'package:flutter_better_united/figma/colors.dart';
import 'package:flutter_better_united/figma/shadows.dart';
import 'package:flutter_better_united/pages/create_prediction/create_prediction_page.dart';
import 'package:flutter_better_united/pages/poules/invite_friends_page.dart';
import 'package:flutter_better_united/pages/poules/poules_provider.dart';
import 'package:flutter_better_united/pages/poules/public_poule_preview_page.dart';
import 'package:flutter_better_united/pages/poules/user_overview_page.dart';
import 'package:flutter_better_united/pages/shop/user_provider.dart';
import 'package:flutter_better_united/util/betterUnited_icons.dart';
import 'package:flutter_better_united/widgets/available_matches_widget.dart';
import 'package:flutter_better_united/widgets/background_container.dart';
import 'package:flutter_better_united/widgets/custom_tab_bar.dart';
import 'package:flutter_better_united/widgets/grey_color_filtered.dart';
import 'package:flutter_better_united/widgets/input_field.dart';
import 'package:flutter_better_united/widgets/primary_button.dart';
import 'package:flutter_better_united/widgets/trophy_pedestal.dart';
import 'package:flutter_better_united/widgets/trophy_primary_button.dart';
import 'package:flutter_scroll_shadow/flutter_scroll_shadow.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../data/enum/poule_type.dart';
import '../../data/model/league_detail.dart';
import '../../data/model/participant.dart';
import '../../util/date_util.dart';
import '../../widgets/empty_search_result.dart';
import '../../widgets/friend_rank_widget.dart';
import '../../widgets/info_bubble.dart';
import '../../widgets/league_icon.dart';
import '../../widgets/match_card.dart';
import '../../widgets/prize_poule_text.dart';
import '../../widgets/regular_app_bar.dart';
import '../../widgets/see_more_button.dart';
import '../../widgets/stat_widgets.dart';
import '../tip/tip_page.dart';
import 'friend_poule_preview_page.dart';
import 'poule_provider.dart';

class PoulePage extends StatefulWidget {
  const PoulePage({Key? key, required this.pouleId, required this.type})
      : super(key: key);
  final int pouleId;
  final PouleType type;

  @override
  State<PoulePage> createState() => _PoulePageState();

  static Route route({required int pouleId, required PouleType type}) {
    return CupertinoPageRoute(
      builder: (_) => PoulePage(
        pouleId: pouleId,
        type: type,
      ),
    );
  }
}

class _PoulePageState extends State<PoulePage> {
  final _scrollController = ScrollController();
  late final PouleProvider _pouleProvider;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _pouleProvider = PouleProvider(context.read(),
        pouleId: widget.pouleId,
        pouleType: widget.type,
        connectedUserId: context.read<UserProvider>().user?.userId ?? 0);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pouleProvider.getPouleDetail();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _pouleProvider,
      builder: (context, child) {
        final isExpanded = context.watch<PouleProvider>().isExpanded;
        final data = context.watch<PouleProvider>().poule;
        if (data == null) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        final PreferredSizeWidget appBar = data.isPublicLeague
            ? RegularAppBarV2(
                image: LeagueIconWithPlaceholder(
                  logoUrl: data.publicPouleData?.imageUrl,
                ),
                onInfoTap: () {
                  Navigator.of(context).push(PublicPoulePreviewPage.route(
                      pouleId: data.id,
                      data: PublicPoulePreviewData(
                          logoUrl: data.publicPouleData?.imageUrl,
                          prizePool: data.prizePool ?? 0,
                          coinsForFirst: data.publicPouleData!.coinsForFirst,
                          coinsForSecond: data.publicPouleData!.coinsForSecond,
                          coinsForThird: data.publicPouleData!.coinsForThird,
                          coinsForOthers: data.publicPouleData!.coinsForOthers,
                          matches: data.publicPouleData!.matches,
                          leagues: data.publicPouleData!.leagues)));
                },
                onBackTap: () {
                  context.pop();
                },
              ) as PreferredSizeWidget
            : RegularAppBarV3(
                title: data.name,
                onInfoTap: () {
                  Navigator.of(context).push(
                    FriendPoulePreviewPage.route(
                      pouleId: data.id,
                      data: FriendPoulePreviewData(
                        match: data.friendPouleData!.match,
                        pouleName: data.name,
                        poolPrize: data.prizePool ?? 0,
                      ),
                      isFromOverview: true,
                    ),
                  );
                },
                onBackTap: () {
                  context.pop();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: MatchCard(
                    matchDate: data.friendPouleData!.match.startsAt,
                    homeTeam: data.friendPouleData!.match.homeTeam,
                    awayTeam: data.friendPouleData!.match.awayTeam,
                  ),
                ),
              );
        return Scaffold(
            bottomNavigationBar: const _BottomNavigationBar(),
            appBar: appBar,
            extendBodyBehindAppBar: true,
            body: SafeArea(
              top: true,
              child: ScrollShadow(
                color: isExpanded ? AppColors.background : Colors.transparent,
                size: 20,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 12,
                      ),
                      if (data.publicPouleData?.matches != null &&
                          data.pouleType == PouleType.public)
                        AvailableMatchesWidget(
                          matches: data.publicPouleData!.matches,
                          showTitle: false,
                        ),
                      const SizedBox(
                        height: 12,
                      ),
                      !isExpanded
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _TrophyPrimaryButton(data: data),
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "ranking".tr().toUpperCase(),
                                        style: context.titleH2
                                            .copyWith(color: Colors.white),
                                      ),
                                      data.isFinished
                                          ? const SizedBox()
                                          : GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                    InviteFriendsPage.route(
                                                        leagueLogoUrl: data
                                                            .publicPouleData
                                                            ?.imageUrl,
                                                        poolPrize:
                                                            data.prizePool ?? 0,
                                                        pouleId: data.id,
                                                        withCloseButton: true,
                                                        entryFee:
                                                            data.entryFee ?? 0,
                                                        pouleType: widget.type,
                                                        pouleName: data.name));
                                              },
                                              child: Text(
                                                "+ ${"invite".tr()}"
                                                    .toUpperCase(),
                                                style: context
                                                    .buttonPrimaryUnderline
                                                    .copyWith(
                                                        color: Colors.white,
                                                        decorationThickness: 3),
                                              ),
                                            ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  GreyColorFiltered(
                                    isEnabled: data.isFinished,
                                    child: BackgroundContainer(
                                      isInclinationReversed: false,
                                      widthRatio: 0.75,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 10),
                                      foregroundColor: AppColors.primary,
                                      backgroundColor: AppColors.secondary,
                                      leadingChild: Text(
                                        formatDatePeriod(
                                            data.startsAt, data.endsAt),
                                        style: context.bodyBold
                                            .copyWith(color: Colors.white),
                                      ),
                                      trailingChild: Text(
                                        data.isFinished
                                            ? "ended".tr()
                                            : daysLeftFormatted(data.daysLeft),
                                        textAlign: TextAlign.center,
                                        style: context.bodyBold
                                            .copyWith(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 24,
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: _RankSection(
                          scrollController: _scrollController,
                          isPouleFinished: data.isFinished,
                        ),
                      ),
                      !isExpanded
                          ? Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const SizedBox(
                                            height: 24,
                                          ),
                                          PredictionStatWidget(
                                              totalPredictions:
                                                  data.tipCountTotal,
                                              wonPredictions: data.tipCountWon,
                                              lostPredictions:
                                                  data.tipCountLost,
                                              title: "predictionsInPoule"
                                                  .tr(args: [data.name])),
                                          data.isPublicLeague
                                              ? Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    const SizedBox(
                                                      height: 24,
                                                    ),
                                                    PrizePouleText(
                                                      text: "prizePool".tr(),
                                                      amount:
                                                          data.prizePool ?? 0,
                                                    ),
                                                    const SizedBox(
                                                      height: 12,
                                                    ),
                                                    TrophyPedestal(
                                                        coinsForFirst: data
                                                                .publicPouleData
                                                                ?.coinsForFirst ??
                                                            0,
                                                        coinsForSecond: data
                                                                .publicPouleData
                                                                ?.coinsForSecond ??
                                                            0,
                                                        coinsForThird: data
                                                                .publicPouleData
                                                                ?.coinsForThird ??
                                                            0,
                                                        coinsForOthers: data
                                                                .publicPouleData
                                                                ?.coinsForOthers ??
                                                            0),
                                                  ],
                                                )
                                              : const SizedBox(),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 24,
                                ),
                                _PredictionsSection(
                                  scrollController: _scrollController,
                                ),
                              ],
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }
}

class _TrophyPrimaryButton extends StatelessWidget {
  const _TrophyPrimaryButton({
    super.key,
    required this.data,
  });

  final LeagueDetail data;

  @override
  Widget build(BuildContext context) {
    final bool hasEnded = data.isFinished;
    if (hasEnded) {
      return PrimaryButton(
          prefixIcon: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 14.0),
              child: Container(
                decoration: const BoxDecoration(
                  boxShadow: [AppShadows.dropShadowText],
                ),
                child: const Icon(
                  BetterUnited.remove,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
          ),
          confineInSafeArea: false,
          text: "removePoule".tr(),
          onPressed: () async {
            await context.read<PouleProvider>().removePoule();
            context.read<PoulesProvider>().removePoule(data.pouleType, data.id);
            context.pop();
          });
    }

    if (data.predictionsLeft == 0) {
      return GreyColorFiltered(
        child: TrophyPrimaryButton(
          text: "predictionShared".tr(),
          onPressed: null,
          predictionsLeft: data.predictionsLeft,
        ),
      );
    }

    return TrophyPrimaryButton(
      text: "createPrediction".tr(),
      onPressed: () async {
        await Navigator.of(context).push(
            CreatePredictionPage.route(poule: data, pouleType: data.pouleType));
        context.read<PouleProvider>().refreshDetail();
      },
      predictionsLeft: data.predictionsLeft,
    );
  }
}

class _RankSection extends StatelessWidget {
  const _RankSection(
      {required this.scrollController, required this.isPouleFinished});

  final ScrollController scrollController;
  final int itemHeight = 122;
  final bool isPouleFinished;

  @override
  Widget build(BuildContext context) {
    final participants = context.watch<PouleProvider>().participants;
    final bool isExpanded = context.watch<PouleProvider>().isExpanded;
    final int collapsedPlayerLength =
        context.read<PouleProvider>().collapsedPlayerLength;
    return Column(
      children: [
        participants.isEmpty || participants.length == 1
            ? _buildEmptyPlayers(context, isPouleFinished)
            : _buildRankedPlayers(
                context,
                participants,
                isExpanded,
                context.read<PouleProvider>().connectedUserId,
                collapsedPlayerLength)
      ],
    );
  }

  Column _buildRankedPlayers(
      BuildContext context,
      List<Participant> participants,
      bool isExpanded,
      int connectedUserId,
      int collapsedPlayerLength) {
    return Column(
      children: [
        ListView.separated(
          shrinkWrap: true,
          controller: scrollController,
          separatorBuilder: (context, index) {
            final maxIndex = participants.length - 1;
            late final bool shouldDrawSeperator;
            if (index == maxIndex) {
              shouldDrawSeperator = false;
            } else {
              final currentParticiapnt = participants[index];
              final nextParticipant = participants[index + 1];
              if ((nextParticipant.index - currentParticiapnt.index) > 1) {
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
            final participant = participants[index];
            final isConnectedUser = participant.userId == connectedUserId;
            return FriendRankWidget(
                drawPlus: false,
                coins: participant.earnedCoins,
                isConnectedUser: isConnectedUser,
                level: participant.level,
                onProfileTap: () {
                  _pushUserOverviewPage(context, participant);
                },
                name: participant.userNickname,
                levelName: participant.levelName,
                profileUrl: participant.userProfilePictureUrl,
                points: participant.userPointsEarned,
                wins: participant.userTipCountWon,
                highestOdd: participant.userHighestOdd,
                powerUpsUsed: participant.userPowerupsUsed,
                rank: participant.userRank);
          },
          itemCount: participants.length,
        ),
        !isExpanded
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 23.0),
                child: GestureDetector(
                    onTap: () {
                      context.read<PouleProvider>().toggleExpandPlayerList();
                    },
                    child: SeeMoreButton(
                      isExpanded: isExpanded,
                    )),
              )
            : const SizedBox(),
      ],
    );
  }

  Widget _buildEmptyPlayers(BuildContext context, bool isPouleFinished) {
    return Column(
      children: [
        const SizedBox(height: 55),
        SvgPicture.asset("assets/images/ic_trophy.svg",
            height: 55, color: AppColors.buttonInnactive),
        const SizedBox(
          height: 10,
        ),
        Text(
          "noParticipants".tr(),
          style: context.bodyRegularWhite,
        ),
        const SizedBox(
          height: 5,
        ),
        Text("inviteParticipants".tr(), style: context.bodyRegularWhite),
        const SizedBox(
          height: 70,
        ),
        isPouleFinished
            ? const SizedBox()
            : _buildExpandedInviteFriendButton(context),
      ],
    );
  }

  _buildExpandedInviteFriendButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final data = context.read<PouleProvider>().poule;
        if (data == null) return;
        Navigator.of(context).push(InviteFriendsPage.route(
            poolPrize: data.prizePool ?? 0,
            entryFee: data.entryFee,
            pouleId: data.id,
            leagueLogoUrl: data.publicPouleData?.imageUrl,
            withCloseButton: true,
            pouleType: data.pouleType,
            pouleName: data.name));
      },
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 120,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
              color: AppColors.primary, borderRadius: BorderRadius.circular(4)),
          child: Text(
            "+ ${"invite".tr()}".toUpperCase(),
            style: context.bodyBold.copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  void _pushUserOverviewPage(BuildContext context, Participant participant) {
    Navigator.of(context).push(UserOverviewPage.route(
      level: participant.level,
      isFollowingAuthor: false,
      userId: participant.userId,
      rank: participant.userRank,
      nickname: participant.userNickname,
      levelName: participant.levelName,
      photoUrl: participant.userProfilePictureUrl,
      points: participant.userPointsEarned,
      pouleType: context.read<PouleProvider>().pouleType,
      pouleId: context.read<PouleProvider>().pouleId,
      poule: context.read<PouleProvider>().poule,
    ));
  }
}

class _BottomNavigationBar extends StatelessWidget {
  const _BottomNavigationBar();

  @override
  Widget build(BuildContext context) {
    final isExpanded = context.watch<PouleProvider>().isExpanded;
    return isExpanded
        ? Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            margin: const EdgeInsets.only(bottom: 12),
            color: AppColors.background,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    context.read<PouleProvider>().toggleExpandPlayerList();
                  },
                  child: SeeMoreButton(
                    isExpanded: isExpanded,
                  ),
                ),
              ],
            ),
          )
        : const SizedBox();
  }
}

class _PredictionsSection extends StatefulWidget {
  const _PredictionsSection({required this.scrollController});

  final ScrollController scrollController;

  @override
  State<_PredictionsSection> createState() => _PredictionsSectionState();
}

class _PredictionsSectionState extends State<_PredictionsSection>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 2, vsync: this);
  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController.addListener(() {
      _tabController.index == 0
          ? {
              context.read<PouleProvider>().getUserPredictions(),
              _textController.clear()
            }
          : context.read<PouleProvider>().getOtherPredictions();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filterCriteria = context.watch<PouleProvider>().filterCriteria;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "predictionShared".tr().toUpperCase(),
                  style: context.titleH2.copyWith(color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              InfoBubble(description: "predictionDisplayInfo".tr()),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: CustomTabBar(
                  firstTabText: "myPredictions".tr(),
                  secondTabText: "otherPrediction".tr(),
                  tabController: _tabController),
            ),
            const SizedBox(
              height: 16,
            ),
            Column(
              children: [
                filterCriteria.onlyOthers ?? false
                    ? Padding(
                        padding: const EdgeInsets.only(
                            left: 24.0, right: 24, bottom: 16),
                        child: InputField(
                          controller: _textController,
                          prefixIcon: const Icon(
                            BetterUnited.search,
                          ),
                          hintText: "searchPlayerByName".tr(),
                          onChanged: (value) {
                            context
                                .read<PouleProvider>()
                                .filterPredictionsByPlayerName(value);
                          },
                        ),
                      )
                    : const SizedBox(),
                TipList(
                  onProfileTap: (tipDetail) {
                    final participant = context
                        .read<PouleProvider>()
                        .getParticipantById(tipDetail.userId);
                    if (participant != null) {
                      Navigator.of(context).push(UserOverviewPage.route(
                        level: participant.level,
                        isFollowingAuthor: false,
                        userId: tipDetail.userId,
                        rank: participant.userRank,
                        nickname: participant.userNickname,
                        levelName: participant.levelName,
                        photoUrl: participant.userProfilePictureUrl,
                        points: participant.userPointsEarned,
                        pouleType: context.read<PouleProvider>().pouleType,
                        pouleId: context.read<PouleProvider>().pouleId,
                        poule: context.read<PouleProvider>().poule,
                      ));
                    }
                  },
                  pouleName: context.read<PouleProvider>().poule?.name ?? "",
                  pouleType: context.read<PouleProvider>().poule?.pouleType ??
                      PouleType.public,
                  emptyWidget: Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: _textController.text.isEmpty
                        ? const SizedBox()
                        : EmptySearchResult(
                            query: _textController.text,
                            text: "noMatchFound".tr(),
                          ),
                  ),
                  filterCriteria: filterCriteria,
                  scrollController: widget.scrollController,
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
