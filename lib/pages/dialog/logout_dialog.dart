import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart' as dialog;
import 'package:flutter/material.dart';
import 'package:flutter_better_united/constants/extended_theme.dart';
import 'package:flutter_better_united/widgets/primary_button.dart';
import 'package:flutter_better_united/widgets/secondary_button.dart';
import 'package:provider/provider.dart';

import '../../data/net/auth_manager.dart';
import '../login/login_page.dart';
import '../shop/user_provider.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({Key? key}) : super(key: key);

  static showDialog(BuildContext context) {
    dialog.showDialog(
      context: context,
      builder: (BuildContext _) {
        return const LogoutDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xff2B2B2B),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("settingsLogoutLabel".tr().toUpperCase(),
                style: context.titleH1White),
            const SizedBox(
              height: 16,
            ),
            Text(
              "settingsLogoutSubtitle".tr(),
              textAlign: TextAlign.center,
              style: context.bodyRegularWhite,
            ),
            const SizedBox(
              height: 30,
            ),
            PrimaryButton(
              text: "settingsLogoutLabel".tr(),
              onPressed: () {
                _logout(context);
              },
            ),
            const SizedBox(
              height: 10,
            ),
            SecondaryButton.labelText("cancel".tr(), onPressed: () {
              Navigator.of(context).pop();
            }),
          ],
        ),
      ),
    );
  }

  _logout(BuildContext context) async {
    context.read<UserProvider>().clearRemotePushToken();
    await context
        .read<AuthenticatorManager>()
        .removeAuthenticationCredentials();
    Navigator.of(context)
        .pushNamedAndRemoveUntil(LoginPage.route, (route) => false);
  }
}
