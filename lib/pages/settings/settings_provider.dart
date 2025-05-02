import 'package:flutter/cupertino.dart';
import 'package:flutter_better_united/data/repo/settings_repository.dart';
import 'package:flutter_better_united/util/ui_util.dart';

import '../../util/Debouncer.dart';

class SettingsProvider with ChangeNotifier {
  bool allNotification = false;
  bool notificationAppUpdatesEnabled = false;
  bool notificationPoulesEnabled = false;
  bool notificationAccountEnabled = false;
  bool notificationTipEnabled = false;
  final SettingsRepository _settingsRepository;
  final _pushSettingDebouncer =
      Debouncer(delay: const Duration(milliseconds: 1000));

  SettingsProvider(this._settingsRepository);

  fetchPushSettings() async {
    try {
      beginLoading();
      var pushSettings = await _settingsRepository.getPushPreferences();
      notificationAccountEnabled = pushSettings.notificationAccountEnabled;
      notificationPoulesEnabled = pushSettings.notificationPoulesEnabled;
      notificationAppUpdatesEnabled =
          pushSettings.notificationsAppUpdatesEnabled;
      notificationTipEnabled = pushSettings.notificationTipEnabled;
      _checkAllNotificationStatus();
      notifyListeners();
    } catch (exception) {
      showGenericError(exception);
    } finally {
      endLoading();
    }
  }

  _checkAllNotificationStatus() {
    allNotification = notificationAccountEnabled &&
        notificationTipEnabled &&
        notificationPoulesEnabled &&
        notificationAppUpdatesEnabled;
  }

  toggleNotifications(bool value) {
    allNotification = value;
    if (value) {
      notificationAccountEnabled = true;
      notificationPoulesEnabled = true;
      notificationAppUpdatesEnabled = true;
      notificationTipEnabled = true;
    } else {
      notificationAccountEnabled = false;
      notificationPoulesEnabled = false;
      notificationAppUpdatesEnabled = false;
      notificationTipEnabled = false;
    }
  }

  refreshView() {
    _checkAllNotificationStatus();
    notifyListeners();
    _pushSettingDebouncer.run(() {
      _settingsRepository.setPushPreferences(
          notificationAppUpdatesEnabled,
          notificationPoulesEnabled,
          notificationAccountEnabled,
          notificationTipEnabled);
    });
  }
}
