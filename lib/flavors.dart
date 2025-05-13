enum Flavor {
  dev,
  staging,
  prod,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return 'Better united -development';
      case Flavor.staging:
        return 'Better united -staging';
      case Flavor.prod:
        return 'Better united -production';
      default:
        return 'Better united';
    }
  }

  static String get baseUrl {
    switch (appFlavor) {
      case Flavor.staging:
        return 'https://better-united-api.acceptance.d-tt.dev/api';
      case Flavor.prod:
        return 'https://better-united-api.acceptance.d-tt.dev/api';
      case Flavor.dev:
      default:
        return 'https://better-united-api.development.d-tt.dev/api';
    }
  }

  static const clientId = "bu_api";
  static const deeplinkAppReferral = "https://betterunited.page.link/app";
  static const privacyPolicyUrl = "https://better-united.com/privacy-policy";
  static const termsAndConditionUrl =
      "https://better-united.com/terms-and-conditions";
  static const bookmakersUrl = "https://better-united.com/bookmakers";
  static const iosStoreAppId = "1644164331";

  static String get deepLink {
    switch (appFlavor) {
      case Flavor.prod:
        return "https://betterunited.page.link";
      case Flavor.staging:
      case Flavor.dev:
      default:
        return "https://betterunited2.page.link";
    }
  }

  static String get feedbackEmail {
    switch (appFlavor) {
      case Flavor.prod:
        return "info@better-united.com";
      case Flavor.staging:
      case Flavor.dev:
      default:
        return "appsdtt@gmail.com";
    }
  }

  static String get packageName {
    switch (appFlavor) {
      case Flavor.prod:
        return "nl.betterunited";
      case Flavor.staging:
      case Flavor.dev:
      default:
        return "nl.dtt.betterunited";
    }
  }
}
