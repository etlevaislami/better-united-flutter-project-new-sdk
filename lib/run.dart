import 'package:devicelocale/devicelocale.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_better_united/constants/app_colors.dart';
import 'package:flutter_better_united/data/repo/feed_repository.dart';
import 'package:flutter_better_united/data/repo/league_repository.dart';
import 'package:flutter_better_united/data/repo/profile_repository.dart';
import 'package:flutter_better_united/data/repo/ranking_repository.dart';
import 'package:flutter_better_united/data/repo/settings_repository.dart';
import 'package:flutter_better_united/data/repo/shop_repository.dart';
import 'package:flutter_better_united/data/repo/tip_repository.dart';
import 'package:flutter_better_united/pages/poules/poules_provider.dart';
import 'package:flutter_better_united/pages/ranking/ranking_provider.dart';
import 'package:flutter_better_united/pages/shop/purchase_manager.dart';
import 'package:flutter_better_united/pages/shop/user_provider.dart';
import 'package:flutter_better_united/util/deeplinks/deep_link_manager.dart';
import 'package:flutter_better_united/util/dialog_manager.dart';
import 'package:flutter_better_united/util/locale_util.dart';
import 'package:flutter_better_united/util/navigation_service.dart';
import 'package:flutter_better_united/util/notifications/notification_manager.dart';
import 'package:flutter_better_united/util/settings.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:logger/logger.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeago/timeago.dart' as time_ago;
import 'package:visibility_detector/visibility_detector.dart';

import 'data/net/api_service.dart';
import 'data/net/auth_manager.dart';
import 'data/net/interceptors/auth_interceptor.dart';
import 'data/net/interceptors/error_interceptor.dart';
import 'data/net/interceptors/refresh_token_interceptor.dart';
import 'flavors.dart';

final logger = Logger();
final NavigationService _navigationService = NavigationService();
final _notificationManager = NotificationManager(_navigationService);
final _deepLinkManager = DeepLinkManager(_navigationService);
late final SharedPreferences sharedPreferences;
final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

Future<void> startApp(Widget app) async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  //FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  VisibilityDetectorController.instance.updateInterval = Duration.zero;
  _setupEasyLoading();
  await Firebase.initializeApp();
  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  // Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  // Handle any interaction when the app is in the background
  await _notificationManager.configureNotification();
  await _deepLinkManager.initializeUri();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(_setupDependencies(child: await _setupEasyLocalization(child: app)));
}

_setupEasyLoading() {
  EasyLoading.instance
    ..loadingStyle = EasyLoadingStyle.custom
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.ring
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = AppColors.primaryColor
    ..maskColor = Colors.black.withOpacity(0.3)
    ..maskType = EasyLoadingMaskType.custom
    ..backgroundColor = Colors.transparent
    ..boxShadow = <BoxShadow>[]
    ..indicatorColor = AppColors.primaryColor
    ..textColor = Colors.white
    ..userInteractions = false
    ..dismissOnTap = false;
}

Future<Widget> _setupEasyLocalization({required Widget child}) async {
  await EasyLocalization.ensureInitialized();
  // Add translation messages for timeago library
  time_ago.setLocaleMessages(dutchLanguageCode, time_ago.NlMessages());
  time_ago.setLocaleMessages(englishLanguageCode, time_ago.EnMessages());
  //todo restore when nl translation is provided
  // final savedLocale = getSavedLocale();
  const savedLocale = english;
  late final Locale startLocale;
  if (savedLocale == null) {
    startLocale = await getPreferredLocale();
    await saveLocale(startLocale);
    await Devicelocale.setLanguagePerApp(startLocale);
  } else {
    startLocale = isLocaleSupported(savedLocale) ? savedLocale : english;
  }
  Intl.defaultLocale = startLocale.languageCode;
  time_ago.setDefaultLocale(startLocale.languageCode);
  return EasyLocalization(
      startLocale: startLocale,
      saveLocale: false,
      supportedLocales: const [english, dutch],
      path: 'assets/translations',
      useOnlyLangCode: true,
      // <-- change the path of the translation files
      child: child);
}

Widget _setupDependencies({required Widget child}) {
  final dio = Dio(); // Provide a dio instance
  dio.options.baseUrl = F.baseUrl;
  final apiService = ApiService(dio);
  final settings = Settings();
  final ProfileRepository profileRepository = ProfileRepository(apiService);
  final AuthenticatorManager authenticatorManager =
      AuthenticatorManager(apiService, profileRepository);
  dio.interceptors.add(AuthInterceptor(dio, authenticatorManager));
  dio.interceptors.add(
      RefreshTokenInterceptor(dio, authenticatorManager, _navigationService));
  dio.interceptors.add(PrettyDioLogger(requestBody: true, responseBody: true));
  dio.interceptors.add(ErrorInterceptor());
  final ShopRepository shopRepository = ShopRepository(apiService);
  final dialogManager = DialogManager(_navigationService);
  final TipRepository tipRepository = TipRepository(apiService);
  final UserProvider userProvider = UserProvider(authenticatorManager,
      profileRepository, dialogManager, settings, tipRepository);
  final LeagueRepository leagueRepository =
      LeagueRepository(apiService, settings);
  final RankingRepository rankingRepository =
      RankingRepository(apiService: apiService);
  return MultiProvider(providers: [
    Provider.value(value: rankingRepository),
    Provider.value(value: apiService),
    Provider.value(value: authenticatorManager),
    Provider.value(value: _notificationManager),
    Provider.value(value: _navigationService),
    Provider.value(value: dialogManager),
    Provider.value(value: settings),
    Provider.value(value: _deepLinkManager),
    Provider.value(value: profileRepository),
    Provider.value(value: FeedRepository(apiService)),
    Provider.value(value: SettingsRepository(apiService)),
    Provider.value(value: shopRepository),
    Provider.value(value: PurchaseManager(userProvider, shopRepository)),
    ChangeNotifierProvider.value(value: userProvider),
    Provider.value(value: leagueRepository),
    Provider.value(value: tipRepository),
    ChangeNotifierProvider(
      create: (context) => PoulesProvider(leagueRepository),
    ),
    ChangeNotifierProvider(
      create: (context) => RankingProvider(rankingRepository),
    ),
  ], child: child);
}
