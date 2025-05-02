import 'dart:ui';

import 'package:devicelocale/devicelocale.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/data/net/auth_manager.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as time_ago;

import '../pages/shop/user_provider.dart';
import '../run.dart';

const languageKey = "LANGUAGE_KEY";

const english = Locale(
  englishLanguageCode,
);
const dutch = Locale(
  dutchLanguageCode,
);

const englishId = 1;
const dutchId = 2;
const englishLanguageCode = "en";
const dutchLanguageCode = "nl";

int getLanguageIdByLocale(Locale locale) {
  final languageLocale = Locale(locale.languageCode);
  return languageLocale == dutch ? dutchId : englishId;
}

bool isLocaleSupported(Locale locale) {
  return (locale.languageCode == dutchLanguageCode) ||
      (locale.languageCode == englishLanguageCode);
}

Future<Locale> getPreferredLocale() async {
  // check current locale
  Locale? deviceLocale = await Devicelocale.currentAsLocale;
  final languageCode = deviceLocale?.languageCode;
  logger.e(deviceLocale);
  if (deviceLocale != null) {
    //check if language is supported

    if (languageCode == english.languageCode ||
        languageCode == dutch.languageCode) {
      logger.i("using phone's default language $deviceLocale");
      return deviceLocale;
    }
    // look for preferred language
    List languages = await Devicelocale.preferredLanguagesAsLocales;
    int englishIndex = languages.indexOf(english);
    int dutchIndex = languages.indexOf(dutch);

    if (englishIndex == -1 && dutchIndex == -1) {
      logger.i("defaulting to english");
      return english;
    }

    if (englishIndex == -1) {
      logger.i("english not found, defaulting to Dutch");
      return dutch;
      // use dutch
    }

    if (dutchIndex == -1) {
      // use english
      logger.i("dutch not found, defaulting to english");
      return english;
    }

    // get the lowest index (highest priority)
    if (englishIndex < dutchIndex) {
      // use english
      logger.i("English is preferred over Dutch");
      return english;
    } else {
      //use dutch
      logger.i("Dutch is preferred over English");
      return dutch;
    }
  }
  logger.i("Could not get preferred language, defaulting to English");
  return english;
}

Future<bool> saveLocale(Locale locale) {
  logger.e("saveLocale");
  return sharedPreferences.setString("languageKey", locale.languageCode);
}

Locale? getSavedLocale() {
  final languageCode = sharedPreferences.getString("languageKey");
  logger.e(languageCode);
  return languageCode == null ? null : Locale(languageCode);
}

extension BuildContextLocalizationExtension on BuildContext {
  /// Change app locale
  Future<void> applyLocale(Locale val) async {
    await saveLocale(val);
    await EasyLocalization.of(this)!.setLocale(val);
    Intl.defaultLocale = val.languageCode;
    time_ago.setDefaultLocale(val.languageCode);
  }

  Future<bool> syncLanguage() async {
    if (await Devicelocale.isLanguagePerAppSettingSupported) {
      final locale = await Devicelocale.currentAsLocale;
      if (locale != null) {
        if (this.locale.languageCode != locale.languageCode) {
          if (!isLocaleSupported(locale)) {
            Devicelocale.setLanguagePerApp(this.locale);
            return false;
          }
          final deviceLocale = Locale(locale.languageCode, "");
          logger.i("syncing language with API");
          try {
            if (await read<AuthenticatorManager>().isAuthenticated()) {
              await read<UserProvider>().updateRemoteLanguage(deviceLocale);
            }
            applyLocale(deviceLocale);
            return true;
          } catch (e) {
            logger.e(e);
            Devicelocale.setLanguagePerApp(this.locale);
            return false;
          }
        }
      }
    }
    return false;
  }
}
