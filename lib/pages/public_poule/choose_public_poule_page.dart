import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/constants/extended_theme.dart';
import 'package:flutter_better_united/figma/colors.dart';
import 'package:flutter_better_united/pages/public_poule/join_public_poule_page.dart';
import 'package:flutter_better_united/pages/public_poule/public_poule_provider.dart';
import 'package:flutter_better_united/util/extensions/int_extension.dart';
import 'package:flutter_better_united/widgets/info_bubble.dart';
import 'package:flutter_better_united/widgets/poule_card_detail.dart';
import 'package:flutter_better_united/widgets/regular_app_bar.dart';
import 'package:provider/provider.dart';

import '../../widgets/league_icon.dart';
import '../../widgets/rounded_container.dart';

class ChoosePublicPoulePage extends StatefulWidget {
  const ChoosePublicPoulePage({Key? key}) : super(key: key);

  @override
  State<ChoosePublicPoulePage> createState() => _ChoosePublicPoulePageState();

  static Route route() {
    return CupertinoPageRoute(builder: (_) => const ChoosePublicPoulePage());
  }
}

class _ChoosePublicPoulePageState extends State<ChoosePublicPoulePage> {
  final _scrollController = ScrollController();
  late final _provider = PublicPouleProvider(context.read(), context.read());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _provider.fetchPublicPoules();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RegularAppBar.fromModal(
        onCloseTap: () {
          context.pop();
        },
        title: "joinPoule".tr(),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            const SizedBox(
              height: 12,
            ),
            InfoBubble(
              description: "choosePouleDescription".tr(),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            const SizedBox(
              height: 24,
            ),
            ChangeNotifierProvider(
                create: (context) => _provider,
                builder: (context, child) {
                  final poules =
                      context.watch<PublicPouleProvider>().publicPoules;
                  print(poules?.length);
                  if (poules == null) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.separated(
                    controller: _scrollController,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final poule = poules[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            JoinPublicPoulePage.route(
                              provider: context.read<PublicPouleProvider>(),
                              poule: poule,
                            ),
                          );
                        },
                        child: _PouleCard(
                          pouleName: poule.name,
                          prizePool: poule.poolPrize,
                          daysLeftToJoin:
                              poule.endsAt.difference(DateTime.now()).inDays,
                          logoUrl: poule.iconUrl,
                        ),
                      );
                    },
                    itemCount: poules.length,
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 16,
                      );
                    },
                  );
                }),
          ],
        ),
      ),
    );
  }
}

class _PouleCard extends StatelessWidget {
  const _PouleCard(
      {required this.pouleName,
      required this.prizePool,
      required this.daysLeftToJoin,
      this.logoUrl});

  final String pouleName;
  final int prizePool;
  final int daysLeftToJoin;
  final String? logoUrl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: PouleCardWidget(
        image: LeagueIconWithPlaceholder(
          logoUrl: logoUrl,
        ),
        isActive: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              pouleName,
              style: context.titleH2.copyWith(color: Colors.white),
            ),
            const SizedBox(
              height: 12,
            ),
            RichText(
              text: TextSpan(
                  style: context.labelBold.copyWith(color: Colors.white),
                  children: [
                    TextSpan(
                        text: "prizePool".tr().toUpperCase(),
                        style: context.labelBold.copyWith(color: Colors.white)),
                    const TextSpan(text: ": "),
                    TextSpan(
                        text: prizePool.formatNumber(),
                        style: context.labelBold
                            .copyWith(color: AppColors.primary)),
                    WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: Image.asset(
                          "assets/icons/ic_coins.png",
                          height: 24,
                        )),
                  ]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 14,
            ),
            RoundedContainer(
              child: Text(
                "daysLeftToJoin".tr(args: [daysLeftToJoin.toString()]),
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.italic),
              ),padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            )
          ],
        ),
      ),
    );
  }
}
