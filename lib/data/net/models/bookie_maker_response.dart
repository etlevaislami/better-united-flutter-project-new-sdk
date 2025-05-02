import 'package:json_annotation/json_annotation.dart';

import 'odds_response.dart';

part 'bookie_maker_response.g.dart';

@JsonSerializable()
class BookieMakerResponse {
  final int bookmakerId;
  final String bookmakerName;
  final List<OddsResponse> odds;
  final String bookmakerlogoUrl;
  final String? bookmakerLink;

  BookieMakerResponse(this.bookmakerId, this.bookmakerName, this.odds,
      this.bookmakerlogoUrl, this.bookmakerLink);

  factory BookieMakerResponse.fromJson(Map<String, dynamic> json) =>
      _$BookieMakerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BookieMakerResponseToJson(this);
}
