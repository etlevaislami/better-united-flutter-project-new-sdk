import 'package:flutter_better_united/data/net/models/bookie_maker_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bookie_list_response.g.dart';

@JsonSerializable()
class BookieListResponse {
  final List<BookieMakerResponse> clickableBets;
  final List<BookieMakerResponse> additionalBets;

  factory BookieListResponse.fromJson(Map<String, dynamic> json) =>
      _$BookieListResponseFromJson(json);

  BookieListResponse(this.clickableBets, this.additionalBets);

  Map<String, dynamic> toJson() => _$BookieListResponseToJson(this);
}
