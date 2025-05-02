import 'package:flutter_better_united/data/net/models/market_response.dart';

import 'odds.dart';

class Market {
  final String name;
  final List<Odds> odds;

  Market(this.name, this.odds);

  Market.fromMarketResponse(MarketResponse marketResponse)
      : this("",
            marketResponse.odds.map((e) => Odds.fromOddsResponse(e)).toList());
}
