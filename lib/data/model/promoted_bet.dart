import '../net/models/promoted_bet_response.dart';

class PromotedBet {
  final String bookmakerUrl;
  final String? tipImageEN;
  final String? tipImageNL;

  PromotedBet(
      {required this.bookmakerUrl,
      required this.tipImageEN,
      required this.tipImageNL});

  PromotedBet.fromPromotedBetResponse(PromotedBetResponse response)
      : bookmakerUrl = response.bookmakerUrl,
        tipImageEN = response.tipImageEN,
        tipImageNL = response.tipImageNL;
}
