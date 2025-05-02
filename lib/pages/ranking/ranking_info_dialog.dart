import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/constants/extended_theme.dart';
import 'package:flutter_better_united/widgets/primary_button.dart';

import '../../../widgets/base_dialog.dart';

class RankingInfoDialog extends StatelessWidget {
  const RankingInfoDialog({Key? key}) : super(key: key);

  static Future<dynamic> displayDialog(
    BuildContext context,
  ) {
    return showDialog(
      useSafeArea: false,
      barrierDismissible: false,
      context: context,
      useRootNavigator: false,
      builder: (context) => const RankingInfoDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      withConfetti: false,
      withAnimation: false,
      positionMultiplier: 1,
      icon: Transform.translate(
        offset: const Offset(0, -10),
        child: Transform.scale(
          scale: 1.2,
          child: Image.asset("assets/images/bu_bubble.png"),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(
            height: 18,
          ),
          Text("ranking".tr().toUpperCase(),
              textAlign: TextAlign.center, style: context.titleH1),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              "rankingDescription".tr(),
              style: context.bodyRegularWhite,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: PrimaryButton(
              confineInSafeArea: false,
              text: "ok".tr(),
              onPressed: () {
                context.pop();
              },
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
