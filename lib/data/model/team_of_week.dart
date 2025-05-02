import 'package:flutter_better_united/data/model/ranked_participant.dart';
import 'package:flutter_better_united/data/net/models/team_of_week_response.dart';

class TeamOfWeek {
  final bool userHasWon;
  final bool isClaimed;
  final double? amountToClaim;
  final List<RankedParticipant> team;
  final DateTime startDate;
  final DateTime endDate;

  TeamOfWeek({
    required this.userHasWon,
    required this.isClaimed,
    required this.amountToClaim,
    required this.team,
    required this.startDate,
    required this.endDate,
  });

  TeamOfWeek.fromTeamOfWeekResponse(TeamOfWeekResponse response)
      : userHasWon = response.userHasWon ?? false,
        isClaimed = response.isClaimed ?? false,
        amountToClaim = response.amountToClaim,
        team = response.team
            .map((e) => RankedParticipant.fromRankedParticipantResponse(e))
            .toList(),
        startDate = response.startDate,
        endDate = response.endDate;

  bool get hasUnclaimedPrize => userHasWon == true && isClaimed == false;
}
