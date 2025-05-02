import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/pages/dialog/delete_account_dialog.dart';
import 'package:flutter_better_united/pages/dialog/logout_dialog.dart';
import 'package:flutter_better_united/pages/dialog/review_dialog.dart';
import 'package:flutter_better_united/pages/settings/settings_about_page.dart';
import 'package:flutter_better_united/pages/settings/settings_language_page.dart';
import 'package:flutter_better_united/pages/settings/settings_push_page.dart';
import 'package:flutter_better_united/util/external_url_launches.dart';
import 'package:flutter_better_united/widgets/regular_app_bar.dart';
import 'package:flutter_better_united/widgets/secondary_button.dart';
import 'package:flutter_better_united/widgets/setting_button.dart';

import '../../util/betterUnited_icons.dart';
import '../../widgets/primary_button.dart';
import '../feed/feeds_page.dart';

class SettingsPage extends StatelessWidget {
  static const String route = "/settings";

  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RegularAppBar.withBackButton(
        title: "settingsTitle".tr(),
        onBackTap: () {
          Navigator.pop(context);
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(
                height: 28,
              ),
              SettingButton(
                  text: "settingsAboutTitle".tr(),
                  prefixIcon: const Icon(
                    BetterUnited.logo,
                    shadows: [
                      Shadow(
                        color: Color.fromRGBO(0, 0, 0, 0.5),
                        offset: Offset(0, 2),
                        blurRadius: 16,
                      ),
                    ],
                    size: 18,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(SettingsAboutPage.route);
                  }),
              const SizedBox(height: 24),
              SettingButton(
                  text: "videosTitle".tr(),
                  prefixIcon: const Icon(
                    BetterUnited.videos,
                    size: 18,
                    shadows: [
                      Shadow(
                        color: Color.fromRGBO(0, 0, 0, 0.5),
                        offset: Offset(0, 2),
                        blurRadius: 16,
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.of(
                      context,
                    ).pushNamed(FeedsPage.route);
                  }),
              const SizedBox(height: 24),
              SettingButton(
                  text: "settingsPushTitle".tr(),
                  prefixIcon: const Icon(
                    BetterUnited.notificationOn,
                    shadows: [
                      Shadow(
                        color: Color.fromRGBO(0, 0, 0, 0.5),
                        offset: Offset(0, 2),
                        blurRadius: 16,
                      ),
                    ],
                    size: 18,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(SettingsPushPage.route);
                  }),
              const SizedBox(height: 24),
              SettingButton(
                text: "settingsLanguageTitle".tr(),
                prefixIcon: const Icon(
                  BetterUnited.bubbleChat,
                  shadows: [
                    Shadow(
                      color: Color.fromRGBO(0, 0, 0, 0.5),
                      offset: Offset(0, 2),
                      blurRadius: 16,
                    ),
                  ],
                  size: 18,
                ),
                onPressed: () {
                  const args = SettingsLanguagePageArgs(
                    fromRoute: route,
                  );
                  Navigator.of(context).pushNamed(SettingsLanguagePage.route, arguments: args);
                },
              ),
              const SizedBox(height: 24),
              SettingButton(
                text: "settingsTermsTitle".tr(),
                prefixIcon: const Icon(
                  BetterUnited.document,
                  shadows: [
                    Shadow(
                      color: Color.fromRGBO(0, 0, 0, 0.5),
                      offset: Offset(0, 2),
                      blurRadius: 16,
                    ),
                  ],
                  size: 18,
                ),
                onPressed: () {
                  launchTermsAndConditionUrl();
                },
              ),
              const SizedBox(height: 24),
              SettingButton(
                text: "settingsPrivacyTitle".tr(),
                prefixIcon: const Icon(
                  BetterUnited.document,
                  shadows: [
                    Shadow(
                      color: Color.fromRGBO(0, 0, 0, 0.5),
                      offset: Offset(0, 2),
                      blurRadius: 16,
                    ),
                  ],
                  size: 18,
                ),
                onPressed: () {
                  launchPrivacyPolicyUrl();
                },
              ),
              const SizedBox(height: 24),
              SettingButton(
                text: "settingsMarketingTitle".tr(),
                prefixIcon: const Icon(
                  BetterUnited.document,
                  shadows: [
                    Shadow(
                      color: Color.fromRGBO(0, 0, 0, 0.5),
                      offset: Offset(0, 2),
                      blurRadius: 16,
                    ),
                  ],
                  size: 18,
                ),
                onPressed: () {
                  launchBookmakersUrl();
                },
              ),
              const SizedBox(height: 24),
              SettingButton(
                  text: "rateAppSetting".tr(),
                  prefixIcon: const Icon(
                    BetterUnited.bubbleStar,
                    shadows: [
                      Shadow(
                        color: Color.fromRGBO(0, 0, 0, 0.5),
                        offset: Offset(0, 2),
                        blurRadius: 16,
                      ),
                    ],
                    size: 18,
                  ),
                  onPressed: () {
                    ReviewDialog.showDialog(context);
                  }),
              const SizedBox(
                height: 28,
              ),
              PrimaryButton(
                text: "settingsLogoutTitle".tr(),
                onPressed: () {
                  LogoutDialog.showDialog(context);
                },
              ),
              const SizedBox(height: 24),
              SecondaryButton.labelText(
                "settingsDeleteTitle".tr(),
                onPressed: () {
                  DeleteAccountDialog.showDialog(context);
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
