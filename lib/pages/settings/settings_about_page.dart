import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/widgets/regular_app_bar.dart';

class SettingsAboutPage extends StatelessWidget {
  static const String route = "/settings/about";

  const SettingsAboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RegularAppBar.withBackButton(
        title: "settingsAboutTitle".tr(),
        onBackTap: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
        physics: const BouncingScrollPhysics(),
        child: Text(
          "aboutText".tr(),
          style: const TextStyle(
            height: 1.4,
            letterSpacing: 0.1,
          ),
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}
