import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/constants/extended_theme.dart';
import 'package:flutter_better_united/pages/login/login_provider.dart';
import 'package:flutter_better_united/pages/nav_page.dart';
import 'package:flutter_better_united/widgets/input_field.dart';
import 'package:flutter_better_united/widgets/setting_button.dart';
import 'package:provider/provider.dart';

import '../../constants/paddings.dart';
import '../../widgets/authentication_title_widget.dart';
import '../../widgets/or_divider.dart';
import '../../widgets/primary_button.dart';
import '../forgot_password/forgot_password_page.dart';
import '../profile/create_profile_page.dart';
import '../register/register_page.dart';

class LoginPage extends StatefulWidget {
  static const String route = '/login';

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginProvider _loginProvider;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loginProvider = LoginProvider(context.read());
    _loginProvider.redirectionEvent.listen((event) {
      switch (event) {
        case LoginEvent.success:
          Navigator.of(context)
              .pushNamedAndRemoveUntil(NavPage.route, (route) => false);
          break;
        case LoginEvent.createProfile:
          Navigator.of(context).pushNamedAndRemoveUntil(
              CreateProfilePage.route, (route) => false);
          break;
        case LoginEvent.idle:
          // do nothing
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _loginProvider,
      builder: (context, child) => Scaffold(
        body: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Selector<LoginProvider, String?>(
                    selector: (p0, p1) => p1.validationMessage,
                    builder: (context, validationMessage, child) =>
                        SingleChildScrollView(
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        children: [
                          AuthenticationTitleWidget(
                            title: "loginToBetterUnited".tr(),
                          ),
                          //@todo social buttons are hidden for now
                          true
                              ? const SizedBox()
                              : Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    _buildSocialMediaButtons(),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 24),
                                      child: OrDivider(),
                                    ),
                                  ],
                                ),

                          InputField(
                            isErrorTextVisible: false,
                            keyboardType: TextInputType.emailAddress,
                            labelText: "email".tr(),
                            errorText: validationMessage == null ? null : " ",
                            onChanged: (value) {
                              _loginProvider.email = value;
                              _loginProvider.validate();
                            },
                          ),
                          vertical16,
                          InputField(
                              labelText: "password".tr(),
                              obscureText: true,
                              errorText: validationMessage,
                              onChanged: (value) {
                                _loginProvider.password = value;
                                _loginProvider.validate();
                              }),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 27,
                ),
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  child: GestureDetector(
                    onTap: () {
                      context.pushNamed(ForgotPasswordPage.route);
                    },
                    child: Text(
                      "forgotPassword".tr(),
                      style: context.bodyBoldUnderlinePrimary,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 31,
                ),
                Selector<LoginProvider, bool>(
                  selector: (p0, p1) => p1.isLoginAllowed,
                  builder: (context, isLoginAllowed, child) => PrimaryButton(
                      text: "login".tr(),
                      onPressed: isLoginAllowed
                          ? () {
                              FocusScope.of(context).unfocus();
                              _loginProvider.loginWithCredentials();
                            }
                          : null),
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "newUser".tr(),
                      style: context.bodyMedium?.copyWith(color: Colors.white),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        context.pushNamed(RegisterPage.route);
                      },
                      child: Text(
                        "createAccount".tr(),
                        style: context.bodyBoldUnderlinePrimary,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column _buildSocialMediaButtons() {
    return Column(
      children: [
        SettingButton(
            prefixIcon: Transform.translate(
              offset: const Offset(0, 2),
              child: Transform.scale(
                scale: 2.5,
                child: Image.asset(
                  "assets/icons/ic_apple.png",
                  height: 24,
                ),
              ),
            ),
            text: "loginApple".tr(),
            onPressed: () {
              _loginProvider.loginWithApple();
            }),
        const SizedBox(
          height: 16,
        ),
        SettingButton(
            prefixIcon: Transform.translate(
              offset: const Offset(0, 2),
              child: Transform.scale(
                scale: 2.5,
                child: Image.asset(
                  "assets/icons/ic_facebook.png",
                  height: 24,
                ),
              ),
            ),
            text: "loginFacebook".tr(),
            onPressed: () {
              _loginProvider.loginWithFacebook();
            }),
        const SizedBox(
          height: 16,
        ),
        SettingButton(
            prefixIcon: Transform.translate(
              offset: const Offset(0, 2),
              child: Transform.scale(
                scale: 2.5,
                child: Image.asset(
                  "assets/icons/ic_google.png",
                  height: 24,
                ),
              ),
            ),
            text: "loginGoogle".tr(),
            onPressed: () {
              _loginProvider.loginWithGoogle();
            }),
      ],
    );
  }
}
