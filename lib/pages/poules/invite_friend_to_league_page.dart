import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/constants/app_colors.dart';
import 'package:flutter_better_united/pages/poules/invite_friend_provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../data/enum/poule_type.dart';
import '../../data/model/friend.dart';
import '../../util/Debouncer.dart';
import '../../util/common_ui.dart';
import '../../widgets/button.dart';
import '../../widgets/button_chooser.dart';
import '../../widgets/dialog_bar.dart';
import '../../widgets/modal_background_widget.dart';
import '../../widgets/profile_widget.dart';
import '../../widgets/search_widget.dart';

class FriendLeagueInviteArgument {
  final int leagueId;
  final String leagueName;
  final PouleType pouleType;

  FriendLeagueInviteArgument(this.leagueId, this.leagueName, this.pouleType);
}

class InviteFriendToLeaguePage extends StatefulWidget {
  static const String route = '/invite-friend-league';

  const InviteFriendToLeaguePage({Key? key}) : super(key: key);

  @override
  State<InviteFriendToLeaguePage> createState() =>
      _InviteFriendToLeaguePageState();
}

class _InviteFriendToLeaguePageState extends State<InviteFriendToLeaguePage> {
  late final InviteFriendProvider _inviteFriendProvider;
  final ScrollController _scrollController = ScrollController();
  final _textDebouncer = Debouncer();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments
        as FriendLeagueInviteArgument?;
    if (args == null) {
      throw UnimplementedError("friend league id argument is missing");
    }
    _inviteFriendProvider = InviteFriendProvider(
        context.read(), context.read(), context.read(), context.read(),
        leagueName: args.leagueName,
        leagueId: args.leagueId,
        pouleType: args.pouleType,
        leagueIconUrl: null,
        poolPrize: 0,
        entryFee: 0);
    _inviteFriendProvider.fetchFollowers();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _textDebouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _inviteFriendProvider,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.pearlPowder,
        body: Column(
          children: [
            Expanded(
              child: ModalBackgroundWidget(
                child: Column(
                  children: [
                    DialogBar(
                      title: "inviteFriends".tr(),
                      onTap: () => context.pop(),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    "inviteToBetterUnited".tr(),
                                    style: context.labelMedium,
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  ButtonChooser(
                                    "shareInvitation".tr(),
                                    onTap: () => _shareLink(),
                                    centerText: true,
                                    iconWidth: 24,
                                    drawShadow: true,
                                    padding: const EdgeInsets.only(
                                        left: 21.0, top: 8, bottom: 8),
                                    textColor: AppColors.dollarBill,
                                    color: Colors.white,
                                    icon: SvgPicture.asset(
                                      "assets/icons/ic_share.svg",
                                      color: AppColors.dollarBill,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 13,
                                  ),
                                  Text(
                                    "addFromList".tr(),
                                    style: context.labelMedium,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  SearchWidget(
                                    hintText: "searchFriend".tr(),
                                    onChanged: (value) => _textDebouncer.run(
                                        () => _inviteFriendProvider
                                            .searchFriend(value)),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  _buildFriendWidgets(),
                                  const SizedBox(
                                    height: 25,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: AppColors.pearlPowder,
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
              child: Button(
                text: "saveChanges".tr(),
                onPressed: () => context.pop(),
              ),
            )
          ],
        ),
      ),
    );
  }

  _shareLink() async {
    Uri? shortLink = await _inviteFriendProvider.createInviteReferralLink();
    if (shortLink != null) {
      Share.share("${'appReferralDescription'.tr()}\n$shortLink");
    }
  }

  Widget _buildFriendWidget(BuildContext context, Friend friend) {
    return GestureDetector(
      onTap: () => _inviteFriendProvider.inviteFriend(friend),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: appBoxShadow,
          borderRadius: BorderRadius.all(
            Radius.circular(7),
          ),
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: ProfileWidget(
                level: friend.level,
                profileUrl: friend.profilePictureUrl,
                isFollowButtonVisible: false,
                leagueRank: friend.levelName,
                nickname: friend.nickname,
              ),
            ),
            friend.isInvited
                ? Text(
                    "invitationSent".tr(),
                    style: context.titleLarge
                        ?.copyWith(color: AppColors.dollarBill, fontSize: 14),
                  )
                : Container(
                    width: 51,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        color: AppColors.goldenHandshake,
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: friend.isLoading
                        ? const SpinKitRing(
                            lineWidth: 3,
                            color: AppColors.forgedSteel,
                            size: 25.0,
                          )
                        : SvgPicture.asset("assets/icons/ic_add_player.svg"),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildFriendWidgets() {
    return Selector<InviteFriendProvider, List<Friend>?>(
      selector: (p0, p1) => p1.filteredFollowers,
      shouldRebuild: (previous, next) => true,
      builder: (context, followers, child) => followers == null
          ? const SizedBox()
          : ListView.separated(
              controller: _scrollController,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final friend = followers[index];
                return _buildFriendWidget(context, friend);
              },
              separatorBuilder: (context, index) => const SizedBox(
                    height: 13,
                  ),
              itemCount: followers.length),
    );
  }
}
