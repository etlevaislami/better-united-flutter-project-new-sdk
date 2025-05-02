import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_better_united/data/net/models/included_league_response.dart';
import 'package:flutter_better_united/data/net/models/league_detail_football_league_response.dart';
import 'package:flutter_better_united/data/net/models/league_response.dart';

import '../net/models/football_league_response.dart';

class League {
  final int id;
  final String name;
  final String? logoUrl;
  final int matchCount;
  final int tipCount;
  final String countryName;
  bool isActive = false;

  League(this.id, this.name, this.logoUrl, this.matchCount, this.tipCount,
      this.countryName);

  League.fromLeagueResponse(LeagueResponse leagueResponse)
      : this(
            leagueResponse.id,
            leagueResponse.name ?? "defaultLeagueName".tr(),
            leagueResponse.logoUrl,
            leagueResponse.matchCount,
            leagueResponse.tipCount,
            leagueResponse.countryName);

  League.fromIncludedLeagueResponse(IncludedLeagueResponse leagueResponse)
      : this(
            leagueResponse.leagueId,
            leagueResponse.leagueName ?? "defaultLeagueName".tr(),
            leagueResponse.leagueLogoUrl,
            0,
            0,
            "");

  League.fromFootballLeagueResponse(FootballLeagueResponse leagueResponse)
      : this(leagueResponse.id, leagueResponse.leagueName,
            leagueResponse.leagueLogoUrl, 0, 0, "undefined".tr());

  League.fromLeagueDetailFootballLeagueResponse(
      LeagueDetailFootballLeagueResponse leagueResponse)
      : this(leagueResponse.leagueId, leagueResponse.leagueName,
            leagueResponse.leagueLogoUrl, 0, 0, "undefined".tr());
}
