import 'package:flutter/cupertino.dart';
import 'package:flutter_better_united/util/exceptions/custom_exceptions.dart';
import 'package:flutter_better_united/util/ui_util.dart';

import '../../data/model/public_league_join_info.dart';
import '../../data/repo/league_repository.dart';
import '../shop/user_provider.dart';

class PublicPouleProvider with ChangeNotifier {
  final UserProvider userProvider;
  final LeagueRepository leagueRepository;

  PublicPouleProvider(this.userProvider, this.leagueRepository);

  List<PublicLeagueJoinInfo>? publicPoules;

  fetchPublicPoules() async {
    // fetch public poules
    publicPoules = await leagueRepository.getPublicLeagues(joined: false);
    notifyListeners();
  }

  Future<void> joinPoule(PublicLeagueJoinInfo poule) async {
    if (userProvider.userCoins < poule.joinFee) {
      throw NotEnoughCoinsException();
    }
    beginLoading();
    try {
      await leagueRepository.joinPublicLeague(poule.id);
      userProvider.syncUserProfile();
    } catch (exception) {
      if (exception is NotEnoughCoinsException) {
        throw NotEnoughCoinsException();
      } else {
        showGenericError(exception);
      }
    } finally {
      endLoading();
    }
  }
}
