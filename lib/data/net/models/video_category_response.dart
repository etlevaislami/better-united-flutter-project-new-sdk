import 'package:flutter_better_united/data/net/converters/date_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'video_category_response.g.dart';

@JsonSerializable()
@DateTimeConverter()
class VideoCategoryResponse {
  final int id;
  final String iconUrl;
  final String name;
  final int videoCount;

  factory VideoCategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$VideoCategoryResponseFromJson(json);

  VideoCategoryResponse(this.id, this.iconUrl, this.name, this.videoCount);

  Map<String, dynamic> toJson() => _$VideoCategoryResponseToJson(this);
}
