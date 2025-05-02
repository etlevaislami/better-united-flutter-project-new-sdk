import '../../data/net/interceptors/error_interceptor.dart';

class ServiceUnavailableException implements Exception {}

class NotEnoughCoinsException implements Exception {
  static const errorCode = "NOT_ENOUGH_COINS";

  static void handleFromBadRequestException(Object exception) {
    if (exception is BadRequestException) {
      if (exception.apiErrorCode == NotEnoughCoinsException.errorCode) {
        throw NotEnoughCoinsException();
      }
    }
  }
}

class MatchAlreadyStarted implements Exception {}

class InviteAlreadyAcceptedOrDeclined implements Exception {}

class FriendLeagueMaxLimitReachedException implements Exception {}

class PouleNotFound implements Exception {}

class RefreshTokenExpiredException implements Exception {}

class TipsAreHiddenException implements Exception {}

class UnknownMarketException implements Exception {}

class MatchAlreadyInProgress implements Exception {}

class TipAlreadyPlaced implements Exception {}

class OfferIsSoldOutException implements Exception {}

class PublicLeagueMaximumTipsForMatchReached implements Exception {}

