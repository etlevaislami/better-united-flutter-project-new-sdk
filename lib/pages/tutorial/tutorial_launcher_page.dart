import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/figma/dimensions.dart';
import 'package:flutter_better_united/pages/home/navigation/home_nav_items.dart';
import 'package:flutter_better_united/pages/nav_page.dart';
import 'package:flutter_better_united/pages/tutorial/dummy_choose_prediction_page.dart';
import 'package:flutter_better_united/pages/tutorial/dummy_home_page.dart';
import 'package:flutter_better_united/pages/tutorial/dummy_profile_page.dart';
import 'package:flutter_better_united/pages/tutorial/dummy_ranking_page.dart';
import 'package:flutter_better_united/pages/tutorial/dummy_ranking_team_of_season_page.dart';
import 'package:flutter_better_united/pages/tutorial/dummy_shop_page.dart';
import 'package:flutter_better_united/pages/tutorial/tutorial_walkthrough.dart';
import 'package:flutter_better_united/util/shape/path_utils.dart';
import 'package:flutter_better_united/widgets/bottom_nav_bar.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

import '../../constants/app_colors.dart';
import '../../data/net/models/tutorial.dart';
import '../../util/ui_util.dart';

/// Page that starts showing tutorials, starting at home, then choose prediction, then ranking, shop and profile.
class TutorialLauncherPage extends StatefulWidget {
  const TutorialLauncherPage({Key? key}) : super(key: key);
  static const route = "/tutorial";

  @override
  State<TutorialLauncherPage> createState() => _TutorialLauncherPageState();
}

class _TutorialLauncherPageState extends State<TutorialLauncherPage> {
  final GlobalKey _unblurredHomeMenuButtonKey = GlobalKey();
  final GlobalKey _unblurredLeftButtonKey = GlobalKey();
  final GlobalKey _unblurredRightButtonKey = GlobalKey();
  final GlobalKey _unblurredActivePoulesButtonKey = GlobalKey();

  final GlobalKey _unblurredMatchWidgetKey = GlobalKey();
  final GlobalKey _unblurredPredictionWidgetKey = GlobalKey();

  final GlobalKey _unblurredRankingMenuButtonKey = GlobalKey();
  final GlobalKey _unblurredWeeklyRankingSectionKey = GlobalKey();

  final GlobalKey _unblurredTeamOfSeasonSectionKey = GlobalKey();

  final GlobalKey _unblurredShopMenuButtonKey = GlobalKey();
  final GlobalKey _unblurredShopSectionKey = GlobalKey();

  final GlobalKey _unblurredProfileMenuButtonKey = GlobalKey();
  final GlobalKey _unblurredProfileSectionKey = GlobalKey();

  static const highLightedWidgetPadding = 10.0;
  static const highLightedMenuItemPadding =
      EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 6);
  final double bottomNavigationBarHeight = 100;

  late List<PersistentTabConfig>
      navItems;
  final PersistentTabController bottomMenuTabController =
      PersistentTabController(initialIndex: 0);

  late Widget dummyBottomMenuPage;

  Walkthrough currentWalkthrough = Walkthrough.home;

  @override
  void initState() {
    _initTutorials();

    navItems = HomeNavItems.getNavItems(
      homeIconKey: _unblurredHomeMenuButtonKey,
      rankingIconKey: _unblurredRankingMenuButtonKey,
      shopIconKey: _unblurredShopMenuButtonKey,
      profileIconKey: _unblurredProfileMenuButtonKey,
    ).asMap().entries.map((entry) {
      final index = entry.key;
      final item = entry.value;
      return PersistentTabConfig(
        screen: _getScreenForIndex(index),
        item: item,
      );
    }).toList();
    dummyBottomMenuPage = Scaffold(
      backgroundColor: AppColors.navBarBackground,
      bottomNavigationBar: _buildBottomNavigation(),
      resizeToAvoidBottomInset: false,
      extendBody: true,
    );
    super.initState();
  }

  Widget _getScreenForIndex(int index) {
    switch (index) {
      case 0:
        return DummyHomePage(
          unblurredActivePoulesButtonKey: _unblurredActivePoulesButtonKey,
          unblurredLeftButtonKey: _unblurredLeftButtonKey,
          unblurredRightButtonKey: _unblurredRightButtonKey,
        );
      case 1:
        return DummyRankingPage(
          unblurredWeeklyRankingSectionKey: _unblurredWeeklyRankingSectionKey,
        );
      case 2:
        return DummyShopPage(
          unblurredShopSectionKey: _unblurredShopSectionKey,
        );
      case 3:
        return DummyMyProfilePage(
          unblurredProfileSectionKey: _unblurredProfileSectionKey,
        );
      default:
        return SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (currentWalkthrough) {
      case Walkthrough.home:
        return _buildHomeWalkthrough();
      case Walkthrough.choosePrediction:
        return _buildChoosePredictionWalkthrough();
      case Walkthrough.ranking:
        return _buildRankingWalkthrough();
      case Walkthrough.teamOfSeason:
        return _buildTeamOfSeasonWalkthrough();
      case Walkthrough.shop:
        return _buildShopWalkthrough();
      case Walkthrough.profile:
        return _buildProfileWalkthrough();
      default:
        return SizedBox.shrink();
    }
  }

  Widget _buildBottomNavigation() {
    return WillPopScope(
      onWillPop: () async {
        // Disable back-press because this had issues.
        return false;
      },
      child: PersistentTabView(
        navBarBuilder: (navBarConfig) => BottomNavBar(
          navBarConfig: NavBarConfig(
            navBarHeight: NavPage.navBarHeight,
            onItemSelected: (value) {
              bottomMenuTabController.jumpToTab(value);
              navBarConfig.onItemSelected(value);
            },
            selectedIndex: bottomMenuTabController.index,
            items: navItems.map((config) => config.item).toList(),
          ),
          navBarHeight: NavPage.navBarHeight,
        ),
        tabs: navItems,
        controller: bottomMenuTabController,
        avoidBottomPadding: true,
        backgroundColor: AppColors.navBarBackground,
        handleAndroidBackButtonPress: false,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        navBarHeight: NavPage.navBarHeight,
        margin: EdgeInsets.zero,
        navBarOverlap: NavBarOverlap.custom(overlap: 0.0),
        hideNavigationBar: false,
      ),
    );
  }

  void _initTutorials() {}

  Widget _buildHomeWalkthrough() {
    final homeTutorials = [
      Tutorial(
        "tutorialHomeTitle".tr(),
        "tutorialHomeContent".tr(),
        10,
        _unblurredHomeMenuButtonKey,
        (offset, size) => PathUtils.getRoundedRectShapePath(offset, size,
            padding: highLightedMenuItemPadding),
        tapType: TapType.onWidget,
      ),
      Tutorial(
          "tutorialPublicPouleTitle".tr(),
          "tutorialPublicPouleContent".tr(),
          60,
          _unblurredLeftButtonKey,
          (offset, size) => PathUtils.getLeftHomeButtonShapePath(
                size,
                offset: offset,
                padding: const EdgeInsets.symmetric(
                    horizontal: highLightedWidgetPadding,
                    vertical: highLightedWidgetPadding),
              )),
      Tutorial(
          "tutorialFriendLeagueTitle".tr(),
          "tutorialFriendLeagueContent".tr(),
          60,
          _unblurredRightButtonKey,
          (offset, size) => PathUtils.getRightHomeButtonShapePath(
                size,
                offset: offset,
                padding: const EdgeInsets.symmetric(
                    horizontal: highLightedWidgetPadding,
                    vertical: highLightedWidgetPadding),
              )),
      Tutorial(
          "tutorialActivePoulesTitle".tr(),
          "tutorialActivePoulesContent".tr(),
          25,
          _unblurredActivePoulesButtonKey,
          (offset, size) => PathUtils.getRoundedRectShapePath(offset, size,
              padding: const EdgeInsets.symmetric(
                  horizontal: highLightedWidgetPadding,
                  vertical: highLightedWidgetPadding))),
    ];
    return TutorialWalkthrough(
      key: UniqueKey(),
      child: dummyBottomMenuPage,
      tutorials: homeTutorials,
      onFinished: () {
        setState(() {
          currentWalkthrough = Walkthrough.choosePrediction;
        });
      },
    );
  }

  Widget _buildChoosePredictionWalkthrough() {
    final choosePredictionTutorials = [
      Tutorial(
          "tutorialChosenMatchTitle".tr(),
          "tutorialChosenMatchDescription".tr(),
          60,
          _unblurredMatchWidgetKey,
          (offset, size) => PathUtils.getRoundedRectShapePath(
                offset,
                size,
                padding: const EdgeInsets.symmetric(
                    horizontal: highLightedWidgetPadding,
                    vertical: highLightedWidgetPadding),
              )),
      Tutorial(
          "tutorialPredictionIndicatorTitle".tr(),
          "tutorialPredictionIndicatorDescription".tr(),
          20,
          _unblurredPredictionWidgetKey,
          (offset, size) => PathUtils.getRoundedRectShapePath(
                offset,
                size,
                padding: const EdgeInsets.only(
                  // + more space because the POPULAR / ADDITIONAL header should be highlighted as well.
                  top: highLightedWidgetPadding + 70,
                  bottom: highLightedWidgetPadding,
                  // Minus padding because the highlighted widget spans the full width. Instead of making changes in the actual UI this will sure not break anything.
                  left: -15,
                  right: -15,
                ),
              )),
    ];

    return TutorialWalkthrough(
      key: UniqueKey(),
      child: DummyChoosePredictionPage(
        unblurredMatchWidgetKey: _unblurredMatchWidgetKey,
        unblurredPredictionWidgetKey: _unblurredPredictionWidgetKey,
      ),
      tutorials: choosePredictionTutorials,
      onFinished: () {
        setState(() {
          currentWalkthrough = Walkthrough.ranking;
          bottomMenuTabController.jumpToTab(1);
        });
      },
    );
  }

  Widget _buildRankingWalkthrough() {
    final rankingTutorials = [
      Tutorial(
          "tutorialRankingTitle".tr(),
          "tutorialRankingDescription".tr(),
          10,
          _unblurredRankingMenuButtonKey,
          tapType: TapType.onWidget,
          (offset, size) => PathUtils.getRoundedRectShapePath(
                offset,
                size,
                padding: highLightedMenuItemPadding,
              )),
      Tutorial(
          "tutorialRankingTwoTitle".tr(),
          "tutorialRankingTwoDescription".tr(),
          73,
          _unblurredWeeklyRankingSectionKey,
          (offset, size) => PathUtils.getRoundedRectShapePath(
                offset,
                size,
                padding: const EdgeInsets.only(
                    left: highLightedWidgetPadding,
                    right: highLightedWidgetPadding,
                    top: highLightedWidgetPadding,
                    // Additional space to make sure the first participant is highlighted as well.
                    bottom: highLightedWidgetPadding + 86),
              )),
    ];

    return TutorialWalkthrough(
      key: UniqueKey(),
      child: dummyBottomMenuPage,
      tutorials: rankingTutorials,
      onFinished: () {
        setState(() {
          currentWalkthrough = Walkthrough.teamOfSeason;
        });
      },
    );
  }

  Widget _buildTeamOfSeasonWalkthrough() {
    final teamOfSeasonTutorials = [
      Tutorial(
          "tutorialRankingTeamOfSeasonTitle".tr(),
          "tutorialRankingTeamOfSeasonDescription".tr(),
          37,
          _unblurredTeamOfSeasonSectionKey,
          (offset, size) => PathUtils.getRoundedRectShapePath(
                offset,
                size,
                padding: highLightedMenuItemPadding,
              )),
    ];

    return TutorialWalkthrough(
      key: UniqueKey(),
      child: DummyRankingTeamOfSeasonPage(
        teamOfSeason: RankingDummyData.teamOfSeason,
        unblurredTeamOfSeasonSectionKey: _unblurredTeamOfSeasonSectionKey,
      ),
      tutorials: teamOfSeasonTutorials,
      onFinished: () {
        setState(() {
          currentWalkthrough = Walkthrough.shop;
          bottomMenuTabController.jumpToTab(2);
        });
      },
    );
  }

  Widget _buildShopWalkthrough() {
    final shopTutorials = [
      Tutorial(
          "tutorialShopTitle".tr(),
          "tutorialShopDescription".tr(),
          10,
          _unblurredShopMenuButtonKey,
          tapType: TapType.onWidget,
          (offset, size) => PathUtils.getRoundedRectShapePath(
                offset,
                size,
                padding: highLightedMenuItemPadding,
              )),
      Tutorial(
          "tutorialShopTwoTitle".tr(),
          "tutorialShopTwoDescription".tr(),
          22,
          _unblurredShopSectionKey,
          (offset, size) => PathUtils.getRoundedRectShapePath(
                offset,
                size,
                padding: const EdgeInsets.only(
                    left: highLightedWidgetPadding,
                    right: highLightedWidgetPadding,
                    top: highLightedWidgetPadding,
                    // Additional space to make sure two shop items are highlighted as well.
                    bottom: highLightedWidgetPadding +
                        AppDimensions.shopOfferItemSeparatorSpace +
                        AppDimensions.shopTabBarBottomSpace +
                        2 * AppDimensions.shopOfferItemHeight),
              )),
    ];

    return TutorialWalkthrough(
      key: UniqueKey(),
      child: dummyBottomMenuPage,
      tutorials: shopTutorials,
      onFinished: () {
        setState(() {
          currentWalkthrough = Walkthrough.profile;
          bottomMenuTabController.jumpToTab(3);
        });
      },
    );
  }

  Widget _buildProfileWalkthrough() {
    final tutorials = [
      Tutorial(
          "tutorialProfileTitle".tr(),
          "tutorialProfileDescription".tr(),
          10,
          _unblurredProfileMenuButtonKey,
          tapType: TapType.onWidget,
          (offset, size) => PathUtils.getRoundedRectShapePath(
                offset,
                size,
                padding: highLightedMenuItemPadding,
              )),
      Tutorial(
          "tutorialProfileTwoTitle".tr(),
          "tutorialProfileTwoDescription".tr(),
          65,
          tapType: TapType.onDoneButton,
          _unblurredProfileSectionKey,
          (offset, size) => PathUtils.getRoundedRectShapePath(
                offset,
                size,
                padding: const EdgeInsets.only(
                    left: highLightedWidgetPadding,
                    right: highLightedWidgetPadding,
                    top: highLightedWidgetPadding,
                    // Additional space to also make the poule stats widget highlighted.
                    bottom: highLightedWidgetPadding +
                        28 +
                        AppDimensions.profilePagePouleStatsWidgetHeight),
              )),
    ];

    return TutorialWalkthrough(
      key: UniqueKey(),
      child: dummyBottomMenuPage,
      tutorials: tutorials,
      onFinished: () {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(NavPage.route, (route) => false);
      },
    );
  }
}

enum Walkthrough {
  home,
  choosePrediction,
  ranking,
  teamOfSeason,
  shop,
  profile
}
