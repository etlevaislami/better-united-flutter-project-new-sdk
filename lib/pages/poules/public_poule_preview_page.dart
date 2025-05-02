import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/constants/extended_theme.dart';
import 'package:flutter_better_united/figma/colors.dart';
import 'package:flutter_better_united/pages/poules/public_poule_preview_provider.dart';
import 'package:flutter_better_united/widgets/available_matches_widget.dart';
import 'package:flutter_better_united/widgets/carousel.dart';
import 'package:flutter_better_united/widgets/primary_button.dart';
import 'package:flutter_better_united/widgets/prize_poule_text.dart';
import 'package:flutter_better_united/widgets/regular_app_bar.dart';
import 'package:flutter_better_united/widgets/trophy_pedestal.dart';
import 'package:provider/provider.dart';

import '../../data/model/football_match.dart';
import '../../data/model/league.dart';
import '../../widgets/available_leagues_widget.dart';
import '../../widgets/league_icon.dart';

class PublicPoulePreviewData {
  final int prizePool;
  final int coinsForFirst;
  final int coinsForSecond;
  final int coinsForThird;
  final int coinsForOthers;
  final List<League> leagues;
  final String? logoUrl;
  final List<FootballMatch> matches;

  PublicPoulePreviewData(
      {required this.prizePool,
      required this.coinsForFirst,
      required this.coinsForSecond,
      required this.coinsForThird,
      required this.coinsForOthers,
      required this.leagues,
      required this.logoUrl,
      required this.matches});
}

class PublicPoulePreviewPage extends StatefulWidget {
  const PublicPoulePreviewPage({
    Key? key,
    required this.pouleId,
    this.data,
  }) : super(key: key);
  final int pouleId;
  final PublicPoulePreviewData? data;

  @override
  State<PublicPoulePreviewPage> createState() => _PublicPoulePreviewPageState();

  static Route route({
    required int pouleId,
    PublicPoulePreviewData? data,
  }) {
    return CupertinoPageRoute(
        fullscreenDialog: true,
        builder: (_) => PublicPoulePreviewPage(
              data: data,
              pouleId: pouleId,
            ));
  }
}

class _PublicPoulePreviewPageState extends State<PublicPoulePreviewPage> {
  late final PublicPoulePreviewProvider _provider = PublicPoulePreviewProvider(
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
      create: (_) => _provider,
      builder: (context, child) {
        final data = context.watch<PublicPoulePreviewProvider>().data;
        if (data == null) {
          return const SizedBox();
        }
        return Scaffold(
          backgroundColor: AppColors.secondary,
          extendBodyBehindAppBar: true,
          appBar: RegularAppBarV2(
            image: LeagueIconWithPlaceholder(
              logoUrl: data.logoUrl,
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 165),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 24),
                  PrizePouleText(
                    text: "prizePool".tr(),
                    amount: data.prizePool,
                    backgroundColor: AppColors.background,
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: TrophyPedestal(
                      coinsForOthers: data.coinsForOthers,
                      coinsForFirst: data.coinsForFirst,
                      coinsForSecond: data.coinsForSecond,
                      coinsForThird: data.coinsForThird,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "rulesOfPoule".tr().toUpperCase(),
                          style: context.bodyBold.copyWith(color: Colors.white),
                        )),
                  ),
                  const SizedBox(height: 16),
                  const Carousel(),
                  const SizedBox(height: 16),
                  AvailableLeaguesWidget(
                    leagues: data.leagues,
                  ),
                  AvailableMatchesWidget(matches: data.matches)
                ],
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: PrimaryButton(
              text: "ok".tr(),
              onPressed: () {
                context.pop();
              },
            ),
          ),
        );
      },
    );
  }
}
