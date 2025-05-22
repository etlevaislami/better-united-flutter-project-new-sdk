import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/constants/extended_theme.dart';
import 'package:flutter_better_united/figma/colors.dart';
import 'package:flutter_better_united/pages/profile/profile_provider.dart';
import 'package:flutter_better_united/util/betterUnited_icons.dart';
import 'package:flutter_better_united/widgets/loading_indicator.dart';
import 'package:flutter_better_united/widgets/primary_button.dart';
import 'package:flutter_better_united/widgets/regular_app_bar.dart';
import 'package:provider/provider.dart';

import '../../util/level_name_mapper.dart';
import '../../widgets/avatar_widget.dart';
import '../../widgets/background_container.dart';
import '../../widgets/fixed_button.dart';
import '../../widgets/stat_widgets.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    Key? key,
    required this.userId,
  }) : super(key: key);
  final int userId;

  @override
  State<ProfilePage> createState() => _ProfilePageState();

  static Route route({
    required int userId,
  }) {
    return CupertinoPageRoute(
      builder: (_) => ProfilePage(
        userId: userId,
      ),
    );
  }
}

class _ProfilePageState extends State<ProfilePage> {
  late final ProfileProvider _profileProvider;

  @override
  initState() {
    super.initState();
    _profileProvider = ProfileProvider(
      context.read(),
      widget.userId,
    );
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _profileProvider.fetchProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _profileProvider,
      child: const Scaffold(appBar: _AppBar(), body: _StatsWidget()),
    );
  }
}

class _StatsWidget extends StatelessWidget {
  const _StatsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.watch<ProfileProvider>().user;
    if (user == null) return const Center(child: LoadingIndicator());
    return Container(
      color: Colors.black,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(
              height: 24,
            ),
            SizedBox(
              height: 100,
              child: BackgroundContainer(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                gradientEndColor: AppColors.primary,
                widthRatio: 0.45,
                isInclinationReversed: true,
                withGradient: true,
                backgroundColor: AppColors.secondary,
                foregroundColor: const Color(0xff151515),
                leadingChild: Transform.scale(
                  scale: 1.5,
                  child: Image.asset(
                    "assets/icons/rank1.png",
                  ),
                ),
                trailingChild: Padding(
                  padding: const EdgeInsets.only(left: 48.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        (user.rewardTitle != null ? mapLevelNameToKey(user.rewardTitle!).tr() : ""),
                        style: context.bodyBold,
                      ),
                      Text(
                        "achieved_profile_details".tr(),
                        style: context.labelSemiBold
                            .copyWith(color: AppColors.primary),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 24,
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
            user.favoriteTeams.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: FavoriteClubs(
                      favoriteTeams: user.favoriteTeams,
                    ),
                  )
                : const SizedBox(),
            PredictionOverview(
              averageWinPoints: user.averagePoints,
              predictions: user.sharedTipsCount,
            ),
            const SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar();

  static const double height = 323;

  @override
  Widget build(BuildContext context) {
    final user = context.watch<ProfileProvider>().user;
    if (user == null) {
      return const SizedBox();
    }
    return Container(
      height: height,
      color: AppColors.background,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RegularAppBar(
            suffixIcon: FixedButton(
              iconData: BetterUnited.remove,
              onTap: () {
                context.pop();
              },
            ),
            prefixIcon: Row(
              children: [
                const Icon(
                  BetterUnited.profile,
                  color: AppColors.primary,
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  "profileDetails".tr().toUpperCase(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      shadows: [
                        Shadow(
                          offset: Offset(0, 2),
                          blurRadius: 16,
                          color: Color.fromRGBO(0, 0, 0, 0.5),
                        ),
                      ],
                      fontSize: 18,
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          LayoutBuilder(builder: (context, constraints) {
            return SizedBox(
              height: 100,
              child: Row(
                children: [
                  Container(
                    width: constraints.maxWidth * 0.3,
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    child: AvatarWidget(
                      level: user.level,
                      isFollowButtonVisible: false,
                      profileUrl: user.profilePictureUrl,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "fullLevelNumber".tr(
                                  args: [user.level.toString()]).toUpperCase(),
                              style: context.labelBold
                                  .copyWith(color: AppColors.primary),
                            ),
                          ],
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
                                  (user.rewardTitle != null ? mapLevelNameToKey(user.rewardTitle!).tr() : ""),
                                    style: context.labelBold.copyWith(
                                        color: Colors.white.withOpacity(0.5)),
                                  ),
                                ],
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                            ),
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
          }),
          const SizedBox(
            height: 24,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: PrimaryButton(
              text: user.isFollowingAuthor ? "unfollow".tr() : "follow".tr(),
              confineInSafeArea: false,
              onPressed: () {
                context.read<ProfileProvider>().toggleFollowUser();
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(height);
}
