class PurchasableCoins {
  final double amount;
  final int coins;
  final String id;
  final String currencySymbol;

  const PurchasableCoins({
    required this.id,
    required this.amount,
    required this.coins,
    required this.currencySymbol,
  });
}
