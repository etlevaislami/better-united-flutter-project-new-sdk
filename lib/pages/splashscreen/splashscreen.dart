import 'package:flutter/widgets.dart';
import 'package:flutter_better_united/pages/login/login_page.dart';
import 'package:flutter_better_united/pages/nav_page.dart';
import 'package:flutter_better_united/util/deeplinks/deep_link_manager.dart';
import 'package:flutter_better_united/util/locale_util.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

import '../../data/net/auth_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const String route = "/splashScreen";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late DeepLinkManager _deepLinkManager;

  @override
  void initState() {
    super.initState();
    _deepLinkManager = context.read<DeepLinkManager>();
    _handleRedirections();
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }

  _handleRedirections() {
    if (_deepLinkManager.uri != null) {
      _handleInitialDeeplink();
    } else {
      _handleInitialRoute();
    }
  }

  Future<void> _handleInitialRoute() async {
    final authManager = context.read<AuthenticatorManager>();
    if (authManager.shouldRemoveCredentials()) {
      await authManager.removeAuthenticationCredentials();
    }

    String route;
    if (await authManager.isAuthenticated()) {
      route = NavPage.route;
    } else {
      route = LoginPage.route;
    }

    context.syncLanguage();

    Navigator.of(context).pushNamedAndRemoveUntil(route, (route) => false);
    _removeSplashScreen();
  }

  _handleInitialDeeplink() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _deepLinkManager.handleInitialUri();
      _removeSplashScreen();
    });
  }

  _removeSplashScreen() {
    Future.delayed(const Duration(milliseconds: 500), () {
      FlutterNativeSplash.remove();
    });
  }
}
