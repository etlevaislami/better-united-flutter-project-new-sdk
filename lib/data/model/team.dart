import 'package:flutter_better_united/data/net/models/match_response.dart';

class Team {
  final int id;
  final String name;
  final String? logoUrl;
  bool isAddedToFavorite = false;

  Team(this.id, this.name, this.logoUrl);

  Team.fromTeamResponse(TeamResponse teamResponse)
      : this(teamResponse.id, teamResponse.name, teamResponse.logoUrl);
}
