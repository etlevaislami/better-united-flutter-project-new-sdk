import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/constants/extended_theme.dart';
import 'package:flutter_better_united/data/enum/poule_type.dart';
import 'package:flutter_better_united/data/model/other_user.dart';
import 'package:flutter_better_united/figma/colors.dart';
import 'package:flutter_better_united/figma/text_styles.dart';
import 'package:flutter_better_united/util/betterUnited_icons.dart';
import 'package:flutter_better_united/widgets/info_bubble.dart';
import 'package:flutter_better_united/widgets/input_field.dart';
import 'package:flutter_better_united/widgets/regular_app_bar.dart';
import 'package:flutter_better_united/widgets/rounded_container.dart';
import 'package:flutter_better_united/widgets/sliver_loading_indicator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../data/model/friend.dart';
import '../../util/common_ui.dart';
import '../../widgets/or_divider.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/profile_widget.dart';
import 'invite_friend_provider.dart';

class InviteFriendsPage extends StatefulWidget {
  final int pouleId;
  final String leagueName;
  final PouleType pouleType;
  final bool withCloseButton;
  final int poolPrize;
  final String? leagueLogoUrl;
  final int entryFee;

  const InviteFriendsPage({
    super.key,
    required this.pouleId,
    required this.leagueName,
    required this.withCloseButton,
    required this.pouleType,
    required this.poolPrize,
    required this.leagueLogoUrl,
    required this.entryFee,
  });

  static Route route(
      {required int pouleId,
      required String pouleName,
      required bool withCloseButton,
      required PouleType pouleType,
      required int poolPrize,
      required int entryFee,
      required String? leagueLogoUrl}) {
    return CupertinoPageRoute(
      fullscreenDialog: withCloseButton,
      builder: (_) => InviteFriendsPage(
        withCloseButton: withCloseButton,
        pouleId: pouleId,
        leagueName: pouleName,
        pouleType: pouleType,
        poolPrize: poolPrize,
        entryFee: entryFee,
        leagueLogoUrl: leagueLogoUrl,
      ),
    );
  }

  @override
  State<InviteFriendsPage> createState() => _InviteFriendsPageState();
}

class _InviteFriendsPageState extends State<InviteFriendsPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: PrimaryButton(
          text: "goToOverview".tr(),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      appBar: widget.withCloseButton
          ? RegularAppBar.fromModal(
              title: "inviteFriends".tr(),
              onCloseTap: () {
                context.pop();
              },
            )
          : RegularAppBar.withText(title: "inviteFriends".tr()),
      body: ChangeNotifierProvider(
          lazy: false,
          create: (context) => InviteFriendProvider(
              context.read(), context.read(), context.read(), context.read(),
              leagueName: widget.leagueName,
              leagueId: widget.pouleId,
              pouleType: widget.pouleType,
              poolPrize: widget.poolPrize,
              entryFee: widget.entryFee,
              leagueIconUrl: widget.leagueLogoUrl)
            ..fetchFollowers(),
          builder: (context, child) {
            final friends =
                context.watch<InviteFriendProvider>().filteredFollowers;
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
                        InfoBubble(description: "inviteFriendToJoin".tr()),
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
                                    inviteFriendProvider: context.read()));
                            context
                                .read<InviteFriendProvider>()
                                .validateInviteAll();
                          },
                          child: InputField(
                            enabled: false,
                            hintText: "searchOtherUsersAndFollowers".tr(),
                            prefixIcon: const Icon(BetterUnited.search),
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        PrimaryButton(
                          text: "inviteAll".tr(),
                          onPressed: context
                                  .read<InviteFriendProvider>()
                                  .isInviteAllEnabled
                              ? () {
                                  context
                                      .read<InviteFriendProvider>()
                                      .inviteAll();
                                }
                              : null,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                      ]),
                    ),
                    friends == null
                        ? const SliverLoadingIndicator()
                        : FriendList(
                            friends: friends,
                          )
                  ]),
                ),
              ],
            );
          }),
    );
  }

  _shareLink(BuildContext context) async {
    Uri? shortLink =
        await context.read<InviteFriendProvider>().createInviteReferralLink();
    if (shortLink != null) {
      Share.share("${'appReferralDescription'.tr()}\n$shortLink");
    }
  }
}

class UserCard extends StatelessWidget {
  const UserCard(
      {super.key, required this.user, this.onFollowTap, this.onInviteTap});

  final OtherUser user;
  final GestureTapCallback? onFollowTap;
  final GestureTapCallback? onInviteTap;

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
          SizedBox(
            width: 73,
            child: user.isLoading
                ? const SpinKitRing(
                    lineWidth: 3,
                    color: AppColors.primary,
                    size: 25.0,
                  )
                : user.isJoined
                    ? Text(
                        "joined".tr().toUpperCase(),
                        style: AppTextStyles.textStyle8,
                      )
                    : !user.isFollowed
                        ? Align(
                            child: GestureDetector(
                            onTap: onFollowTap,
                            child: Text(
                              "+ ${"follow".tr()}",
                              style: context.buttonPrimaryUnderline.copyWith(
                                  fontSize: 12,
                                  fontStyle: FontStyle.normal,
                                  color: AppColors.primary,
                                  decorationThickness: 3),
                            ),
                          ))
                        : user.isInvited
                            ? Text(
                                "invited".tr().toUpperCase(),
                                style: AppTextStyles.textStyle8,
                              )
                            : GestureDetector(
                                onTap: onInviteTap,
                                child: RoundedContainer(
                                  child: Text(
                                      "+ ${"invite".tr()}".toUpperCase(),
                                      style: context.labelBold.copyWith(
                                        color: Colors.white.withOpacity(0.5),
                                      )),
                                ),
                              ),
          )
        ],
      ),
    );
  }
}

class _FriendCard extends StatelessWidget {
  const _FriendCard({required this.friend, this.onInviteTap});

  final Friend friend;
  final GestureTapCallback? onInviteTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8, right: 16, top: 16, bottom: 16),
      decoration: const BoxDecoration(
        color: AppColors.secondary,
        boxShadow: appBoxShadow,
        borderRadius: BorderRadius.all(
          Radius.circular(4),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: ProfileWidget(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xff838383),
                  Color(0xff4C4C4C),
                ],
              ),
              level: friend.level,
              profileUrl: friend.profilePictureUrl,
              isFollowButtonVisible: false,
              leagueRank: friend.levelName.toUpperCase(),
              nickname: friend.nickname.toUpperCase(),
            ),
          ),
          Container(
            width: 73,
            alignment: Alignment.center,
            child: friend.isLoading
                ? const SpinKitRing(
                    lineWidth: 3,
                    color: AppColors.primary,
                    size: 25.0,
                  )
                : friend.isJoined
                    ? Text(
                        "joined".tr().toUpperCase(),
                        style: AppTextStyles.textStyle8,
                      )
                    : friend.isInvited
                        ? Text(
                            "invited".tr().toUpperCase(),
                            style: AppTextStyles.textStyle8,
                          )
                        : GestureDetector(
                            onTap: onInviteTap,
                            child: RoundedContainer(
                              child: Text("+ ${"invite".tr()}".toUpperCase(),
                                  style: context.labelBold.copyWith(
                                    color: Colors.white.withOpacity(0.5),
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
  const _SearchFriendsPage({required this.inviteFriendProvider});

  final InviteFriendProvider inviteFriendProvider;

  static Route route({required InviteFriendProvider inviteFriendProvider}) {
    return CupertinoPageRoute(
        builder: (_) => _SearchFriendsPage(
              inviteFriendProvider: inviteFriendProvider,
            ));
  }

  _onBackPressed(BuildContext context) {
    context.read<InviteFriendProvider>().clearSearch();
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: inviteFriendProvider,
      builder: (context, child) {
        final filteredUsers =
            context.watch<InviteFriendProvider>().filteredUsers;
        return WillPopScope(
          onWillPop: () async {
            _onBackPressed(context);
            return false;
          },
          child: Scaffold(
            appBar: RegularAppBar.withText(
              title: "inviteFriends".tr(),
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
                      context.read<InviteFriendProvider>().searchUser(query);
                    },
                    hintText: "searchOtherUsersAndFollowers".tr(),
                    prefixIcon: const Icon(BetterUnited.search),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  InfoBubble(description: "invitationInfo".tr()),
                  const SizedBox(
                    height: 16,
                  ),
                  Expanded(
                      child: filteredUsers == null
                          ? const Center(
                              child: SpinKitRing(
                              lineWidth: 3,
                              color: AppColors.primary,
                              size: 25.0,
                            ))
                          : UserList(users: filteredUsers))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class FriendList extends StatelessWidget {
  const FriendList(
      {super.key, this.scrollController, required this.friends, this.padding});

  final ScrollController? scrollController;
  final List<Friend> friends;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      itemCount: friends.length,
      itemBuilder: (context, index) {
        final friend = friends[index];
        return _FriendCard(
            onInviteTap: () {
              context.read<InviteFriendProvider>().inviteFriend(friend);
            },
            friend: friend);
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 16);
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
              context.read<InviteFriendProvider>().followUser(user);
            },
            onInviteTap: () {
              context.read<InviteFriendProvider>().inviteUser(user);
            },
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 16);
        },
        itemCount: users.length);
  }
}
