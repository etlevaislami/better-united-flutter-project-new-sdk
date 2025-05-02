import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/pages/login/login_page.dart';
import 'package:flutter_better_united/widgets/primary_button.dart';

import '../../widgets/regular_app_bar.dart';

class EmailSentPage extends StatefulWidget {
  static const String route = '/email_sent';

  const EmailSentPage({Key? key}) : super(key: key);

  @override
  State<EmailSentPage> createState() => _EmailSentPageState();
}

class _EmailSentPageState extends State<EmailSentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RegularAppBar.withBackButton(
          title: "forgotPasswordTitle".tr(),
          onBackTap: () => Navigator.of(context).pop()),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Align(
                  alignment: const Alignment(0, -0.5),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/bu_bubble.png",
                          width: 90,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          child:
                              Text("linkSent".tr(), style: context.bodyMedium)
                                  .bold(),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Text("linkSentInfo".tr(),
                              style: context.bodyMedium,
                              textAlign: TextAlign.center),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            PrimaryButton(
              text: "ok".tr(),
              onPressed: () => Navigator.of(context)
                  .pushNamedAndRemoveUntil(LoginPage.route, (route) => false),
            ),
          ],
        ),
      ),
    );
  }
}
