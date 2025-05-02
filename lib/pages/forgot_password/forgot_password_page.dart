import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/pages/forgot_password/email_sent_page.dart';
import 'package:flutter_better_united/pages/forgot_password/forgot_password_provider.dart';
import 'package:flutter_better_united/widgets/input_field.dart';
import 'package:flutter_better_united/widgets/regular_app_bar.dart';
import 'package:provider/provider.dart';

import '../../util/debouncer.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/title_widget.dart';

class ForgotPasswordPage extends StatefulWidget {
  static const String route = '/forgot_password';

  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailDebouncer = Debouncer();
  late String id;
  late String token;
  late ForgotPasswordProvider _forgotPasswordProvider;

  @override
  void dispose() {
    super.dispose();
    _emailDebouncer.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _forgotPasswordProvider = ForgotPasswordProvider(Provider.of(context));
    _forgotPasswordProvider.redirectionEvent.listen((event) {
      if (event) {
        context.pushNamed(EmailSentPage.route);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _forgotPasswordProvider,
      builder: (context, child) => Scaffold(
        appBar: RegularAppBar.withBackButton(
            title: "forgotPasswordTitle".tr(),
            onBackTap: () => Navigator.of(context).pop()),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TitleWidget(
                        subtitle: "enterEmailAddress".tr(),
                        citation: "willSendEmail".tr(),
                      ),
                      InputField(
                        keyboardType: TextInputType.emailAddress,
                        labelText: "email".tr(),
                        onChanged: (value) => _emailDebouncer.run(() {
                          _forgotPasswordProvider.email = value;
                          _forgotPasswordProvider.validate();
                        }),
                      )
                    ],
                  ),
                ),
              ),
              Selector<ForgotPasswordProvider, bool>(
                selector: (p0, p1) => p1.isForgotPasswordAllowed,
                builder: (context, isForgotPasswordAllowed, child) =>
                    PrimaryButton(
                        text: "sendLink".tr(),
                        onPressed: isForgotPasswordAllowed
                            ? () {
                                FocusScope.of(context).unfocus();
                                _forgotPasswordProvider.sendEmail();
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
