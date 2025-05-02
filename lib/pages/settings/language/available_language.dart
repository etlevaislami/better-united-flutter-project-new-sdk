import 'package:easy_localization/easy_localization.dart';

/// All supported languages for this app
enum SupportedLanguage {
  nl,
  en;

  static SupportedLanguage fromLocale(String locale) {
    switch (locale) {
      case 'en':
        return SupportedLanguage.en;
      case 'nl':
        return SupportedLanguage.nl;
      default:
        return SupportedLanguage.en;
    }
  }
}

extension AvailableLanguageExtension on SupportedLanguage {
  String get name {
    switch (this) {
      case SupportedLanguage.nl:
        return 'dutch'.tr();
      case SupportedLanguage.en:
        return 'english'.tr();
      default:
        return '-';
    }
  }

  String get flagFileLocation {
    switch (this) {
      case SupportedLanguage.nl:
        return 'assets/icons/ic_nl.png';
      case SupportedLanguage.en:
        return 'assets/icons/ic_eg.png';
      default:
        return 'assets/icons/ic_eg.png';
    }
  }
}
