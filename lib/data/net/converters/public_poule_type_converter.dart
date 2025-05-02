import '../../enum/public_poule_type.dart';

class PublicPouleTypeConverter {
  static PublicPouleType fromJson(String role) {
    switch (role) {
      case 'LEAGUE_BASED':
        return PublicPouleType.league;
      case 'MATCH_BASED':
        return PublicPouleType.match;
      default:
        return PublicPouleType.league;
    }
  }

  static String toJson(PublicPouleType role) {
    return role.toString().split('.').last;
  }
}
