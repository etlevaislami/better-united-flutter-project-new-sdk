import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/pages/home/active_poules_button.dart';
import 'package:flutter_better_united/pages/home/background/home_background_widget.dart';
import 'package:flutter_better_united/pages/home/home_page_content.dart';
import 'package:flutter_svg/svg.dart';

import '../../widgets/league_category.dart';

final List<Widget> _categories = [
  LeagueCategory(
    text: "allLeagues".tr(),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: SvgPicture.asset(
        "assets/icons/ic_all_leagues.svg",
      ),
    ),
    isActive: true,
  ),
  LeagueCategory(
    text: "premierLeague".tr(),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Image.asset(
        "assets/images/premier_league.png",
      ),
    ),
  ),
  LeagueCategory(
    text: "championLeague".tr(),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Image.asset(
        "assets/images/champion_league.png",
      ),
    ),
  )
];

class DummyHomePage extends StatelessWidget {
  DummyHomePage({
    required this.unblurredRightButtonKey,
    required this.unblurredLeftButtonKey,
    required this.unblurredActivePoulesButtonKey,
    Key? key,
  }) : super(key: key);
  final int coins = 100;

  final GlobalKey unblurredRightButtonKey;
  final GlobalKey unblurredLeftButtonKey;
  final GlobalKey unblurredActivePoulesButtonKey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          const BackgroundWidget(),
          HomePageContent(
            unblurredLeftButtonKey: unblurredLeftButtonKey,
            unblurredRightButtonKey: unblurredRightButtonKey,
          ),
        ],
      ),
      bottomNavigationBar: ActivePoulesButton(unblurredActivePoulesButtonKey: unblurredActivePoulesButtonKey),
    );
  }
}
