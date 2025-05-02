import 'package:flutter/foundation.dart';
import 'package:flutter_better_united/data/enum/poule_type.dart';
import 'package:flutter_better_united/data/repo/league_repository.dart';

import 'friend_poule_preview_page.dart';

class FriendPoulePreviewProvider with ChangeNotifier {
  final int pouleId;
  final LeagueRepository leagueRepository;
  FriendPoulePreviewData? data;

  FriendPoulePreviewProvider(this.leagueRepository,
      {required this.pouleId, FriendPoulePreviewData? data}) {
    if (data != null) {
      this.data = data;
    }
  }

  void getPouleDetail() async {
    // get data from server
    final result = await leagueRepository.getLeagueDetail(
        leagueId: pouleId, type: PouleType.friend);
    final friendPouleData = result.friendPouleData;
    if (friendPouleData == null) {
      return;
    }
    data = FriendPoulePreviewData(
        poolPrize: result.prizePool ?? 0,
        pouleName: result.name,
        match: friendPouleData.match);
    notifyListeners();
  }
}
