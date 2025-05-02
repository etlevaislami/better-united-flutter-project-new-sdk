import 'package:flutter/cupertino.dart';

abstract class PushHandler {
  abstract bool displayForegroundNotification;

  /// Method to handle the Push.
  void handle(final Map<String, dynamic> payload, final BuildContext context);

  void onForegroundMessageReceived(
      final Map<String, dynamic> payload, final BuildContext context) {
    //do nothing by default
  }
}
