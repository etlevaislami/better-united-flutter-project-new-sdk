import 'package:flutter_better_united/data/net/models/push_preference_request.dart';

class PushSettings {
  final bool notificationsAppUpdatesEnabled;
  final bool notificationPoulesEnabled;
  final bool notificationAccountEnabled;
  final bool notificationTipEnabled;

  PushSettings(
      this.notificationsAppUpdatesEnabled,
      this.notificationPoulesEnabled,
      this.notificationAccountEnabled,
      this.notificationTipEnabled);

  PushSettings.fromPushPreference(PushPreferenceRequest pushPreferenceRequest)
      : this(
            pushPreferenceRequest.notificationAppUpdatesEnabled,
            pushPreferenceRequest.notificationPoulesEnabled,
            pushPreferenceRequest.notificationAccountEnabled,
            pushPreferenceRequest.notificationTipEnabled);
}
