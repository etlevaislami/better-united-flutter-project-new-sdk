import 'package:flutter_better_united/data/net/models/video_category_response.dart';

class VideoCategory {
  final int id;
  final String iconUrl;
  final String name;
  final int videoCount;

  VideoCategory(this.id, this.iconUrl, this.name, this.videoCount);

  VideoCategory.fromVideoCategoryResponse(
      VideoCategoryResponse videoCategoryResponse)
      : this(videoCategoryResponse.id, videoCategoryResponse.iconUrl,
            videoCategoryResponse.name, videoCategoryResponse.videoCount);
}
