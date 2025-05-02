import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart' as dialog;
import 'package:flutter/material.dart';
import 'package:flutter_better_united/constants/extended_theme.dart';
import 'package:flutter_better_united/data/net/auth_manager.dart';
import 'package:flutter_better_united/figma/colors.dart';
import 'package:flutter_better_united/util/ui_util.dart';
import 'package:flutter_better_united/widgets/primary_button.dart';
import 'package:flutter_better_united/widgets/secondary_button.dart';
import 'package:provider/provider.dart';

import '../login/login_page.dart';

class ConfirmDeleteAccountDialog extends StatelessWidget {
  const ConfirmDeleteAccountDialog({Key? key, required this.password})
      : super(key: key);
  final String password;

  static showDialog(BuildContext context, {required String password}) {
    dialog.showDialog(
      context: context,
      builder: (BuildContext _) {
        return ConfirmDeleteAccountDialog(
          password: password,
        );
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
            Text("settingsDeleteTitle".tr(), style: context.titleH1White),
            const SizedBox(height: 24),
            Text("deleteMyAccountSubtitle".tr(),
                textAlign: TextAlign.center, style: context.bodyRegularWhite),
            const SizedBox(
              height: 15,
            ),
            PrimaryButton(
              foregroundColor: AppColors.textError,
              text: "deleteMyAccount".tr(),
              onPressed: () => _deleteAccount(context),
            ),
            const SizedBox(
              height: 10,
            ),
            SecondaryButton.labelText(
              "cancel".tr(),
              onPressed: () {
                context.pop();
              },
            )
          ],
        ),
      ),
    );
  }

  _deleteAccount(BuildContext context) {
    beginLoading();
    context.read<AuthenticatorManager>().deleteUser(password).then((value) {
      endLoading();
      Navigator.of(context)
          .pushNamedAndRemoveUntil(LoginPage.route, (route) => false);
    }).onError(
          (error, stackTrace) => showGenericError(error),
    );
  }
}
