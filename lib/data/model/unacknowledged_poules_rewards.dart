import '../net/models/unacknowledged_poules_rewards_response.dart';

class UnacknowledgedPoulesRewards {
  final List<int> publicPoules;
  final List<int> friendPoules;

  UnacknowledgedPoulesRewards(this.publicPoules, this.friendPoules);

  UnacknowledgedPoulesRewards.fromUnacknowledgedPoulesRewardsResponse(
      UnacknowledgedPoulesRewardsResponse response)
      : this(
          response.publicPoules,
          response.friendPoules,
        );
}
