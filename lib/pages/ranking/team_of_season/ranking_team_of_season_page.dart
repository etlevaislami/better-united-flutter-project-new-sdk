import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/data/model/ranked_participant.dart';
import 'package:flutter_better_united/data/model/team_of_season.dart';
import 'package:flutter_better_united/figma/colors.dart';
import 'package:flutter_better_united/figma/dimensions.dart';
import 'package:flutter_better_united/pages/dialog/team_of_week_weekly_rank_dialog.dart';
import 'package:flutter_better_united/pages/ranking/ranking_team_of_week_info_dialog.dart';
import 'package:flutter_better_united/pages/ranking/team_of_season/ranking_team_of_season_info_dialog.dart';
import 'package:flutter_better_united/pages/ranking/team_of_week/ranking_field.dart';
import 'package:flutter_better_united/pages/ranking/team_of_week/team_of_week_app_bar_message.dart';
import 'package:flutter_better_united/util/ui_util.dart';
import 'package:flutter_better_united/widgets/regular_app_bar.dart';

class RankingTeamOfSeasonPage extends StatefulWidget {
  const RankingTeamOfSeasonPage({
    Key? key,
    required this.teamOfSeason,
  }) : super(key: key);

  final TeamOfSeason teamOfSeason;

  @override
  State<RankingTeamOfSeasonPage> createState() => _RankingTeamOfWeekPageState();

  static Route route({required TeamOfSeason teamOfSeason}) {
    return CupertinoPageRoute(
        fullscreenDialog: true,
        builder: (_) => RankingTeamOfSeasonPage(
          teamOfSeason: teamOfSeason,
            ));
  }
}

class _RankingTeamOfWeekPageState extends State<RankingTeamOfSeasonPage> {
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
        padding:  const EdgeInsets.only(
          top: AppDimensions.teamOfWeekAppBarHeight,
        ),
        child: RankingField(
          // rankings: widget.rankings,
          rankings: widget.teamOfSeason.team,
        ),
      ),
    );
  }

  void _showInfoDialog(BuildContext context) {
    RankingTeamOfSeasonInfoDialog.displayDialog(context, widget.teamOfSeason);
  }
}
