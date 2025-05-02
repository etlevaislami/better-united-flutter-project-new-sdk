import 'package:flutter/foundation.dart';
import 'package:flutter_better_united/data/enum/poule_type.dart';
import 'package:flutter_better_united/data/repo/league_repository.dart';
import 'package:flutter_better_united/pages/poules/public_poule_preview_page.dart';

class PublicPoulePreviewProvider with ChangeNotifier {
  final int pouleId;
  final LeagueRepository leagueRepository;
  PublicPoulePreviewData? data;

  PublicPoulePreviewProvider(this.leagueRepository,
      {required this.pouleId, PublicPoulePreviewData? data}) {
    if (data != null) {
      this.data = data;
    }
  }

  void getPouleDetail() async {
    // get data from server
    final result = await leagueRepository.getLeagueDetail(
        leagueId: pouleId, type: PouleType.public);
    final publicPouleData = result.publicPouleData;
    if (publicPouleData == null) {
      return;
    }
    data = PublicPoulePreviewData(
        matches: publicPouleData.matches,
        prizePool: result.prizePool ?? 0,
        coinsForFirst: publicPouleData.coinsForFirst,
        coinsForSecond: publicPouleData.coinsForSecond,
        coinsForThird: publicPouleData.coinsForThird,
        coinsForOthers: publicPouleData.coinsForOthers,
        leagues: publicPouleData.leagues,
        logoUrl: publicPouleData.imageUrl);

    notifyListeners();
  }
}
