import 'package:flutter_better_united/data/model/public_league_info.dart';

import '../net/models/active_poule_list_response.dart';
import 'friend_league_info.dart';

class ActivePouleList {
  final List<FriendLeagueInfo> friendLeagues;
  final List<PublicLeagueInfo> publicLeagues;

  ActivePouleList({required this.friendLeagues, required this.publicLeagues});

  ActivePouleList.fromActivePouleListResponse(ActivePouleListResponse response)
      : friendLeagues = response.friendLeagues
            .map((item) =>
                FriendLeagueInfo.fromFriendLeagueActivePouleItem(item))
            .toList(),
        publicLeagues = response.publicLeagues
            .map((item) =>
                PublicLeagueInfo.fromPublicLeagueActivePouleItem(item))
            .toList();
}
