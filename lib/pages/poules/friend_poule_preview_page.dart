import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/constants/extended_theme.dart';
import 'package:flutter_better_united/data/model/football_match.dart';
import 'package:flutter_better_united/figma/colors.dart';
import 'package:flutter_better_united/widgets/carousel.dart';
import 'package:flutter_better_united/widgets/info_bubble.dart';
import 'package:flutter_better_united/widgets/match_card.dart';
import 'package:flutter_better_united/widgets/primary_button.dart';
import 'package:flutter_better_united/widgets/prize_poule_text.dart';
import 'package:flutter_better_united/widgets/regular_app_bar.dart';
import 'package:flutter_better_united/widgets/welcome_to_widget.dart';
import 'package:provider/provider.dart';

import '../../widgets/friend_league_circle_league.dart';
import 'friend_poule_preview_provider.dart';

class FriendPoulePreviewData {
  final int poolPrize;
  final String pouleName;
  final FootballMatch match;

  FriendPoulePreviewData(
      {required this.poolPrize, required this.pouleName, required this.match});
}

class FriendPoulePreviewPage extends StatefulWidget {
  const FriendPoulePreviewPage({
    Key? key,
    required this.isFromOverview,
    this.data,
    required this.pouleId,
  }) : super(key: key);
  final bool isFromOverview;
  final FriendPoulePreviewData? data;
  final int pouleId;

  @override
  State<FriendPoulePreviewPage> createState() => _FriendPoulePreviewPageState();

  static Route route(
      {required bool isFromOverview,
      required int pouleId,
      FriendPoulePreviewData? data}) {
    return CupertinoPageRoute(
        fullscreenDialog: true,
        builder: (_) => FriendPoulePreviewPage(
              data: data,
              pouleId: pouleId,
              isFromOverview: isFromOverview,
            ));
  }
}

class _FriendPoulePreviewPageState extends State<FriendPoulePreviewPage> {
  late final FriendPoulePreviewProvider _provider = FriendPoulePreviewProvider(
    context.read(),
    pouleId: widget.pouleId,
    data: widget.data,
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.data == null) {
        _provider.getPouleDetail();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _provider,
      builder: (context, child) {
        final data = context.watch<FriendPoulePreviewProvider>().data;
        if (data == null) {
          return const SizedBox.shrink();
        }
        final PreferredSizeWidget appBar = widget.isFromOverview
            ? RegularAppBarV4(
                title: data.pouleName,
              ) as PreferredSizeWidget
            : RegularAppBarV6(
                icon: const FriendLeagueCircle(),
                onBackTap: () {},
                onCloseTap: () {},
                backgroundColor: Colors.black,
              );
        return Container(
          color: Colors.black,
          child: SafeArea(
            top: !widget.isFromOverview,
            bottom: false,
            child: Scaffold(
              extendBodyBehindAppBar: true,
              backgroundColor: AppColors.secondary,
              appBar: appBar,
              body: SingleChildScrollView(
                padding: EdgeInsets.only(top: appBar.preferredSize.height),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      widget.isFromOverview
                          ? const SizedBox()
                          : Padding(
                              padding: const EdgeInsets.only(bottom: 24.0),
                              child: WelcomeToWidget(
                                name: data.pouleName,
                              ),
                            ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: PrizePouleText(
                          text: "currentPrizePoule".tr(),
                          amount: data.poolPrize,
                          backgroundColor: AppColors.background,
                        ),
                      ),
                      const SizedBox(height: 36),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "rulesOfFriendsPoule".tr().toUpperCase(),
                              style: context.bodyBold
                                  .copyWith(color: Colors.white),
                            )),
                      ),
                      const SizedBox(height: 16),
                      const Carousel(),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "availableMatch".tr().toUpperCase(),
                              style: context.bodyBold
                                  .copyWith(color: Colors.white),
                            )),
                      ),
                      const SizedBox(height: 24),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: MatchCard(
                          foregroundColor: AppColors.background,
                          matchDate: data.match.startsAt,
                          homeTeam: data.match.homeTeam,
                          awayTeam: data.match.awayTeam,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: PrimaryButton(
                  confineInSafeArea: true,
                  text: "ok".tr(),
                  onPressed: () {
                    context.pop();
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
