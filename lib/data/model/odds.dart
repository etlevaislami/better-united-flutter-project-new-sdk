import 'package:flutter_better_united/data/net/models/odds_response.dart';

class Odds {
  final int id;
  final String name;
  final int points;
  final String? line;
  final String? baseLine;
  final String hint;

  Odds(this.id, this.name, this.points, this.line, this.baseLine, this.hint);

  Odds.fromOddsResponse(OddsResponse oddsResponse)
      : this(
            oddsResponse.id,
            oddsResponse.name,
            oddsResponse.points ?? 0,
            oddsResponse.line,
            oddsResponse.baseLine,
            oddsResponse.hints?.join("\n") ?? "");
}
