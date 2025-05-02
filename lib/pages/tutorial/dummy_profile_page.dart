import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/constants/extended_theme.dart';
import 'package:flutter_better_united/data/model/reward_level.dart';
import 'package:flutter_better_united/pages/nav_page.dart';
import 'package:flutter_better_united/util/betterUnited_icons.dart';
import 'package:flutter_better_united/widgets/avatar_widget.dart';
import 'package:flutter_better_united/widgets/custom_tab_bar.dart';
import 'package:flutter_better_united/widgets/regular_app_bar.dart';
import 'package:flutter_better_united/widgets/stat_widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../figma/colors.dart';
import '../../widgets/background_container.dart';
import '../../widgets/fixed_button.dart';
import '../../widgets/level_status_widget.dart';
import '../../widgets/progress_indicator.dart';
import '../settings/settings_page.dart';
import '../shop/user_provider.dart';

/// Profile page showing fake data for tutorial.
class DummyMyProfilePage extends StatefulWidget {
  const DummyMyProfilePage({
    Key? key,
    this.withBackButton = false,
    this.unblurredProfileSectionKey,
  }) : super(key: key);
  final bool withBackButton;
  final GlobalKey? unblurredProfileSectionKey;

  @override
  State<DummyMyProfilePage> createState() => _MyProfileNewState();
  static const routeName = "/my_profile";

  static Route route() {
    return CupertinoPageRoute(
      builder: (_) => const DummyMyProfilePage(
        withBackButton: true,
      ),
    );
  }
}

class _MyProfileNewState extends State<DummyMyProfilePage>
    with SingleTickerProviderStateMixin {
  late final _tabController = TabController(length: 2, vsync: this);
  final _pageController = PageController();

  @override
  void initState() {
    super.initState();
    final connectedUser = context.read<UserProvider>().user;
    _tabController.addListener(
      () {
        _pageController.animateToPage(_tabController.index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut);
      },
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _AppBar(
        withBackButton: widget.withBackButton,
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              sliver: SliverPinnedHeader(
                  child: CustomTabBar(
                key: widget.unblurredProfileSectionKey,
                firstTabText: "Statistics",
                secondTabText: "Achievements",
                tabController: _tabController,
              )),
            ),
          ];
        },
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _StatWidget(),
            _Rewards(
              onClaimTap: (rewardLevel) async {
              },
            )
          ],
        ),
      ),
    );
  }
}

class _Rewards extends StatefulWidget {
  const _Rewards({
    super.key,
    required this.onClaimTap,
  });

  final Function(RewardLevel) onClaimTap;

  @override
  State<_Rewards> createState() => _RewardsState();
}

class _RewardsState extends State<_Rewards> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final levels = [
      // RewardLevel(),
    ];
    return SingleChildScrollView(
      padding:
          const EdgeInsets.only(top: 60, bottom: NavPage.navBarHeight + 24),
      child: SizedBox(
          height: 252,
          child: ListView.separated(
            clipBehavior: Clip.none,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => const SizedBox(
              width: 24,
            ),
            itemBuilder: (context, index) {
              final level = levels[index];
              return LevelStatusWidget(
                rewardLevel: level,
                onClaimTap: widget.onClaimTap,
              );
            },
            itemCount: levels.length,
          )),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _StatWidget extends StatefulWidget {
  const _StatWidget({super.key});

  @override
  State<_StatWidget> createState() => _StatWidgetState();
}

class _StatWidgetState extends State<_StatWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    // Hopefully this already is available.
    final user = context.watch<UserProvider>().user;
    if (user == null) {
      return const SizedBox();
    }
    return SingleChildScrollView(
      padding: const EdgeInsets.only(
          left: 24, right: 24, bottom: NavPage.navBarHeight + 24),
      child: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          PouleStats(
            joinedPoules: user.amountJoinedPoules,
            friendPouleWins: user.wonFriendPoules,
            publicPouleWins: user.wonPublicPoules,
          ),
          const SizedBox(
            height: 16,
          ),
          PointsEarned(
            points: user.pointsAmount,
            coins: user.coinsEarned,
          ),
          const SizedBox(
            height: 16,
          ),
          PredictionOverview(
            averageWinPoints: user.averagePoints,
            predictions: user.sharedTipsCount,
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({required this.withBackButton});

  static const double height = 323;
  final bool withBackButton;

  @override
  Widget build(BuildContext context) {
    final autoSizeGroup = AutoSizeGroup();
    return Container(
      height: height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff2A2A2A), Color(0xff111111)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RegularAppBar(
            backgroundColor: Colors.transparent,
            title: 'profileTitle'.tr(),
            textAlign: TextAlign.start,
            prefixIcon: withBackButton
                ? FixedButton(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    iconData: BetterUnited.triangle)
                : IconButton(
                    color: AppColors.primary,
                    iconSize: 21,
                    icon: const Icon(BetterUnited.profile),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
            suffixIcon: FixedButton(
              iconData: BetterUnited.settings,
              onTap: () {
                Navigator.of(context, rootNavigator: true)
                    .pushNamed(SettingsPage.route);
              },
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          const _UserProfileCard(),
          Container(
            margin: const EdgeInsets.all(24),
            child: Row(
              children: [
                Expanded(
                    child: _Button(
                  group: autoSizeGroup,
                  prefixIcon: Align(
                      alignment: Alignment.centerLeft,
                      child: ClipRRect(
                        child: Transform.translate(
                          offset: const Offset(4, 4),
                          child: Transform.scale(
                              scale: 0.9,
                              child: Image.asset(
                                "assets/icons/union.png",
                                color: Colors.white.withOpacity(0.9),
                              )),
                        ),
                      )),
                  text: 'My friends',
                  confineInSafeArea: false,
                  onPressed: () {},
                )),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                    child: _Button(
                  group: autoSizeGroup,
                  text: 'My favorite clubs',
                  prefixIcon: Align(
                      alignment: Alignment.centerLeft,
                      child: ClipRRect(
                        child: Transform.translate(
                          offset: const Offset(-4, 4),
                          child: Transform.scale(
                              scale: 1,
                              child: SvgPicture.asset(
                                "assets/figma/svg/components/exported_icons/img_btn_trophy.svg",
                                clipBehavior: Clip.hardEdge,
                                color: Colors.white.withOpacity(0.7),
                              )),
                        ),
                      )),
                  confineInSafeArea: false,
                  onPressed: () {},
                ))
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(height);
}

class _UserProfileCard extends StatelessWidget {
  const _UserProfileCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    return LayoutBuilder(builder: (context, constraints) {
      return SizedBox(
        height: 100,
        child: user == null
            ? const SizedBox()
            : Row(
                children: [
                  Container(
                    width: constraints.maxWidth * 0.3,
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    child: AvatarWidget(
                      level: 0,
                      border: Border.all(
                        color: const Color(0xffD8D8D8),
                        width: 2,
                      ),
                      profileUrl: user.profilePictureUrl,
                      isFollowButtonVisible: false,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "fullLevelNumber".tr(
                                  args: [user.level.toString()]).toUpperCase(),
                              style: context.labelBold
                                  .copyWith(color: AppColors.primary),
                            ),
                            Text(
                                user.nextLevelExpAmount == 0
                                    ? "maxLevelReached".tr()
                                    : "xpPoints".tr(
                                        args: [
                                          user.expAmount.toString(),
                                          user.nextLevelExpAmount.toString()
                                        ],
                                      ),
                                style: context.labelRegular),
                          ],
                        ),
                        const SizedBox(
                          height: 21,
                        ),
                        ProgressPercentIndicator(
                          percent: user.nextLevelExpAmount == 0
                              ? 1
                              : user.expAmount / user.nextLevelExpAmount,
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    (user.nickname ?? "undefined".tr())
                                        .toUpperCase(),
                                    style: context.titleH2,
                                  ),
                                  Text(
                                    (user.rewardTitle ?? "undefined".tr())
                                        .toUpperCase(),
                                    style: context.labelBold.copyWith(
                                        color: Colors.white.withOpacity(0.5)),
                                  ),
                                ],
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                            ),
                            GestureDetector(
                                onTap: () {},
                                child:
                                    FixedButton(iconData: BetterUnited.pencil))
                          ],
                        )
                      ],
                    ),
                    flex: 4,
                  ),
                  const SizedBox(
                    width: 4,
                  )
                ],
              ),
      );
    });
  }
}

class _Button extends StatelessWidget {
  const _Button({
    Key? key,
    required this.text,
    this.onPressed,
    this.prefixIcon,
    this.confineInSafeArea = true,
    this.group,
  }) : super(key: key);
  final String text;
  final VoidCallback? onPressed;
  final Widget? prefixIcon;
  final bool confineInSafeArea;
  final AutoSizeGroup? group;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(2),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF8E8E8E), Color(0xFF6A6A6A)],
          ),
          color: Colors.grey,
        ),
        child: BackgroundContainer(
          padding: EdgeInsets.zero,
          height: 48,
          widthRatio: 0.4,
          leadingChild: prefixIcon,
          isInclinationReversed: true,
          withGradient: false,
          backgroundColor: const Color(0xff3C3C3C),
          foregroundColor: AppColors.primary,
          trailingChild: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: AutoSizeText(
              group: group,
              text.toUpperCase(),
              maxLines: 2,
              minFontSize: 0,
              style: const TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
        width: double.infinity,
      ),
    );
  }
}
