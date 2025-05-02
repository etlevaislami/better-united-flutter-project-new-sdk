import 'package:collection/collection.dart';
import 'package:flutter_better_united/data/net/models/bookie_maker_response.dart';

import 'odds.dart';

class BookieMaker {
  final int bookmakerId;
  final String bookmakerName;
  final List<Odds> odds;
  static const String drawSymbol = "X";
  final String bookmakerLogoUrl;
  final String? bookmakerLink;

  BookieMaker(this.bookmakerId, this.bookmakerName, this.odds,
      this.bookmakerLogoUrl, this.bookmakerLink) {
    // put X odd in the middle
    final xOdd = odds.firstWhereOrNull((element) => element.name == drawSymbol);
    if (xOdd != null) {
      final middleIndex = (odds.length / 2).floor();
      odds.remove(xOdd);
      odds.insert(middleIndex, xOdd);
    }
  }

  BookieMaker.fromBookieMakerResponse(BookieMakerResponse bookieMakerResponse)
      : this(
            bookieMakerResponse.bookmakerId,
            bookieMakerResponse.bookmakerName,
            bookieMakerResponse.odds
                .map((e) => Odds.fromOddsResponse(e))
                .toList(),
            bookieMakerResponse.bookmakerlogoUrl,
            bookieMakerResponse.bookmakerLink);
}
