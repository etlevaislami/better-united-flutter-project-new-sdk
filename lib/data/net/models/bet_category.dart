import '../../model/market.dart';

class BetCategory {
  final int id;
  final String name;
  List<Market> markets;

  BetCategory(this.id, this.name, this.markets);
}
