import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/dialog/refill_coin_dialog.dart';
import 'navigation_service.dart';

typedef DialogActionType = Future<dynamic> Function();

/// Detailed description of each pop-up window
class DialogAction {
  DialogAction({this.priorityLevel = 0, required this.action});

  /// Priority
  int priorityLevel;

  ///  Specific popup behavior
  DialogActionType action;
}

///The pop-up window information corresponding to the page, whether there is a pop-up window currently being displayed and the pop-up window array corresponding to the page to be displayed
class DialogDetail {
  DialogDetail({required this.dialogActions});

  bool isShowingDialog = false;
  List<DialogAction> dialogActions;
}

class DialogManager {
  final NavigationService _navigationService;

  ///  The relationship between page routing and the corresponding pop-up window
  final Map<ModalRoute, DialogDetail> _routeDialogMap = {};

  bool getIsShowingState(BuildContext context) {
    ModalRoute<dynamic>? route = ModalRoute.of(context);
    return _routeDialogMap[route]?.isShowingDialog ?? false;
  }

  Future<dynamic> showFlutterDialog(
      {required BuildContext context,
      bool barrierDismissible = true,
      required WidgetBuilder builder,
      int priorityLevel = 0}) {
    fn() {
      return showDialog(
          context: context,
          barrierDismissible: barrierDismissible,
          builder: builder);
    }

    return requestShowDialog(context, fn, priorityLevel: priorityLevel);
  }

  ///  request popup
  Future<dynamic> requestShowDialog(BuildContext context, DialogActionType fn,
      {int priorityLevel = 0}) async {
    ModalRoute<dynamic>? route = ModalRoute.of(context);
    DialogAction dialogAction =
        DialogAction(priorityLevel: priorityLevel, action: fn);

    if (route != null && _routeDialogMap[route] == null) {
      _routeDialogMap[route] = DialogDetail(dialogActions: [dialogAction]);
    } else {
      _routeDialogMap[route]?.dialogActions.add(dialogAction);
      if (_routeDialogMap[route]?.isShowingDialog ?? false) {
        return Future.error(
            'This page already has a pop-up window being displayed, but the pop-up window failed to display',
            StackTrace.current);
      }
    }

    await Future.delayed(Duration.zero);

    int targetIndex = _routeDialogMap[route]?.dialogActions == null
        ? -1
        : _getHighestPriorityIndex(_routeDialogMap[route]!.dialogActions);
    if (targetIndex < 0) {
      return Future.error(
          'No popup action found to execute', StackTrace.current);
    }
    DialogAction? targetAction =
        _routeDialogMap[route]?.dialogActions[targetIndex];

    if (targetAction == dialogAction) {
      _routeDialogMap[route]?.isShowingDialog = true;
      Future<dynamic>? futureResult = targetAction?.action();
      futureResult?.then((_) {
        _routeDialogMap[route]?.isShowingDialog = false;
        _deleteTargetDialogAction(route, targetAction);
        _handleNextDialogAction(context);
      });
      return futureResult;
    } else {
      return Future.error(
          'The priority is not enough, the pop-up window fails to display',
          StackTrace.current);
    }
  }

  ///After the popup is closed, process the next popup in the popup queue above the current route
  Future<dynamic> _handleNextDialogAction(BuildContext context) async {
    ModalRoute<dynamic>? route = ModalRoute.of(context);
    if (!(route?.isActive ?? false)) {
      return Future.error('The corresponding page route has been destroyed',
          StackTrace.current);
    }

    if (!(route?.isCurrent ?? false)) {
      return Future.error(
          'The page is not in the first position of the routing stack',
          StackTrace.current);
    }

    if (_routeDialogMap[route] == null) {
      return Future.error('dialogAction not found', StackTrace.current);
    }

    int targetIndex = _routeDialogMap[route]?.dialogActions == null
        ? -1
        : _getHighestPriorityIndex(_routeDialogMap[route]!.dialogActions);
    if (targetIndex < 0) {
      return Future.value('No popup behavior found to execute');
    }

    await Future.delayed(const Duration(milliseconds: 2000));
    DialogAction? targetAction =
        _routeDialogMap[route]?.dialogActions[targetIndex];
    _routeDialogMap[route]?.isShowingDialog = true;
    Future<dynamic>? futureResult = targetAction?.action();
    futureResult?.then((_) {
      _routeDialogMap[route]?.isShowingDialog = false;
      _deleteTargetDialogAction(route, targetAction);
      _handleNextDialogAction(context);
    });
    return futureResult;
  }

  /// Remove the specified popup behavior
  void _deleteTargetDialogAction(
      ModalRoute? route, DialogAction? dialogAction) {
    if (route == null && dialogAction == null) {
      return;
    }
    for (int i = 0, length = _routeDialogMap[route]!.dialogActions.length;
        i < length;
        i++) {
      if (_routeDialogMap[route]!.dialogActions[i] == dialogAction) {
        _routeDialogMap[route]!.dialogActions.removeAt(i);
        break;
      }
    }
  }

  int _getHighestPriorityIndex(List<DialogAction> dialogList) {
    if (dialogList.isEmpty) {
      return -1;
    }

    if (dialogList.length == 1) {
      return 0;
    }

    int targetIndex = 0;
    int targetPriorityLevel = dialogList[0].priorityLevel;
    for (int i = 0, length = dialogList.length; i < length; i++) {
      int currentPriorityLevel = dialogList[i].priorityLevel;
      if (currentPriorityLevel < targetPriorityLevel) {
        targetIndex = i;
        targetPriorityLevel = currentPriorityLevel;
      }
    }
    return targetIndex;
  }

  DialogManager(this._navigationService);

  displayWeeklyRefillModal() async {
    BuildContext? context =
        _navigationService.navigatorKey.currentState?.context;
    if (context == null) {
      return;
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const RefillCoinDialog();
      },
    );
  }
}

Future<dynamic> showFlutterDialog(
    {required BuildContext context,
    bool barrierDismissible = true,
    required WidgetBuilder builder,
    int priorityLevel = 0}) {
  return context
      .read<DialogManager>()
      .showFlutterDialog(context: context, builder: builder);
}

Future<dynamic> requestShowDialog(BuildContext context, DialogActionType fn,
    {int priorityLevel = 0}) {
  return context
      .read<DialogManager>()
      .requestShowDialog(context, fn, priorityLevel: priorityLevel);
}
