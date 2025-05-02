import 'package:json_annotation/json_annotation.dart';

import '../enum/poule_type.dart';

part 'league_invitation.g.dart';

@JsonSerializable()
class LeagueInvitation {
  final int leagueId;
  final String leagueName;
  final String nickname;
  final PouleType type;
  final int poolPrize;
  final int entryFee;

  factory LeagueInvitation.fromJson(Map<String, dynamic> json) =>
      _$LeagueInvitationFromJson(json);

  LeagueInvitation({
    required this.nickname,
    required this.leagueId,
    required this.leagueName,
    required this.type,
    required this.poolPrize,
    required this.entryFee,
  });

  Map<String, dynamic> toJson() => _$LeagueInvitationToJson(this);
}
