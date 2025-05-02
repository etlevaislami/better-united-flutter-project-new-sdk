import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/util/placeholderText.dart';
import 'package:flutter_better_united/widgets/regular_app_bar.dart';

class SettingsTermsConditionsPage extends StatelessWidget {
  static const String route = "/settings/terms&conditions";

  const SettingsTermsConditionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RegularAppBar.withBackButton(
        title: "settingsTermsTitle".tr(),
        onBackTap: () {},
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24),
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Text(
              placeholderText,
              style: TextStyle(
                height: 1.4,
                letterSpacing: 0.1,
              ),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
