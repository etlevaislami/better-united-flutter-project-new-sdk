import 'package:flutter_better_united/data/net/models/match_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'teams_paginated_response.g.dart';

@JsonSerializable()
class TeamsPaginatedResponse {
  final List<TeamResponse> data;
  final int totalPages;
  final int currentPage;
  final int totalItemCount;

  factory TeamsPaginatedResponse.fromJson(Map<String, dynamic> json) =>
      _$TeamsPaginatedResponseFromJson(json);

  TeamsPaginatedResponse(
      this.data, this.totalPages, this.currentPage, this.totalItemCount);

  Map<String, dynamic> toJson() => _$TeamsPaginatedResponseToJson(this);
}
