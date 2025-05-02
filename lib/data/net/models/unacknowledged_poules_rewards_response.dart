import 'package:json_annotation/json_annotation.dart';

part 'unacknowledged_poules_rewards_response.g.dart';

@JsonSerializable()
class UnacknowledgedPoulesRewardsResponse {
  final List<int> friendPoules;
  final List<int> publicPoules;

  factory UnacknowledgedPoulesRewardsResponse.fromJson(
          Map<String, dynamic> json) =>
      _$UnacknowledgedPoulesRewardsResponseFromJson(json);

  UnacknowledgedPoulesRewardsResponse(this.friendPoules, this.publicPoules);

  Map<String, dynamic> toJson() =>
      _$UnacknowledgedPoulesRewardsResponseToJson(this);
}
