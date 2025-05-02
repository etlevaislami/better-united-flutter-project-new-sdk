import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_better_united/util/deeplinks/deep_link_handler_providers.dart';

import '../../flavors.dart';
import '../../run.dart';
import '../navigation_service.dart';

class DeepLinkManager {
  final NavigationService _navigationService;

  bool pendingDeeplink = false;
  Uri? uri;

  DeepLinkManager(this._navigationService) {
    _handleIncomingLinks();
  }

  initializeUri() async {
    try {
      final PendingDynamicLinkData? data =
          await FirebaseDynamicLinks.instance.getInitialLink();
      final Uri? deepLink = data?.link;
      uri = deepLink;

      if (deepLink != null) {
        final link = deepLink.toString();
        logger.i("got deeplink $link");
      }
    } catch (e) {
      logger.e(e);
    }
  }

  /// Handle the initial Uri - the one the app was started with
  ///
  /// **ATTENTION**: `getInitialLink`/`getInitialUri` should be handled
  /// ONLY ONCE in your app's lifetime, since it is not meant to change
  /// throughout your app's life.
  ///
  /// We handle all exceptions, since it is called from initState.
  handleInitialUri() {
    // In this example app this is an almost useless guard, but it is here to
    // show we are not going to call getInitialUri multiple times, even if this
    // was a widget that will be disposed of (ex. a navigation route change).
    final Uri? uri = this.uri;
    try {
      if (!pendingDeeplink) {
        if (uri == null) {
          pendingDeeplink = false;
          logger.i('no initial uri');
        } else {
          pendingDeeplink = true;
          logger.i('got initial uri: $uri');
          if (_navigationService.getContext() != null) {
            _handleDeeplink(_navigationService.getContext()!, uri,
                isInitial: true);
            this.uri = null;
          }
        }
      }
    } on PlatformException {
      // Platform messages may fail but we ignore the exception
      logger.e('failed to get initial uri');
    } on FormatException {
      logger.e('malformed initial uri');
    }
  }

  _handleDeeplink(BuildContext context, Uri uri, {bool isInitial = false}) {
    for (var handler in deepLinkHandlers) {
      if (handler.canHandleDeepLink(uri)) {
        handler.handle(context, uri, isInitial);
        return;
      }
    }
  }

  /// Handle incoming links - the ones that the app will received from the OS
  /// while already started.
  void _handleIncomingLinks() {
    FirebaseDynamicLinks.instance.onLink.listen((event) {
      logger.i('got uri: ${event.link}');
      if (_navigationService.getContext() != null) {
        _handleDeeplink(_navigationService.getContext()!, event.link);
      }
    });
  }

  Future<ShortDynamicLink> createLink(
      LinkType type, Map<String, String?> parameters) async {
    String link = F.deepLink + "/";
    List<String> parameterStrings = [];
    link += '?type=${type.toString()}';

    if (parameters.isNotEmpty) {
      link += '&';

      for (int i = 0; i < parameters.length; i++) {
        final key = parameters.keys.elementAt(i);
        parameterStrings.add("$key=${parameters[key]}");
      }

      link += parameterStrings.join('&');
    }

    final linkParameters = DynamicLinkParameters(
      uriPrefix: F.deepLink,
      link: Uri.parse(link),
      androidParameters: AndroidParameters(
        packageName: F.packageName,
        minimumVersion: 0,
      ),
      iosParameters: IOSParameters(
        bundleId: F.packageName,
        minimumVersion: '0',
      ),
    );

    return await FirebaseDynamicLinks.instance.buildShortLink(linkParameters);
  }
}

enum LinkType { none, referral, video }
