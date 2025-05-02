import 'package:flutter_better_united/data/net/converters/date_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'single_video_response.g.dart';

@JsonSerializable()
@DateTimeConverter()
class SingleVideoResponse {
  final int id;
  final int videoCategoryId;
  final String title;
  final DateTime createdAt;
  final int durationSeconds;
  final String videoUrl;

  factory SingleVideoResponse.fromJson(Map<String, dynamic> json) =>
      _$SingleVideoResponseFromJson(json);

  SingleVideoResponse(this.id, this.videoCategoryId, this.title, this.createdAt,
      this.durationSeconds, this.videoUrl);

  Map<String, dynamic> toJson() => _$SingleVideoResponseToJson(this);
}
