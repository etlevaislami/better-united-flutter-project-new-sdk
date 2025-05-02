import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_better_united/util/deeplinks/handlers/deep_link_handler.dart';

import '../../../pages/reset_password/reset_password_page.dart';

class ResetPasswordHandler extends DeepLinkHandler {
  final key = "reset-password";

  @override
  bool canHandleDeepLink(Uri link) {
    return link.toString().contains(key);
  }

  @override
  void handle(BuildContext context, Uri uri, bool isInitial) {
    final id = uri.pathSegments[uri.pathSegments.indexOf(key) + 1];
    final token = uri.pathSegments[uri.pathSegments.indexOf(key) + 2];
    if (isInitial) {
      Navigator.of(context).pushNamedAndRemoveUntil(
          ResetPasswordPage.route, (route) => false,
          arguments: ResetPasswordArguments(id, token));
    } else {
      Navigator.of(context).pushNamed(ResetPasswordPage.route,
          arguments: ResetPasswordArguments(id, token));
    }
  }
}
