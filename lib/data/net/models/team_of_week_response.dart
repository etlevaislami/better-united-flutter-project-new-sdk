import 'package:flutter_better_united/data/net/models/ranked_participant_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'team_of_week_response.g.dart';

@JsonSerializable()
class TeamOfWeekResponse {
  final bool? userHasWon;
  final bool? isClaimed;
  final double? amountToClaim;
  final List<RankedParticipantResponse> team;
  final DateTime startDate;
  final DateTime endDate;

  factory TeamOfWeekResponse.fromJson(Map<String, dynamic> json) =>
      _$TeamOfWeekResponseFromJson(json);

  TeamOfWeekResponse(
      this.userHasWon, this.isClaimed, this.amountToClaim, this.team, this.startDate, this.endDate);

  Map<String, dynamic> toJson() => _$TeamOfWeekResponseToJson(this);
}
