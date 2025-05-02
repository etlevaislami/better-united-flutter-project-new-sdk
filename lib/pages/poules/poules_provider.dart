import 'package:flutter/cupertino.dart';
import 'package:flutter_better_united/data/model/friend_league_info.dart';
import 'package:flutter_better_united/data/repo/league_repository.dart';

import '../../data/enum/poule_type.dart';
import '../../data/model/public_league_info.dart';

class PoulesProvider with ChangeNotifier {
  final LeagueRepository _leagueRepository;
  List<PublicLeagueInfo>? activePublicPoules;
  List<FriendLeagueInfo>? activeFriendPoules;

  int? get activePoulesCount => (activePublicPoules == null ||
          activeFriendPoules == null)
      ? null
      : (activePublicPoules?.length ?? 0) + (activeFriendPoules?.length ?? 0);

  PoulesProvider(this._leagueRepository);

  fetchActivePoules() async {
    final poules = await _leagueRepository.getActivePoules();
    activePublicPoules = poules.publicLeagues;
    activeFriendPoules = poules.friendLeagues;
    if (hasListeners) {
      notifyListeners();
    }
  }

  removePoule(PouleType type, int id) {
    if (type == PouleType.public) {
      activePublicPoules?.removeWhere((element) => element.id == id);
    } else if (type == PouleType.friend) {
      activeFriendPoules?.removeWhere((element) => element.id == id);
    }
    notifyListeners();
  }
}
