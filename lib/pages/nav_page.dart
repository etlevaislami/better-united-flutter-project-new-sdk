import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/constants/app_colors.dart';
import 'package:flutter_better_united/pages/dialog/poule_rank_dialog.dart';
import 'package:flutter_better_united/pages/dialog/team_of_season_rank_dialog.dart';
import 'package:flutter_better_united/pages/dialog/team_of_week_weekly_rank_dialog.dart';
import 'package:flutter_better_united/pages/home/navigation/home_nav_items.dart';
import 'package:flutter_better_united/pages/profile/my_profile_page.dart';
import 'package:flutter_better_united/pages/ranking/ranking_page.dart';
import 'package:flutter_better_united/pages/ranking/ranking_provider.dart';
import 'package:flutter_better_united/pages/shop/shop_page.dart';
import 'package:flutter_better_united/pages/shop/user_provider.dart';
import 'package:flutter_better_united/util/navigation_service.dart';
import 'package:flutter_better_united/util/settings.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import '../util/dialog_manager.dart';
import '../util/notifications/notification_manager.dart';
import '../widgets/bottom_nav_bar.dart';
import 'dialog/daily_reward_dialog.dart';
import 'dialog/league_invitation_dialog.dart';
import 'dialog/tip_result_dialog.dart';
import 'home/home_page.dart';

class NavPage extends StatefulWidget {
  static const route = "/nav";
  static const int moreIndex = 4;
  static const int friendIndex = 1;
  static const int shopIndex = 3;
  static const int createTipIndex = 2;
  static const double navBarHeight = 60;

  const NavPage({Key? key}) : super(key: key);

  @override
  State<NavPage> createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  late List<Widget> _pageOptions;
  late PersistentTabController _controller;
  final navItems = HomeNavItems.getNavItems();

  @override
  void initState() {
    super.initState();
    _handleNotificationPermissions();
    _setupNavigationBar();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _handleAuthenticationOperations();
      _handleInitialPushNotification();
      _handleFriendInvitation();
    });
    _observeNavPageChangeRequests();
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView.custom(
      context,
      customWidget: (p0) => BottomNavBar(
        navBarEssentials: NavBarEssentials(
          navBarHeight: NavPage.navBarHeight,
          onItemSelected: (value) {
            _controller.jumpToTab(value);
            setState(() {
              _controller.index = value;
            });
          },
          selectedIndex: _controller.index,
          items: navItems,
        ),
      ),
      itemCount: navItems.length,
      controller: _controller,
      screens: _pageOptions,
      confineInSafeArea: true,
      backgroundColor: AppColors.navBarBackground,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      navBarHeight: NavPage.navBarHeight,
      hideNavigationBarWhenKeyboardShows: true,
      margin: EdgeInsets.zero,
      bottomScreenMargin: 0.0,
      hideNavigationBar: false,
    );
  }

  _handleAuthenticationOperations() async {
    context.read<UserProvider>().syncUserProfile();
    context.read<UserProvider>().handleUnacknowledgedTips(
      (tip) {
        if (context.read<NavigationService>().pendingPushNotification) {
          return;
        }
        showFlutterDialog(
          context: context,
          builder: (context) => TipResultDialog(
            tipId: tip.tipDetail.id,
            tipSettlement: tip.rewards.tipSettlement,
            unclaimedTip: tip,
          ),
        );
      },
    );
    context.read<UserProvider>().handleUnacknowledgedPoulesRewards(
      (pouleReward) {
        showFlutterDialog(
          context: context,
          builder: (context) => PouleRankDialog(pouleReward: pouleReward),
        );
      },
    );
    _checkUnclaimedTeamOfWeekAndSeasonRewards(context);
    context.read<UserProvider>().syncPushToken();
    context.read<UserProvider>().syncUserLanguage(context.locale);
    context.read<UserProvider>().handleUserDailyRewards(
      (rewards) {
        showFlutterDialog(
          context: context,
          builder: (context) => DailyRewardDialog(
            dailyRewards: rewards,
          ),
        );
      },
    );
  }

  _setupNavigationBar() {
    _controller = PersistentTabController(initialIndex: 0);
    _pageOptions = const [
      HomePage(),
      RankingPage(),
      ShopPage(),
      MyProfilePage(),
    ];
  }

  _handleInitialPushNotification() {
    final notificationManager = context.read<NotificationManager>();
    final payload = notificationManager.selectedNotificationPayload;
    if (payload != null) {
      notificationManager.handlePushType(payload);
    }
  }

  _handleFriendInvitation() {
    final leagueInvitation = context.read<Settings>().leagueInvitation;
    if (leagueInvitation != null) {
      context.read<Settings>().clearLeagueInvitation();
      showDialog(
        context: context,
        builder: (BuildContext _) {
          return LeagueInvitationDialog(
            isSelfInvite: true,
            leagueId: leagueInvitation.leagueId,
            nickname: leagueInvitation.nickname,
            leagueName: leagueInvitation.leagueName,
            prizePool: leagueInvitation.poolPrize,
            pouleType: leagueInvitation.type,
            entryFee: leagueInvitation.entryFee,
          );
        },
      );
    }
  }

  _handleNotificationPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();

    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  _observeNavPageChangeRequests() {
    context.read<NavigationService>().didReceiveNavigationPageIndex.listen(
      (index) {
        //making sure index is correct
        switch (index) {
          case NavPage.shopIndex:
          case NavPage.friendIndex:
          case NavPage.createTipIndex:
          case NavPage.moreIndex:
            break;

          default:
            return;
        }

        _controller.jumpToTab(index);
        setState(() {
          _controller.index = index;
        });
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _checkUnclaimedTeamOfWeekAndSeasonRewards(BuildContext context) {
    // First open weekly dialog if any unclaimed weekly rewards. After showing that dialog check if seasonal dialog should display too. 
    context.read<RankingProvider>().checkUnClaimedTeamOfWeekRewards(
      unClaimedWeeklyRewardsCallback: (teamOfWeek) {
        void checkUnClaimedTeamOfSeasonRewards() {
          context.read<RankingProvider>().checkUnClaimedTeamOfSeasonRewards(
            unClaimedSeasonalRewardsCallback:
                (teamOfSeason) {
              if (teamOfSeason.isClaimed == false) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext _) {
                    return TeamOfSeasonRankDialog(
                      teamOfSeason: teamOfSeason,
                    );
                  },
                );
              }
            },
          );
        }
        if (teamOfWeek.isClaimed == false) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext _) {
              return TeamOfWeekWeeklyRankDialog(
                onDismissed: () {
                  checkUnClaimedTeamOfSeasonRewards();
                },
                teamOfWeek: teamOfWeek,
              );
            },
          );
        } else {
          checkUnClaimedTeamOfSeasonRewards();
        }
      },
    );
  }
}
