import 'package:flutter_better_united/util/deeplinks/handlers/reset_password_handler.dart';
import 'package:flutter_better_united/util/deeplinks/handlers/video_link_handler.dart';

import 'handlers/deep_link_handler.dart';
import 'handlers/league_invitation_handler.dart';

List<DeepLinkHandler> deepLinkHandlers = [
  ResetPasswordHandler(),
  VideoLinkHandler(),
  LeagueInvitationHandler()
];
