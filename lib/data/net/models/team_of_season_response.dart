import 'package:flutter_better_united/data/net/models/ranked_participant_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'team_of_season_response.g.dart';

@JsonSerializable()
class TeamOfSeasonResponse {
  final bool? userHasWon;
  final bool? isClaimed;
  final double? amountToClaim;
  final List<RankedParticipantResponse> team;
  final DateTime startDate;
  final DateTime endDate;

  factory TeamOfSeasonResponse.fromJson(Map<String, dynamic> json) =>
      _$TeamOfSeasonResponseFromJson(json);

  TeamOfSeasonResponse(
      this.userHasWon, this.isClaimed, this.amountToClaim, this.team, this.startDate, this.endDate);

  Map<String, dynamic> toJson() => _$TeamOfSeasonResponseToJson(this);
}
