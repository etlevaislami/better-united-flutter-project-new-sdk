import 'package:flutter_better_united/data/net/models/ranked_participant_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rankings_response.g.dart';

@JsonSerializable()
class RankingsResponse {
  final List<RankedParticipantResponse> data;
  final int totalPages;
  final int currentPage;

  factory RankingsResponse.fromJson(Map<String, dynamic> json) =>
      _$RankingsResponseFromJson(json);

  RankingsResponse(this.data, this.totalPages, this.currentPage);

  Map<String, dynamic> toJson() => _$RankingsResponseToJson(this);
}
