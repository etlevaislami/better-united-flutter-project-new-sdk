import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/data/model/football_match.dart';
import 'package:flutter_better_united/figma/text_styles.dart';
import 'package:flutter_better_united/pages/create_prediction/create_prediction_provider.dart';
import 'package:flutter_better_united/widgets/team_icon.dart';
import 'package:provider/provider.dart';

import '../../../figma/colors.dart';
import '../../../util/betterUnited_icons.dart';
import '../../../widgets/PouleFromPredictionCard.dart';
import '../../../widgets/date_picker.dart';
import '../../../widgets/favorite_club_list.dart';
import '../../../widgets/friend_poule_icon.dart';
import '../../../widgets/horizontal_date_picker.dart';
import '../../../widgets/league_icon.dart';
import '../../../widgets/match_card.dart';
import '../../../widgets/prediction_limit_message.dart';
import '../../../widgets/regular_app_bar.dart';
import '../../../widgets/sliver_loading_indicator.dart';
import '../modals/confirm_exit_dialog.dart';

class ChooseMatchPage extends StatefulWidget {
  const ChooseMatchPage({super.key});

  @override
  State<ChooseMatchPage> createState() => _ChooseMatchPageState();
}

class _ChooseMatchPageState extends State<ChooseMatchPage>
    with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    final provider = context.read<CreatePredictionProvider>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.fetchMatches(provider.selectedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    final match = context
        .watch<CreatePredictionProvider>()
        .selectedPoule
        ?.publicPouleData
        ?.getSingleMatch();
    return Scaffold(
      appBar: RegularAppBar.withBackButton(
          onBackTap: context.read<CreatePredictionProvider>().steps.first !=
                  CreatePredictionStep.selectMatch
              ? () {
                  context.read<CreatePredictionProvider>().onBackClicked();
                }
              : null,
          onCloseTap: () {
            showConfirmExitDialog(context);
          },
          title: "createPrediction".tr()),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        "chosenPoule".tr().toUpperCase(),
                        style: const TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const _ChosenPoule(),
                      const SizedBox(
                        height: 24,
                      ),
                    ],
                  ),
                ),
                match == null ? const _DatePicker() : const SizedBox(),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
          match != null
              ? SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "matchSchedules".tr().toUpperCase(),
                          style: AppTextStyles.textStyle1,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        GestureDetector(
                          onTap: () {
                            context
                                .read<CreatePredictionProvider>()
                                .onMatchSelected(match);
                          },
                          child: MatchCard(
                              matchDate: match.startsAt,
                              homeTeam: match.homeTeam,
                              awayTeam: match.awayTeam),
                        ),
                      ],
                    ),
                  ),
                )
              : _MatchesByLeague(
                  scrollController: _scrollController,
                  onMatchTap: (match) {
                    if (match.isAllowedToBet) {
                      context
                          .read<CreatePredictionProvider>()
                          .onMatchSelected(match);
                    } else {
                      final maximumTipCountPerMatch = context
                          .read<CreatePredictionProvider>()
                          .selectedPoule
                          ?.publicPouleData
                          ?.maximumTipCountPerMatch;
                      PredictionLimitMessage.showToast(context,
                          maximumTipCountPerMatch: maximumTipCountPerMatch);
                    }
                  }),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _DatePicker extends StatelessWidget {
  const _DatePicker();

  @override
  Widget build(BuildContext context) {
    final selectedDate = context.watch<CreatePredictionProvider>().selectedDate;
    final startDate = context.read<CreatePredictionProvider>().startDate;
    final endDate = context.read<CreatePredictionProvider>().endDate;
    final todayDate = context.read<CreatePredictionProvider>().todayDate;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
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
                    date: selectedDate,
                    firstDate: startDate,
                    lastDate: endDate,
                  );
                  if (date != null) {
                    context
                        .read<CreatePredictionProvider>()
                        .onDateSelected(date);
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
        ),
        const SizedBox(
          height: 16,
        ),
        HorizontalDatePicker(
          begin: startDate,
          end: endDate,
          selectedDate: selectedDate,
          onSelected: (date) {
            context.read<CreatePredictionProvider>().onDateSelected(date);
          },
          todayDate: todayDate,
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.icon, required this.text});

  final Widget icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 32,
          width: 32,
          child: icon,
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Text(text, style: AppTextStyles.textStyle2),
        ),
      ],
    );
  }
}

class _ChosenPoule extends StatelessWidget {
  const _ChosenPoule();

  @override
  Widget build(BuildContext context) {
    final poule = context.watch<CreatePredictionProvider>().selectedPoule;
    if (poule == null) {
      return const SizedBox();
    }

    late Widget icon;
    if (poule.publicPouleData != null) {
      icon = LeagueIconWithPlaceholder(
        logoUrl: poule.publicPouleData?.imageUrl,
      );
    } else {
      icon = const FriendPouleIcon();
    }
    return PouleFromPredictionCard(
      pouleName: poule.name,
      predictionLeft: poule.predictionsLeft,
      startDate: poule.startsAt,
      endDate: poule.endsAt,
      hasEnded: poule.isFinished,
      icon: icon,
    );
  }
}

class _FavoriteClubsList extends StatelessWidget {
  final ScrollController controller;

  const _FavoriteClubsList({required this.controller});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CreatePredictionProvider>();
    return provider.matchesFromFavoriteClubs.isEmpty
        ? const SizedBox()
        : FavoriteClubsList(
            controller: controller,
            matches: provider.matchesFromFavoriteClubs,
            onTap: () {
              provider.onMatchSelected(provider.matchesFromFavoriteClubs.first);
            },
          );
  }
}

class _MatchesByLeague extends StatelessWidget {
  final ScrollController scrollController;
  final Function(FootballMatch) onMatchTap;

  const _MatchesByLeague({
    required this.scrollController,
    required this.onMatchTap,
  });

  @override
  Widget build(BuildContext context) {
    final matchesByLeagues =
        context.watch<CreatePredictionProvider>().matchesByLeagues;

    if (matchesByLeagues == null) {
      return const SliverLoadingIndicator();
    }

    if (matchesByLeagues.isEmpty) {
      return SliverFillRemaining(
        child: Center(
          child: Text("noMatches".tr()),
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      sliver: SliverList.separated(
        itemCount: matchesByLeagues.length,
        itemBuilder: (context, index) {
          final groupedMatches = matchesByLeagues[index];
          return Column(
            children: [
              _Header(
                icon: TeamIcon(
                  invertColor: true,
                  height: 32,
                  logoUrl: groupedMatches.leagueLogoUrl,
                ),
                text: groupedMatches.leagueName,
              ),
              const SizedBox(
                height: 16,
              ),
              ListView.separated(
                  shrinkWrap: true,
                  controller: scrollController,
                  itemBuilder: (context, index) {
                    final match = groupedMatches.matches[index];
                    return GestureDetector(
                      onTap: () => onMatchTap(match),
                      child: Opacity(
                        opacity: match.isAllowedToBet ? 1 : 0.5,
                        child: MatchCard(
                            matchDate: match.startsAt,
                            homeTeam: match.homeTeam,
                            awayTeam: match.awayTeam),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 16,
                    );
                  },
                  itemCount: groupedMatches.matches.length),
            ],
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 16,
          );
        },
      ),
    );
  }
}
