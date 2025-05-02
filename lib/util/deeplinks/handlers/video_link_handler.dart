import 'package:flutter/widgets.dart';
import 'package:flutter_better_united/data/net/auth_manager.dart';
import 'package:flutter_better_united/pages/feed/feeds_page.dart';
import 'package:flutter_better_united/pages/splashscreen/splashscreen.dart';
import 'package:flutter_better_united/util/deeplinks/deep_link_manager.dart';
import 'package:flutter_better_united/util/deeplinks/handlers/deep_link_handler.dart';
import 'package:provider/provider.dart';

class VideoLinkHandler extends DeepLinkHandler {
  final LinkType linkType = LinkType.video;

  @override
  bool canHandleDeepLink(Uri link) {
    return link.queryParameters.containsKey("type") &&
        link.queryParameters["type"] == linkType.toString();
  }

  @override
  Future<void> handle(BuildContext context, Uri uri, bool isInitial) async {
    bool isAuthenticated =
        await context.read<AuthenticatorManager>().isAuthenticated();

    if (!isAuthenticated) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        SplashScreen.route,
        (route) => false,
      );
      return;
    }

    final id = uri.queryParameters["videoId"];
    if (isInitial) {
      Navigator.of(context).pushNamedAndRemoveUntil(
          FeedsPage.route, (route) => false,
          arguments: FeedsArguments(int.parse(id!)));
    } else {
      Navigator.of(context).pushNamed(FeedsPage.route,
          arguments: FeedsArguments(int.parse(id!)));
    }
  }
}
