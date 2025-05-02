import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_better_united/pages/login/login_page.dart';
import 'package:flutter_better_united/util/notifications/handlers/push_handler.dart';

class LoginPushHandler extends PushHandler {
  @override
  void handle(Map<String, dynamic> payload, BuildContext context) {
    context.pushNamed(LoginPage.route);
  }

  @override
  bool displayForegroundNotification = true;
}
