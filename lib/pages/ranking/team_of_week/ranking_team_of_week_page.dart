import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/data/model/team_of_week.dart';
import 'package:flutter_better_united/figma/colors.dart';
import 'package:flutter_better_united/figma/dimensions.dart';
import 'package:flutter_better_united/pages/ranking/ranking_team_of_week_info_dialog.dart';
import 'package:flutter_better_united/pages/ranking/team_of_week/ranking_field.dart';
import 'package:flutter_better_united/pages/ranking/team_of_week/team_of_week_app_bar_message.dart';
import 'package:flutter_better_united/util/notifications/handlers/team_of_week_ranking_handler.dart';
import 'package:flutter_better_united/widgets/regular_app_bar.dart';

class RankingTeamOfWeekPage extends StatefulWidget {
  const RankingTeamOfWeekPage({
    Key? key,
    required this.teamOfWeek,
  }) : super(key: key);

  final TeamOfWeek teamOfWeek;

  @override
  State<RankingTeamOfWeekPage> createState() => _RankingTeamOfWeekPageState();

  static Route route({required TeamOfWeek teamOfWeek}) {
    return CupertinoPageRoute(
        fullscreenDialog: true,
        builder: (_) => RankingTeamOfWeekPage(
              teamOfWeek: teamOfWeek,
            ));
  }
}

class _RankingTeamOfWeekPageState extends State<RankingTeamOfWeekPage> {
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
              subTitle: 'topElevenPlayersOfTheWeek'.tr(),
              title: "teamOfTheWeek".tr(),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: AppDimensions.teamOfWeekAppBarHeight - 40,
          bottom: 10,
        ),
        child: RankingField(
          rankings: widget.teamOfWeek.team,
        ),
      ),
    );
  }

  void _showInfoDialog(BuildContext context) {
    RankingTeamOfWeekInfoDialog.displayDialog(context, widget.teamOfWeek);
  }
}
