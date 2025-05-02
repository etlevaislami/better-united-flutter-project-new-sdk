import 'package:easy_localization/easy_localization.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/figma/colors.dart';
import 'package:flutter_better_united/util/betterUnited_icons.dart';
import 'package:flutter_better_united/widgets/info_bubble.dart';
import 'package:flutter_better_united/widgets/input_field.dart';
import 'package:flutter_better_united/widgets/team_icon.dart';
import 'package:provider/provider.dart';

import '../../../data/model/football_matches_by_league.dart';
import '../../../figma/text_styles.dart';
import '../../../util/Debouncer.dart';
import '../../../widgets/date_picker.dart';
import '../../../widgets/favorite_club_list.dart';
import '../../../widgets/horizontal_date_picker.dart';
import '../../../widgets/match_card.dart';
import '../../../widgets/sliver_loading_indicator.dart';
import '../create_friend_poule_provider.dart';

class ChooseMatchPage extends StatefulWidget {
  const ChooseMatchPage({Key? key}) : super(key: key);

  @override
  State<ChooseMatchPage> createState() => _ChooseMatchPageState();
}

class _ChooseMatchPageState extends State<ChooseMatchPage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final _searchTextDebouncer = Debouncer();
  final _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void dispose() {
    _scrollController.dispose();
    _searchTextDebouncer.dispose();
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    final provider = context.read<CreateFriendPouleProvider>();
    _searchFocusNode.addListener(() {
      if (_searchController.text.isEmpty && !_searchFocusNode.hasFocus) {
        provider.onDateSelected(provider.todayDate);
      }
    });
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        provider.fetchMatches(date: provider.selectedDate);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final createFriendPouleProvider =
        context.watch<CreateFriendPouleProvider>();

    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InfoBubble(description: "competeWithFriends".tr()),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "matchSchedules".tr().toUpperCase(),
                            style: AppTextStyles.textStyle1,
                          ),
                          GestureDetector(
                            onTap: () async {
                              final date = await DatePicker.showDate(
                                context,
                                date: createFriendPouleProvider.selectedDate,
                                firstDate: createFriendPouleProvider.todayDate,
                                lastDate: createFriendPouleProvider.endDate,
                              );
                              if (date != null) {
                                createFriendPouleProvider.onDateSelected(date);
                                _searchController.clear();
                                _searchFocusNode.unfocus();
                              }
                            },
                            child: const Icon(
                              BetterUnited.calendar,
                              size: 20,
                              color: AppColors.primary,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      InputField(
                        focusNode: _searchFocusNode,
                        prefixIcon: const Icon(BetterUnited.search),
                        hintText: "searchMatch".tr(),
                        controller: _searchController,
                        onChanged: (value) {
                          _searchTextDebouncer.run(() {
                            createFriendPouleProvider.onSearchMatch(value);
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                HorizontalDatePicker(
                  begin: createFriendPouleProvider.startDate,
                  end: createFriendPouleProvider.endDate,
                  selectedDate: createFriendPouleProvider.selectedDate,
                  onSelected: (date) {
                    if (date.isBefore(createFriendPouleProvider.todayDate)) {
                      return;
                    }
                    createFriendPouleProvider.onDateSelected(date);
                    _searchController.clear();
                    _searchFocusNode.unfocus();
                  },
                  todayDate: createFriendPouleProvider.todayDate,
                ),
              ],
            ),
          ),
          _FavoriteClubsList(controller: _scrollController),
          const _Data(),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => false;
}

class _Data extends StatelessWidget {
  const _Data({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final footballMatchesByLeagues =
        context.watch<CreateFriendPouleProvider>().matchesByLeagues;
    final selectedDate =
        context.watch<CreateFriendPouleProvider>().selectedDate;
    if (footballMatchesByLeagues == null) {
      return const SliverLoadingIndicator();
    }
    if (footballMatchesByLeagues.isEmpty) {
      return SliverFillRemaining(
        child: Center(
          child: Text("noMatches".tr()),
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.only(top: 16),
      sliver: SliverList.separated(
        itemBuilder: (context, index) {
          final footballMatchesByLeague = footballMatchesByLeagues[index];
          return Container(
            color: AppColors.secondary,
            child: _ExpandablePanel(
              footballMatchesByLeague: footballMatchesByLeague,
              isInitiallyExpanded: selectedDate == null,
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 16,
          );
        },
        itemCount: footballMatchesByLeagues.length,
      ),
    );
  }
}

class _FavoriteClubsList extends StatelessWidget {
  final ScrollController controller;

  const _FavoriteClubsList({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CreateFriendPouleProvider>();
    return SliverToBoxAdapter(
      child: provider.matchesFromFavoriteClubs.isEmpty
          ? const SizedBox()
          : FavoriteClubsList(
              controller: controller,
              matches: provider.matchesFromFavoriteClubs,
              onTap: () {
                provider
                    .onMatchSelected(provider.matchesFromFavoriteClubs.first);
              },
            ),
    );
  }
}

class _ExpandablePanel extends StatefulWidget {
  const _ExpandablePanel(
      {super.key,
      required this.footballMatchesByLeague,
      required this.isInitiallyExpanded});

  final FootballMatchesByLeague footballMatchesByLeague;
  final bool isInitiallyExpanded;

  @override
  State<_ExpandablePanel> createState() => _ExpandablePanelState();
}

class _ExpandablePanelState extends State<_ExpandablePanel> {
  late final _controller =
      ExpandableController(initialExpanded: widget.isInitiallyExpanded);

  @override
  void didUpdateWidget(covariant _ExpandablePanel oldWidget) {
    if (oldWidget.footballMatchesByLeague != widget.footballMatchesByLeague ||
        oldWidget.isInitiallyExpanded != widget.isInitiallyExpanded) {
      setState(() {});
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ExpandablePanel(
      controller: _controller,
      header: SizedBox(
        height: 48,
        child: Row(
          children: [
            const SizedBox(
              width: 24,
            ),
            TeamIcon(
              height: 32,
              invertColor: true,
              logoUrl: widget.footballMatchesByLeague.leagueLogoUrl,
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Text(
                widget.footballMatchesByLeague.leagueName.toUpperCase(),
                style: AppTextStyles.textStyle2,
              ),
            ),
          ],
        ),
      ),
      collapsed: const SizedBox(),
      expanded: Container(
        color: AppColors.background,
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
        child: ListView.separated(
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final match = widget.footballMatchesByLeague.matches[index];
              return GestureDetector(
                onTap: () {
                  context
                      .read<CreateFriendPouleProvider>()
                      .onMatchSelected(match);
                },
                child: MatchCard(
                  matchDate: match.startsAt,
                  homeTeam: match.homeTeam,
                  awayTeam: match.awayTeam,
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 16,
              );
            },
            itemCount: widget.footballMatchesByLeague.matches.length),
      ),
      theme: const ExpandableThemeData(
        headerAlignment: ExpandablePanelHeaderAlignment.center,
        tapBodyToCollapse: true,
        tapBodyToExpand: true,
        hasIcon: true,
        iconColor: Colors.white,
        iconSize: 16,
        iconPadding: EdgeInsets.symmetric(horizontal: 24),
        collapseIcon: BetterUnited.arrowUp,
        expandIcon: BetterUnited.arrowUp,
      ),
    );
  }
}
