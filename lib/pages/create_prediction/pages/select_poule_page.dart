import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/data/enum/poule_type.dart';
import 'package:flutter_better_united/pages/create_prediction/create_prediction_provider.dart';
import 'package:flutter_better_united/widgets/info_bubble.dart';
import 'package:flutter_better_united/widgets/loading_indicator.dart';
import 'package:flutter_better_united/widgets/regular_app_bar.dart';
import 'package:provider/provider.dart';

import '../../../widgets/PouleFromPredictionCard.dart';
import '../../../widgets/friend_poule_icon.dart';
import '../../../widgets/league_icon.dart';
import '../modals/confirm_exit_dialog.dart';

class SelectPoulePage extends StatefulWidget {
  const SelectPoulePage({Key? key, required this.pouleType}) : super(key: key);
  final PouleType pouleType;

  @override
  State<SelectPoulePage> createState() => _SelectPoulePageState();
}

class _SelectPoulePageState extends State<SelectPoulePage>
    with AutomaticKeepAliveClientMixin {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<CreatePredictionProvider>().fetchPoules(widget.pouleType);
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
            showConfirmExitDialog(context);
          },
          title: "createPrediction".tr()),
      body: SingleChildScrollView(
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            const SizedBox(
              height: 12,
            ),
            InfoBubble(
              description: "createPredictionDescription".tr(),
            ),
            const SizedBox(
              height: 24,
            ),
            PouleList(scrollController: _scrollController),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class PouleList extends StatelessWidget {
  const PouleList({super.key, required this.scrollController});

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final poules = context.watch<CreatePredictionProvider>().poules;
    if (poules == null) return const LoadingIndicator();
    return ListView.separated(
      controller: scrollController,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final poule = poules[index];
        return PouleFromPredictionCard(
          onTap: () {
            context.read<CreatePredictionProvider>().setSelectedPoule(poule);
          },
          pouleName: poule.name,
          predictionLeft: poule.predictionsLeft,
          startDate: poule.startsAt,
          endDate: poule.endsAt,
          hasEnded: poule.isFinished,
          icon: poule.isPublicLeague
              ? LeagueIconWithPlaceholder(
                  logoUrl: poule.publicPouleData?.imageUrl,
                )
              : const FriendPouleIcon(),
        );
      },
      itemCount: poules.length,
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: 16,
        );
      },
    );
  }
}
