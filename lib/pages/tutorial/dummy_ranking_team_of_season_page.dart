import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/data/model/team_of_season.dart';
import 'package:flutter_better_united/figma/colors.dart';
import 'package:flutter_better_united/figma/dimensions.dart';
import 'package:flutter_better_united/pages/ranking/team_of_season/ranking_team_of_season_info_dialog.dart';
import 'package:flutter_better_united/pages/ranking/team_of_week/ranking_field.dart';
import 'package:flutter_better_united/pages/ranking/team_of_week/team_of_week_app_bar_message.dart';
import 'package:flutter_better_united/widgets/regular_app_bar.dart';

class DummyRankingTeamOfSeasonPage extends StatefulWidget {
  const DummyRankingTeamOfSeasonPage(
      {Key? key,
      required this.teamOfSeason,
      this.unblurredTeamOfSeasonSectionKey})
      : super(key: key);
  final GlobalKey? unblurredTeamOfSeasonSectionKey;
  final TeamOfSeason teamOfSeason;

  @override
  State<DummyRankingTeamOfSeasonPage> createState() =>
      _RankingTeamOfWeekPageState();
}

class _RankingTeamOfWeekPageState extends State<DummyRankingTeamOfSeasonPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.background,
      appBar: RegularAppBarV7(
        onInfoTap: () {
          _showInfoDialog(context);
        },
        onBackTap: () {
          context.pop();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 44),
          child: Align(
            alignment: Alignment.topCenter,
            child: TeamOfWeekAppBarMessage(
              subTitle: 'topElevenPlayersOfTheSeason'.tr(),
              title: "teamOfTheSeason".tr(),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: AppDimensions.teamOfWeekAppBarHeight,
        ),
        child: Stack(
          children: [
            RankingField(
              // rankings: widget.rankings,
              rankings: widget.teamOfSeason.team,
            ),
            IgnorePointer(
              child: Padding(
                padding: const EdgeInsets.only(top: 18.0, left: 25, right: 20,),
                child: SizedBox(
                  key: widget.unblurredTeamOfSeasonSectionKey,
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: double.infinity,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showInfoDialog(BuildContext context) {
    RankingTeamOfSeasonInfoDialog.displayDialog(context, widget.teamOfSeason);
  }
}
