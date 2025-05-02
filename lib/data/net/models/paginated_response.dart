import 'package:flutter_better_united/data/net/models/tip_detail_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'paginated_response.g.dart';

@JsonSerializable()
class PaginatedResponse {
  final List<TipDetailResponse> data;
  final int totalPages;
  final int currentPage;
  final int totalItemCount;

  factory PaginatedResponse.fromJson(Map<String, dynamic> json) =>
      _$PaginatedResponseFromJson(json);

  PaginatedResponse(
      this.data, this.totalPages, this.currentPage, this.totalItemCount);

  Map<String, dynamic> toJson() => _$PaginatedResponseToJson(this);
}
