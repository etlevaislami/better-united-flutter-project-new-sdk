import 'dart:convert';

import '../data/model/league_invitation.dart';
import '../run.dart';

class Settings {
  static const weeklyRefillDisplayDateKey = "weekly_refill_display_date_key";
  static const pushTokenKey = "push_token_key";
  static const leagueInvitationKey = "league_invitation_key";
  static const friendPouleRulesDisplayKey = "friend_poule_rules_display_key";

  String? get weeklyRefillDisplayDate =>
      sharedPreferences.getString(weeklyRefillDisplayDateKey);

  updateWeeklyRefillDisplayDate(String date) =>
      sharedPreferences.setString(weeklyRefillDisplayDateKey, date);

  String? get pushToken => sharedPreferences.getString(pushTokenKey);

  updatePushToken(String token) =>
      sharedPreferences.setString(pushTokenKey, token);

  LeagueInvitation? get leagueInvitation {
    var data = sharedPreferences.getString(leagueInvitationKey);
    return data == null ? null : LeagueInvitation.fromJson(jsonDecode(data));
  }

  storeLeagueInvitation(LeagueInvitation leagueInvitation) async {
    await sharedPreferences.setString(
        leagueInvitationKey, jsonEncode(leagueInvitation));
  }

  clearLeagueInvitation() => sharedPreferences.remove(leagueInvitationKey);

  bool get isFriendRulesVisible =>
      sharedPreferences.getBool(friendPouleRulesDisplayKey) ?? true;

  set isFriendRulesVisible(bool value) =>
      sharedPreferences.setBool(friendPouleRulesDisplayKey, value);
}
