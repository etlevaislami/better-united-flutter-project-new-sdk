import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/constants/app_colors.dart';
import 'package:flutter_better_united/pages/login/login_page.dart';
import 'package:flutter_better_united/pages/profile/create_profile_page.dart';
import 'package:flutter_better_united/pages/register/register_provider.dart';
import 'package:flutter_better_united/util/external_url_launches.dart';
import 'package:flutter_better_united/widgets/authentication_title_widget.dart';
import 'package:flutter_better_united/widgets/input_field.dart';
import 'package:flutter_better_united/widgets/primary_button.dart';
import 'package:provider/provider.dart';

import '../../util/debouncer.dart';
import '../../widgets/check_list_tile.dart';

class RegisterPage extends StatefulWidget {
  static const String route = '/register';

  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailDebouncer = Debouncer();
  final _passwordDebouncer = Debouncer();
  final _confirmPasswordDebouncer = Debouncer();
  late RegisterProvider _registerProvider;

  @override
  void dispose() {
    super.dispose();
    _emailDebouncer.dispose();
    _passwordDebouncer.dispose();
    _confirmPasswordDebouncer.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _registerProvider = RegisterProvider(context.read(), context.read());
    _registerProvider.redirectionEvent.listen((event) {
      context.pushNamed(CreateProfilePage.route);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => _registerProvider,
        builder: (context, child) => Scaffold(
              resizeToAvoidBottomInset: false,
              bottomNavigationBar: SafeArea(
                minimum: const EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      PrimaryButton(
                          text: "registerButton".tr(),
                          onPressed: context
                                  .watch<RegisterProvider>()
                                  .isRegisterAllowed
                              ? () {
                                  FocusScope.of(context).unfocus();
                                  _registerProvider.register();
                                }
                              : null),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "alreadyHaveAccount".tr(),
                            style: context.bodyMedium,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () {
                              context.pushNamed(LoginPage.route);
                            },
                            child: Text(
                              "login".tr(),
                              style: context.bodyMedium?.copyWith(
                                  color: AppColors.primaryColor,
                                  decorationThickness: 3,
                                  decoration: TextDecoration.underline),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            AuthenticationTitleWidget(
                                title: "registerAccount".tr()),
                            InputField(
                                allocateSpaceForTextError: false,
                                keyboardType: TextInputType.emailAddress,
                                labelText: "email".tr(),
                                errorText: context
                                    .watch<RegisterProvider>()
                                    .emailValidationMessage,
                                onChanged: (value) => _emailDebouncer.run(() {
                                      _registerProvider.email = value;
                                      _registerProvider.validate();
                                    })),
                            const SizedBox(
                              height: 16,
                            ),
                            InputField(
                              isErrorTextVisible: false,
                              labelText: "password".tr(),
                              obscureText: true,
                              errorText: context
                                  .watch<RegisterProvider>()
                                  .passwordValidationMessage,
                              onChanged: (value) => _passwordDebouncer.run(() {
                                _registerProvider.password = value;
                                _registerProvider.validate();
                              }),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            InputField(
                              labelText: "confirmPassword".tr(),
                              obscureText: true,
                              errorText: context
                                  .watch<RegisterProvider>()
                                  .passwordValidationMessage,
                              onChanged: (value) =>
                                  _confirmPasswordDebouncer.run(() {
                                _registerProvider.confirmPassword = value;
                                _registerProvider.validate();
                              }),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            CheckListTile(
                                onTap: () => launchTermsAndConditionUrl(),
                                text: "termsAndCondition".tr(),
                                isActive: context
                                    .watch<RegisterProvider>()
                                    .isTermsAccepted,
                                hasError: context
                                        .watch<RegisterProvider>()
                                        .termsValidationMessage !=
                                    null,
                                onChanged: (value) {
                                  _registerProvider
                                      .updateTermSwitch(value ?? false);
                                }),
                            const SizedBox(
                              height: 12,
                            ),
                            CheckListTile(
                                onTap: () => launchPrivacyPolicyUrl(),
                                text: "privacyPolicy".tr(),
                                isActive: context
                                    .watch<RegisterProvider>()
                                    .isPrivacyAccepted,
                                hasError: context
                                        .watch<RegisterProvider>()
                                        .privacyValidationMessage !=
                                    null,
                                onChanged: (value) {
                                  _registerProvider
                                      .updatePrivacySwitch(value ?? false);
                                }),
                            const SizedBox(
                              height: 12,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                      context
                                              .watch<RegisterProvider>()
                                              .termsAndPrivacyValidationMessage ??
                                          "",
                                      style: context.bodyMedium)
                                  .textColor(const Color(0xffF13E3E)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }

  Container customCheckBox(
      {required bool isActive,
      required bool hasError,
      required ValueChanged<bool?> onChanged}) {
    return Container(
      height: 24,
      width: 24,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primaryColor : const Color(0xff161616),
        border: isActive
            ? null
            : Border.all(
                color: !hasError ? const Color(0xff353535) : AppColors.pink400),
        borderRadius: const BorderRadius.all(
          Radius.circular(4),
        ),
      ),
      child: Transform.scale(
        scale: 1.2,
        child: Checkbox(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          value: isActive,
          onChanged: onChanged,
          checkColor: Colors.white,
          fillColor: WidgetStateProperty.all(Colors.transparent),
        ),
      ),
    );
  }
}