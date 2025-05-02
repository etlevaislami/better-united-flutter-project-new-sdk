import 'package:flutter_better_united/data/model/video_category.dart';

import '../model/video.dart';
import '../net/api_service.dart';

class FeedRepository {
  final ApiService _apiService;

  FeedRepository(this._apiService);

  Future<List<Video>> getVideos() async {
    var videos = await _apiService.getAllVideos();
    return videos.map((e) => Video.fromVideoResponse(e)).toList();
  }

  Future<Video> getVideo(int id) async {
    var video = await _apiService.getVideo(id);
    return Video.fromSingleVideoResponse(video);
  }

  Future<List<Video>> getVideosByCategory(int categoryId) async {
    var videos = await _apiService.getVideos(categoryId);
    return videos.map((e) => Video.fromVideoResponse(e)).toList();
  }

  Future<void> likeVideo(int videoId) {
    return _apiService.likeVideo(videoId);
  }

  Future<void> unlikeVideo(int videoId) {
    return _apiService.unlikeVideo(videoId);
  }

  Future<List<VideoCategory>> getVideoCategories() async {
    var categories = await _apiService.getVideoCategory();
    return categories
        .map((e) => VideoCategory.fromVideoCategoryResponse(e))
        .toList();
  }
}
