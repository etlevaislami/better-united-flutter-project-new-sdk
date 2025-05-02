import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/constants/extended_theme.dart';
import 'package:flutter_better_united/data/model/team_of_season.dart';
import 'package:flutter_better_united/util/date_util.dart';
import 'package:flutter_better_united/widgets/bottom_sheet_base_dialog.dart';
import 'package:flutter_better_united/widgets/primary_button.dart';
import 'package:flutter_better_united/widgets/trophy_pedestal.dart';
import 'package:in_date_utils/in_date_utils.dart';

class RankingTeamOfSeasonInfoDialog extends StatelessWidget {
  const RankingTeamOfSeasonInfoDialog({
    Key? key,
    required this.teamOfSeason,
  }) : super(key: key);

  final TeamOfSeason teamOfSeason;

  static Future<dynamic> displayDialog(
      BuildContext context, TeamOfSeason teamOfSeason) {
    return showDialog(
      useSafeArea: false,
      barrierDismissible: false,
      context: context,
      useRootNavigator: false,
      builder: (context) =>
          RankingTeamOfSeasonInfoDialog(teamOfSeason: teamOfSeason),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final dateTime = teamOfSeason.startDate;
    // DateFormat monthNameFormat = DateFormat.MMMM();



    // final periodText = "teamOfSeasonPeriodFormatted".tr(namedArgs: {
    //   "monthStart": monthNameFormat.format(teamOfSeason.startDate),
    //   "monthEnd": monthNameFormat.format(
    //       DateTime(dateTime.year, DateTimeUtils.nextMonth(dateTime))),
    //   "year": dateTime.year.toString(),
    // });
    // teamOfWeekWeekFormatted
    return BottomSheetBaseDialog(
      icon: Transform.translate(
        offset: const Offset(0, -10),
        child: Transform.scale(
          scale: 1.2,
          child: Image.asset("assets/images/bu_bubble.png"),
        ),
      ),
      withAnimation: false,
      withConfetti: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(
            height: 18,
          ),
          Text("teamOfTheSeasonInfoDialogTitle".tr().toUpperCase(),
              textAlign: TextAlign.center, style: context.titleH1),
          const SizedBox(
            height: 15,
          ),
          Text(
            formatSeasonalPeriod(teamOfSeason.startDate, teamOfSeason.endDate),
            style: context.bodyRegularWhite.copyWith(
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              "teamOfTheSeasonInfoDialogDescription".tr(),
              style: context.bodyRegularWhite,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),

            /// TODO get the values from pouleProvider..? (not sure since that data depends on specific pouleId)
            child: TrophyPedestal(
              coinsForOthers: 200,
              coinsForFirst: 5000,
              coinsForSecond: 3000,
              coinsForThird: 2000,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: PrimaryButton(
              confineInSafeArea: false,
              text: "ok".tr(),
              onPressed: () {
                context.pop();
              },
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
