import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

class NavigationService {
  final BehaviorSubject<int> didReceiveNavigationPageIndex =
      BehaviorSubject<int>();

  dynamic extraParam;

  //@TODO optimize
  // used to prevent dialogs from being shown to give priority for push notification dialog
  bool pendingPushNotification = false;

  final navigatorKey = GlobalKey<NavigatorState>();

  BuildContext? getContext() {
    return navigatorKey.currentContext;
  }

  NavigatorState? getNavigatorState() {
    return navigatorKey.currentState;
  }

  clearExtraParam() {
    extraParam = null;
  }
}
