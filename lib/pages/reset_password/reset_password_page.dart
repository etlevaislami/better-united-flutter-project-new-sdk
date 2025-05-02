import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/pages/reset_password/reset_password_provider.dart';
import 'package:flutter_better_united/widgets/input_field.dart';
import 'package:flutter_better_united/widgets/primary_button.dart';
import 'package:flutter_better_united/widgets/regular_app_bar.dart';
import 'package:provider/provider.dart';

import '../../util/debouncer.dart';
import '../../widgets/title_widget.dart';
import '../login/login_page.dart';

class ResetPasswordArguments {
  final String id;
  final String token;

  ResetPasswordArguments(this.id, this.token);
}

class ResetPasswordPage extends StatefulWidget {
  static const String route = '/reset_password';

  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _newPasswordDebouncer = Debouncer();
  final _passwordDebouncer = Debouncer();
  late ResetPasswordProvider _resetPasswordProvider;
  late String id;
  late String token;

  @override
  void dispose() {
    super.dispose();
    _newPasswordDebouncer.dispose();
    _passwordDebouncer.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)!.settings.arguments as ResetPasswordArguments;
    id = args.id;
    token = args.token;
    _resetPasswordProvider =
        ResetPasswordProvider(Provider.of(context), id, token);
    _resetPasswordProvider.redirectionEvent.listen((event) {
      context.pushNamed(LoginPage.route);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _resetPasswordProvider,
      builder: (context, child) => Scaffold(
        appBar: RegularAppBar.withBackButton(
            title: "resetPassword".tr(),
            onBackTap: () => Navigator.of(context).pop()),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Selector<ResetPasswordProvider, String?>(
                  selector: (p0, p1) => p1.validationMessage,
                  builder: (context, validationMessage, child) =>
                      SingleChildScrollView(
                    child: Column(
                      children: [
                        TitleWidget(
                          subtitle: "confirmNewPassword".tr(),
                        ),
                        InputField(
                          keyboardType: TextInputType.emailAddress,
                          labelText: "password".tr(),
                          obscureText: true,
                          isErrorTextVisible: false,
                          errorText: validationMessage == null ? null : " ",
                          onChanged: (value) => _passwordDebouncer.run(() {
                            _resetPasswordProvider.password = value;
                            _resetPasswordProvider.validate();
                          }),
                        ),
                        const SizedBox(height: 16),
                        InputField(
                          labelText: "confirmPassword".tr(),
                          obscureText: true,
                          errorText: validationMessage,
                          onChanged: (value) => _newPasswordDebouncer.run(() {
                            _resetPasswordProvider.confirmPassword = value;
                            _resetPasswordProvider.validate();
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Selector<ResetPasswordProvider, bool>(
                selector: (p0, p1) => p1.isResetPasswordAllowed,
                builder: (context, isResetPasswordAllowed, child) =>
                    PrimaryButton(
                        text: "resetPassword".tr(),
                        onPressed: isResetPasswordAllowed
                            ? () {
                                FocusScope.of(context).unfocus();
                                _resetPasswordProvider.resetPassword();
                              }
                            : null),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
