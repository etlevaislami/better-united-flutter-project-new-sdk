enum PushType {
  login,
  friendLeagueInvitation,
  friendInvitationAccepted,
  finishedFriendLeague,
  finishedPublicLeague,
  tipSettlement,
  publicLeagueInvitation,
  publicLeagueCreation,
  teamOfWeekWin,
  teamOfWeekLose,
  teamOfSeasonWin,
  teamOfSeasonLose;

  static const weeklyRankingPushTypes = [teamOfWeekWin, teamOfWeekLose];
  static const seasonalRankingPushTypes = [teamOfSeasonWin, teamOfSeasonLose];
}
