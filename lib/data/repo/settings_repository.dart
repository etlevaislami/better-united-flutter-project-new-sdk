import 'package:flutter_better_united/data/model/push_settings.dart';
import 'package:flutter_better_united/data/net/models/push_preference_request.dart';

import '../net/api_service.dart';

class SettingsRepository {
  final ApiService _apiService;

  SettingsRepository(this._apiService);

  Future<PushSettings> getPushPreferences() async {
    var response = await _apiService.getPushPreferences();
    return PushSettings.fromPushPreference(response);
  }

  Future setPushPreferences(
      bool notificationsAppUpdates,
      bool notificationsFriendsLeague,
      bool notificationsTipStatus,
      bool notificationsUserTips) {
    return _apiService.updatePushPreferences(PushPreferenceRequest(
        notificationsAppUpdates,
        notificationsFriendsLeague,
        notificationsTipStatus,
        notificationsUserTips));
  }
}
