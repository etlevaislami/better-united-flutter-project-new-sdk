import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_better_united/util/notifications/handlers/push_handler.dart';

import '../../../pages/splashscreen/splashscreen.dart';

class DefaultPushHandler extends PushHandler {
  @override
  void handle(Map<String, dynamic> payload, BuildContext context) {
    context.pushNamed(SplashScreen.route);
  }

  @override
  bool displayForegroundNotification = true;
}
