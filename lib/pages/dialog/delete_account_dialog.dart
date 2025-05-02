import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart' as dialog;
import 'package:flutter/material.dart';
import 'package:flutter_better_united/constants/extended_theme.dart';
import 'package:flutter_better_united/constants/paddings.dart';
import 'package:flutter_better_united/pages/dialog/confirm_delete_account_dialog.dart';
import 'package:flutter_better_united/pages/login/login_provider.dart';
import 'package:flutter_better_united/widgets/input_field.dart';
import 'package:flutter_better_united/widgets/primary_button.dart';
import 'package:flutter_better_united/widgets/secondary_button.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

import '../../data/net/auth_manager.dart';
import '../../util/Debouncer.dart';

class DeleteAccountDialog extends StatefulWidget {
  const DeleteAccountDialog({Key? key}) : super(key: key);

  @override
  State<DeleteAccountDialog> createState() => _DeleteAccountDialogState();

  static showDialog(BuildContext context) {
    dialog.showDialog(
      context: context,
      builder: (BuildContext _) {
        return const DeleteAccountDialog();
      },
    );
  }
}

class _DeleteAccountDialogState extends State<DeleteAccountDialog> {
  late final LoginProvider _loginProvider;
  final _passwordDebouncer = Debouncer();

  @override
  void dispose() {
    _passwordDebouncer.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loginProvider = LoginProvider(context.read());
    _loginProvider.redirectionEvent.listen((event) {
      switch (event) {
        case LoginEvent.success:
          Navigator.of(context).pop();
          ConfirmDeleteAccountDialog.showDialog(context,
              password: _loginProvider.password);
          break;
        default:
          // do nothing
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: const FlutterSecureStorage()
          .read(key: AuthenticatorManager.emailAddress),
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        _loginProvider.email = snapshot.data ?? "";
        return ChangeNotifierProvider(
          create: (context) => _loginProvider,
          builder: (context, child) => Dialog(
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
                  vertical16,
                  Text("settingsDeleteSubtitle".tr(),
                      textAlign: TextAlign.center,
                      style: context.bodyRegularWhite),
                  vertical40,
                  Selector<LoginProvider, String?>(
                      selector: (p0, p1) => p1.validationMessage,
                      builder: (context, validationMessage, child) =>
                          InputField(
                            labelText: "password".tr(),
                            obscureText: true,
                            errorText: validationMessage != null
                                ? "wrongPassword".tr()
                                : null,
                            onChanged: (value) => _passwordDebouncer.run(() {
                              _loginProvider.password = value;
                              _loginProvider.validate();
                            }),
                          )),
                  Selector<LoginProvider, bool>(
                      selector: (p0, p1) => p1.isLoginAllowed,
                      builder: (context, isLoginAllowed, child) =>
                          PrimaryButton(
                            text: "continue".tr(),
                            onPressed: isLoginAllowed
                                ? () => _loginProvider.loginWithCredentials()
                                : null,
                          )),
                  SecondaryButton.labelText("cancel".tr(), onPressed: () {
                    Navigator.pop(context);
                  }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
