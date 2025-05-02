import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/constants/extended_theme.dart';
import 'package:flutter_better_united/data/model/other_user.dart';
import 'package:flutter_better_united/figma/colors.dart';
import 'package:flutter_better_united/pages/profile/profile_page.dart';
import 'package:flutter_better_united/util/betterUnited_icons.dart';
import 'package:flutter_better_united/widgets/info_bubble.dart';
import 'package:flutter_better_united/widgets/input_field.dart';
import 'package:flutter_better_united/widgets/loading_indicator.dart';
import 'package:flutter_better_united/widgets/regular_app_bar.dart';
import 'package:flutter_better_united/widgets/sliver_loading_indicator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../util/common_ui.dart';
import '../../widgets/or_divider.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/profile_widget.dart';
import 'friends_provider.dart';

class FriendsPage extends StatefulWidget {
  const FriendsPage({
    super.key,
  });

  static Route route() {
    return CupertinoPageRoute(
      fullscreenDialog: false,
      builder: (_) => const FriendsPage(),
    );
  }

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RegularAppBar.withBackButton(
        title: "myFriends".tr(),
        onBackTap: () {
          context.pop();
        },
      ),
      body: ChangeNotifierProvider(
        lazy: false,
        create: (context) => FriendsProvider(
          context.read(),
          context.read(),
          context.read(),
        )..fetchFollowers(),
        builder: (context, child) {
          final users = context.watch<FriendsProvider>().filteredFollowers;
          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                sliver: MultiSliver(children: [
                  SliverToBoxAdapter(
                    child: Column(children: [
                      const SizedBox(
                        height: 12,
                      ),
                      InfoBubble(description: "inviteFriendsToApp".tr()),
                      const SizedBox(
                        height: 16,
                      ),
                      PrimaryButton(
                        prefixIcon: const Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.0),
                              child: Icon(BetterUnited.share),
                            )),
                        text: "shareInvitation".tr().toUpperCase(),
                        confineInSafeArea: false,
                        onPressed: () {
                          _shareLink(context);
                        },
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      const OrDivider(),
                      const SizedBox(
                        height: 16,
                      ),
                      GestureDetector(
                        onTap: () async {
                          await Navigator.of(context).push(
                              _SearchFriendsPage.route(
                                  FriendsProvider: context.read()));
                        },
                        child: InputField(
                          enabled: false,
                          hintText: "searchOtherUsers".tr(),
                          prefixIcon: const Icon(BetterUnited.search),
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                    ]),
                  ),
                  users == null
                      ? const SliverLoadingIndicator()
                      : UserList(
                          padding: const EdgeInsets.only(bottom: 24),
                          scrollController: _scrollController,
                          users: users,
                        ),
                ]),
              ),
            ],
          );
        },
      ),
    );
  }

  _shareLink(BuildContext context) async {
    Uri? shortLink =
        await context.read<FriendsProvider>().createInviteReferralLink();
    if (shortLink != null) {
      Share.share("${'appReferralDescription'.tr()}\n$shortLink");
    }
  }
}

class UserCard extends StatelessWidget {
  const UserCard({super.key, required this.user, this.onFollowTap});

  final OtherUser user;
  final GestureTapCallback? onFollowTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8, right: 16, top: 16, bottom: 16),
      decoration: const BoxDecoration(
        color: Color(0xff353535),
        boxShadow: appBoxShadow,
        borderRadius: BorderRadius.all(
          Radius.circular(4),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(ProfilePage.route(userId: user.id));
              },
              child: ProfileWidget(
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xff838383),
                    Color(0xff4C4C4C),
                  ],
                ),
                level: user.userLevel,
                profileUrl: user.profilePictureUrl,
                isFollowButtonVisible: false,
                leagueRank: user.userRewardTitle.toUpperCase(),
                nickname: user.nickname.toUpperCase(),
              ),
            ),
          ),
          Container(
            width: user.isFollowed ? 90 : 73,
            alignment: Alignment.center,
            child: user.isLoading
                ? const SpinKitRing(
                    lineWidth: 3,
                    color: AppColors.primary,
                    size: 25.0,
                  )
                : GestureDetector(
                    onTap: onFollowTap,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      decoration: BoxDecoration(
                        color: user.isFollowed
                            ? Colors.transparent
                            : AppColors.primary,
                        border: Border.all(
                            color: user.isFollowed
                                ? AppColors.primary
                                : Colors.transparent,
                            width: 1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: AutoSizeText(
                          (user.isFollowed ? "followed" : "follow")
                              .tr()
                              .toUpperCase(),
                          maxLines: 1,
                          minFontSize: 1,
                          style: context.labelBold.copyWith(
                            color: Colors.white,
                          )),
                    ),
                  ),
          )
        ],
      ),
    );
  }
}

class _SearchFriendsPage extends StatelessWidget {
  const _SearchFriendsPage({required this.friendsProvider});

  final FriendsProvider friendsProvider;

  static Route route({required FriendsProvider FriendsProvider}) {
    return CupertinoPageRoute(
        builder: (_) => _SearchFriendsPage(
              friendsProvider: FriendsProvider,
            ));
  }

  _onBackPressed(BuildContext context) {
    context.read<FriendsProvider>().clearSearch();
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: friendsProvider,
      builder: (context, child) {
        final filteredUsers = context.watch<FriendsProvider>().filteredUsers;
        return WillPopScope(
          onWillPop: () async {
            _onBackPressed(context);
            return false;
          },
          child: Scaffold(
            appBar: RegularAppBar.withText(
              title: "myFriends".tr(),
              onBackTap: () {
                _onBackPressed(context);
              },
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(
                    height: 12,
                  ),
                  InputField(
                    onChanged: (query) {
                      context.read<FriendsProvider>().searchUser(query);
                    },
                    hintText: "searchOtherUsers".tr(),
                    prefixIcon: const Icon(BetterUnited.search),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Expanded(
                      child: filteredUsers == null
                          ? const LoadingIndicator()
                          : UserList(
                              padding: const EdgeInsets.only(bottom: 24),
                              users: filteredUsers))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class UserList extends StatelessWidget {
  const UserList(
      {super.key, this.scrollController, required this.users, this.padding});

  final ScrollController? scrollController;
  final List<OtherUser> users;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: padding,
        controller: scrollController,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final user = users[index];
          return UserCard(
            user: user,
            onFollowTap: () {
              context.read<FriendsProvider>().followUser(user);
            },
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 16);
        },
        itemCount: users.length);
  }
}
