import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/constants/app_colors.dart';
import 'package:flutter_better_united/pages/dialog/review_dialog.dart';
import 'package:flutter_better_united/pages/settings/settings_about_page.dart';
import 'package:flutter_better_united/pages/settings/settings_language_page.dart';
import 'package:flutter_better_united/pages/settings/settings_privacy_page.dart';
import 'package:flutter_better_united/pages/settings/settings_push_page.dart';
import 'package:flutter_better_united/pages/settings/settings_terms_conditions_page.dart';

getSettingsItems() {
  return [
    SettingsOption(
      label: "settingsAboutTitle".tr(),
      iconPath: "ic_settings_about.png",
      pushNamedString: SettingsAboutPage.route,
    ),
    SettingsOption(
      label: "settingsPushTitle".tr(),
      iconPath: "ic_settings_pushnotification.png",
      pushNamedString: SettingsPushPage.route,
    ),
    SettingsOption(
      label: "settingsLanguageTitle".tr(),
      iconPath: "ic_settings_language.png",
      pushNamedString: SettingsLanguagePage.route,
    ),
    SettingsOption(
      label: "settingsTermsTitle".tr(),
      iconPath: "ic_settings_legal.png",
      pushNamedString: SettingsTermsConditionsPage.route,
    ),
    SettingsOption(
      label: "settingsPrivacyTitle".tr(),
      iconPath: "ic_settings_legal.png",
      pushNamedString: SettingsPrivacyPage.route,
    ),
    SettingsOption(
      label: "rateAppSetting".tr(),
      iconPath: "ic_feedback.png",
      pushNamedString: ReviewDialog.route,
    )
  ];
}

class SettingsOption {
  String label;
  String pushNamedString;
  String iconPath;

  SettingsOption({
    required this.label,
    required this.pushNamedString,
    required this.iconPath,
  });

  Color get foregroundColor {
    return Colors.white;
  }

  Color get backgroundColor {
    return AppColors.greenMedium;
  }
}
