import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/data/model/video_category.dart';
import 'package:flutter_better_united/data/repo/feed_repository.dart';
import 'package:flutter_better_united/util/deeplinks/deep_link_manager.dart';
import 'package:flutter_better_united/util/ui_util.dart';

import '../../data/model/video.dart';

class FeedProvider with ChangeNotifier {
  final FeedRepository _feedRepository;
  final DeepLinkManager _deepLinkManager;
  List<Video> videos = [];
  List<VideoCategory> categories = [];
  int? selectedCategoryId;
  bool observeLikeChange = false;

  FeedProvider(this._feedRepository, this._deepLinkManager);

  Future<Video?> getVideo(int videoId) async {
    beginLoading();
    try {
      Video video = await _feedRepository.getVideo(videoId);
      return video;
    } catch (e) {
      showToast("videoNotFound".tr());
    } finally {
      endLoading();
    }
    return null;
  }

  Future<void> getAllVideos() async {
    selectedCategoryId = null;
    beginLoading();
    try {
      videos = await _feedRepository.getVideos();
      notifyListeners();
    } catch (exception) {
      showGenericError(exception);
    } finally {
      endLoading();
    }
  }

  getVideosByCategory(int categoryId) async {
    selectedCategoryId = categoryId;
    beginLoading();
    try {
      videos = await _feedRepository.getVideosByCategory(categoryId);
      notifyListeners();
    } catch (exception) {
      showGenericError(exception);
    } finally {
      endLoading();
    }
  }

  getCategories() async {
    beginLoading();
    try {
      categories = await _feedRepository.getVideoCategories();
      notifyListeners();
    } catch (exception) {
      showGenericError(exception);
    } finally {
      endLoading();
    }
  }

  toggleLikeVideo(Video video) {
    if (video.isLiked) {
      _feedRepository.unlikeVideo(video.id);
      video.isLiked = false;
      video.likeCount -= 1;
    } else {
      video.isLiked = true;
      video.likeCount += 1;
      _feedRepository.likeVideo(video.id);
    }
    observeLikeChange = !observeLikeChange;
    notifyListeners();
  }

  setSelectedCategory(int categoryId) {
    selectedCategoryId = categoryId;
    getVideosByCategory(categoryId);
    notifyListeners();
  }

  loadAllVideos() {
    selectedCategoryId = null;
    notifyListeners();
    getAllVideos();
  }

  Future<Uri?> createVideoReferralLink({required int videoId}) async {
    beginLoading();
    try {
      final link = await _deepLinkManager
          .createLink(LinkType.video, {"videoId": videoId.toString()});
      return link.shortUrl;
    } catch (exception) {
      showGenericError(exception);
    } finally {
      endLoading();
    }
    return null;
  }
}
