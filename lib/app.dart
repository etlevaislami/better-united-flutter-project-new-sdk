import 'dart:ui' as ui;

import 'package:advanced_in_app_review/advanced_in_app_review.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/constants/theme_constants.dart';
import 'package:flutter_better_united/pages/feed/feeds_page.dart';
import 'package:flutter_better_united/pages/feed/video_page.dart';
import 'package:flutter_better_united/pages/forgot_password/email_sent_page.dart';
import 'package:flutter_better_united/pages/forgot_password/forgot_password_page.dart';
import 'package:flutter_better_united/pages/login/login_page.dart';
import 'package:flutter_better_united/pages/nav_page.dart';
import 'package:flutter_better_united/pages/profile/create_profile_page.dart';
import 'package:flutter_better_united/pages/profile/my_profile_page.dart';
import 'package:flutter_better_united/pages/register/register_page.dart';
import 'package:flutter_better_united/pages/reset_password/reset_password_page.dart';
import 'package:flutter_better_united/pages/settings/settings_about_page.dart';
import 'package:flutter_better_united/pages/settings/settings_language_page.dart';
import 'package:flutter_better_united/pages/settings/settings_marketing_page.dart';
import 'package:flutter_better_united/pages/settings/settings_page.dart';
import 'package:flutter_better_united/pages/settings/settings_privacy_page.dart';
import 'package:flutter_better_united/pages/settings/settings_push_page.dart';
import 'package:flutter_better_united/pages/settings/settings_terms_conditions_page.dart';
import 'package:flutter_better_united/pages/shop/shop_page.dart';
import 'package:flutter_better_united/pages/splashscreen/splashscreen.dart';
import 'package:flutter_better_united/pages/tutorial/start_tutorial_page.dart';
import 'package:flutter_better_united/pages/tutorial/tutorial_consts.dart';
import 'package:flutter_better_united/pages/tutorial/tutorial_launcher_page.dart';
import 'package:flutter_better_united/run.dart';
import 'package:flutter_better_united/util/custom_scroll_behavior.dart';
import 'package:flutter_better_united/util/locale_util.dart';
import 'package:flutter_better_united/util/navigation_service.dart';
import 'package:flutter_better_united/util/ui_util.dart';
import 'package:flutter_better_united/widgets/dismiss_keyboard.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import 'flavors.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(ui.AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        _onResumed();
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        break;
    }
  }

  Future<void> _onResumed() async {
    if (await context.syncLanguage()) {
      showToast("languageChanged".tr());
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    AdvancedInAppReview()
        .setMinDaysBeforeRemind(7)
        .setMinDaysAfterInstall(2)
        .setMinLaunchTimes(1)
        .monitor();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _flavorBanner(
      show: F.appFlavor != Flavor.prod,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: context.read<NavigationService>().navigatorKey,
        title: F.title,
        theme: darkTheme,
        themeMode: ThemeMode.dark,
        home: const SplashScreen(),
        routes: {
          SplashScreen.route: (context) => const SplashScreen(),
          NavPage.route: (context) => const NavPage(),
          LoginPage.route: (context) => const LoginPage(),
          ForgotPasswordPage.route: (context) => const ForgotPasswordPage(),
          ResetPasswordPage.route: (context) => const ResetPasswordPage(),
          EmailSentPage.route: (context) => const EmailSentPage(),
          RegisterPage.route: (context) => const RegisterPage(),
          CreateProfilePage.route: (context) => const CreateProfilePage(),
          SettingsPage.route: (context) => const SettingsPage(),
          SettingsAboutPage.route: (context) => const SettingsAboutPage(),
          SettingsPushPage.route: (context) => const SettingsPushPage(),
          SettingsLanguagePage.route: (context) {
            final args = ModalRoute.of(context)!.settings.arguments
                as SettingsLanguagePageArgs?;
            return SettingsLanguagePage(args: args);
          },
          SettingsTermsConditionsPage.route: (context) =>
              const SettingsTermsConditionsPage(),
          SettingsPrivacyPage.route: (context) => const SettingsPrivacyPage(),
          SettingsMarketingPage.route: (context) =>
              const SettingsMarketingPage(),
          FeedsPage.route: (context) => const FeedsPage(),
          MyProfilePage.routeName: (context) => const MyProfilePage(),
          VideoPage.route: (context) => const VideoPage(),
          ShopPage.routeName: (context) => const ShopPage(),
          TutorialLauncherPage.route: (context) => const TutorialLauncherPage(),
          StartTutorialPage.route: (context) {
            analytics.logEvent(name: TutorialUtils.tutorialStartedStepEvent);
            analytics.logEvent(
                name: TutorialUtils.tutorialStepEvent,
                parameters: {
                  TutorialUtils.stepParamKey: TutorialUtils.welcomeStep
                });
            return const StartTutorialPage();
          },
        },
        builder: (context, child) {
          return FlutterEasyLoading(
            child: ScrollConfiguration(
              behavior: CustomScrollBehavior(),
              child: DismissKeyboard(
                child: child ?? const SizedBox(),
              ),
            ),
          );
        },
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
      ),
    );
  }

  Widget _flavorBanner({
    required Widget child,
    bool show = true,
  }) =>
      show
          ? Directionality(
              textDirection: ui.TextDirection.ltr,
              child: Banner(
                child: child,
                location: BannerLocation.bottomStart,
                message: F.name,
                color: Colors.green.withOpacity(0.6),
                textStyle: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 12.0,
                    letterSpacing: 1.0),
              ),
            )
          : Container(
              child: child,
            );
}
