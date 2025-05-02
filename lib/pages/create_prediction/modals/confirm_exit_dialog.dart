import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/constants/extended_theme.dart';
import 'package:flutter_better_united/widgets/primary_button.dart';
import 'package:flutter_better_united/widgets/secondary_button.dart';

import '../../../widgets/base_dialog.dart';

class ConfirmExitDialog extends StatelessWidget {
  const ConfirmExitDialog({Key? key, required this.onConfirmExit})
      : super(key: key);
  final Function onConfirmExit;

  static Future<dynamic> displayDialog(BuildContext context,
      {required Function onConfirmExit}) {
    return showDialog(
      useSafeArea: false,
      barrierDismissible: false,
      context: context,
      useRootNavigator: false,
      builder: (context) => ConfirmExitDialog(
        onConfirmExit: onConfirmExit,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      withConfetti: false,
      withAnimation: false,
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
          Text("stopCreatingPredictionTitle".tr().toUpperCase(),
              textAlign: TextAlign.center, style: context.titleH1),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              "stopCreatingPredictionDescription".tr(),
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
                text: "noContinue".tr(),
                onPressed: () => context.pop()),
          ),
          const SizedBox(
            height: 20,
          ),
          SecondaryButton.labelText(
            "yesBackToOverview".tr(),
            withUnderline: true,
            onPressed: () {
              context.pop();
              onConfirmExit.call();
            },
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

showConfirmExitDialog(BuildContext context) {
  ConfirmExitDialog.displayDialog(context, onConfirmExit: () {
    Navigator.of(context).pop();
  });
}
