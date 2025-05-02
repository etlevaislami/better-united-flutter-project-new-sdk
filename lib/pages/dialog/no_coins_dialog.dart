import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/constants/extended_theme.dart';
import 'package:flutter_better_united/widgets/primary_button.dart';
import 'package:flutter_better_united/widgets/secondary_button.dart';

import '../../widgets/base_dialog.dart';

class NoCoinsDialog extends StatelessWidget {
  const NoCoinsDialog(
      {Key? key,
      required this.onShopTap,
      required this.onBackPress,
      required this.message})
      : super(key: key);
  final Function onShopTap;
  final Function onBackPress;
  final String message;

  static Future<dynamic> displayDialog(BuildContext context,
      {required Function onShopTap,
      required Function onBackPress,
      required String message}) {
    return showDialog(
      useSafeArea: false,
      barrierDismissible: false,
      context: context,
      useRootNavigator: false,
      builder: (context) => NoCoinsDialog(
        onShopTap: onShopTap,
        onBackPress: onBackPress,
        message: message,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        onBackPress.call();
        return false;
      },
      child: BaseDialog(
        withConfetti: false,
        withAnimation: false,
        icon: Transform.translate(
          offset: const Offset(0, -20),
          child: Transform.scale(
            scale: 1.5,
            child: Image.asset("assets/icons/img_nocoins.png"),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(
              height: 18,
            ),
            Text("notEnoughCoins".tr().toUpperCase(),
                style: context.titleH1White),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                message,
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
                text: "goToShop".tr(),
                onPressed: () => onShopTap.call(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SecondaryButton.labelText(
              "back".tr(),
              withUnderline: true,
              onPressed: () => onBackPress.call(),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
