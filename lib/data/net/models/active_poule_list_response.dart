import 'package:flutter_better_united/data/net/models/public_league_active_list_item.dart';
import 'package:json_annotation/json_annotation.dart';

import 'friend_league_active_list_item.dart';

part 'active_poule_list_response.g.dart';

@JsonSerializable()
class ActivePouleListResponse {
  final List<PublicLeagueActivePouleItem> publicLeagues;
  final List<FriendLeagueActivePouleItem> friendLeagues;

  ActivePouleListResponse(this.publicLeagues, this.friendLeagues);

  factory ActivePouleListResponse.fromJson(Map<String, dynamic> json) =>
      _$ActivePouleListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ActivePouleListResponseToJson(this);
}
