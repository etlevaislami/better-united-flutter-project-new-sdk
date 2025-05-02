import 'package:flutter_better_united/data/net/converters/date_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'video_response.g.dart';

@JsonSerializable()
@DateTimeConverter()
class VideoResponse {
  final int id;
  final int videoCategoryId;
  final String videoCategoryName;
  final String title;
  final DateTime createdAt;
  final int durationSeconds;
  final String videoUrl;
  final int likeCount;
  final int isLiked;
  final String? thumbnailUrl;

  factory VideoResponse.fromJson(Map<String, dynamic> json) =>
      _$VideoResponseFromJson(json);

  VideoResponse(
      this.id,
      this.videoCategoryId,
      this.videoCategoryName,
      this.title,
      this.createdAt,
      this.durationSeconds,
      this.videoUrl,
      this.likeCount,
      this.isLiked,
      this.thumbnailUrl);

  Map<String, dynamic> toJson() => _$VideoResponseToJson(this);
}
