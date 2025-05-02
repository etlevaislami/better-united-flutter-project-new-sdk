import 'package:flutter_better_united/data/net/models/single_video_response.dart';
import 'package:flutter_better_united/data/net/models/video_response.dart';

class Video {
  final int id;
  final String title;
  final DateTime createdAt;
  final int durationSeconds;
  final String videoUrl;
  int likeCount;
  bool isLiked = false;

  Video(this.id, this.title, this.createdAt, this.durationSeconds,
      this.videoUrl, this.likeCount, this.isLiked);

  Video.fromVideoResponse(VideoResponse videoResponse)
      : this(
          videoResponse.id,
          videoResponse.title,
          videoResponse.createdAt,
          videoResponse.durationSeconds,
          videoResponse.videoUrl,
          videoResponse.likeCount,
          videoResponse.isLiked == 0 ? false : true,
        );

  Video.fromSingleVideoResponse(SingleVideoResponse videoResponse)
      : this(videoResponse.id, videoResponse.title, videoResponse.createdAt,
            videoResponse.durationSeconds, videoResponse.videoUrl, 0, false);
}
