import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/constants/extended_theme.dart';
import 'package:flutter_better_united/widgets/welcome_to_widget.dart';

import '../../widgets/base_dialog.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/secondary_button.dart';

enum WelcomeToPouleDialogAction { challengeFriends, backToOverview }

class WelcomeToPouleDialog extends StatelessWidget {
  const WelcomeToPouleDialog({super.key, required this.pouleName});

  final String pouleName;

  static Future<dynamic> displayDialog(BuildContext context,
      {required String pouleName}) {
    return showDialog(
      useSafeArea: false,
      barrierDismissible: false,
      context: context,
      useRootNavigator: false,
      builder: (context) => WelcomeToPouleDialog(
        pouleName: pouleName,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: BaseDialog(
        withAnimation: true,
        withConfetti: false,
        icon: Transform.scale(
          scale: 1.2,
          child: Image.asset("assets/images/img_league.png"),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 32),
              WelcomeToWidget(name: pouleName),
              const SizedBox(height: 6),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "claimPouleTopSpot".tr(),
                  textAlign: TextAlign.center,
                  style: context.bodyRegularWhite,
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: PrimaryButton(
                  confineInSafeArea: false,
                  text: "challengeMyFriends".tr(),
                  onPressed: () {
                    context.pop(WelcomeToPouleDialogAction.challengeFriends);
                  },
                ),
              ),
              const SizedBox(height: 8),
              SecondaryButton.labelText(
                "backToOverview".tr(),
                withUnderline: true,
                onPressed: () {
                  context.pop(WelcomeToPouleDialogAction.backToOverview);
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
