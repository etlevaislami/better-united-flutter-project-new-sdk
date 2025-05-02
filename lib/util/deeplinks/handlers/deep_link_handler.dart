import 'package:flutter/cupertino.dart';

abstract class DeepLinkHandler {
  /// Checks if the map contains the correct data
  bool canHandleDeepLink(Uri link);

  /// Triggered when [canHandleDeepLink] returns true
  void handle(BuildContext context, Uri uri, bool isInitial);
}
