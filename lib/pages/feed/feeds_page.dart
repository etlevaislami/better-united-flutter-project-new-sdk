import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/data/model/video_category.dart';
import 'package:flutter_better_united/pages/feed/feed_provider.dart';
import 'package:flutter_better_united/pages/feed/video_page.dart';
import 'package:flutter_better_united/pages/feed/video_widget.dart';
import 'package:flutter_better_united/widgets/feed_category.dart';
import 'package:flutter_better_united/widgets/regular_app_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:tuple/tuple.dart';

import '../../constants/app_colors.dart';
import '../../data/model/video.dart';

class FeedsArguments {
  final int videoId;

  FeedsArguments(this.videoId);
}

class FeedsPage extends StatefulWidget {
  const FeedsPage({
    Key? key,
  }) : super(key: key);
  static const route = "/feed";

  @override
  _FeedsPageState createState() => _FeedsPageState();
}

class _FeedsPageState extends State<FeedsPage> {
  final _scrollController = AutoScrollController();
  final double appBarHeight = 180;
  final double videoItemHeight = 280;
  static const int undefinedIndex = -1;
  late FeedProvider _feedProvider;
  late String title;
  late VideoPlayerController _videoPlayerController;
  late ChewieController _customVideoPlayerController;
  int playingVideoIndex = undefinedIndex;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _feedProvider = FeedProvider(context.read(), context.read());
    _feedProvider.getAllVideos().then(
          (value) => WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _handleDeeplink();
      }),
    );
    _feedProvider.getCategories();
    _setupInitialVideoPlayer();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _scrollController.dispose();
    _customVideoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _feedProvider,
      child: Scaffold(
        appBar: RegularAppBar.withBackButton(
          title: "videos".tr(),
          onBackTap: () {
            context.pop();
          },
        ),
        resizeToAvoidBottomInset: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  _buildSliverAppBar(context),
                  _buildSliverBody(),
                  SliverFillRemaining(
                    child: Container(
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSliverBody() {
    return SliverStack(
      insetOnOverlap: true,
      children: [
        SliverPositioned.fill(
          child: Container(
            color: const Color(0xff272727),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(24),
          sliver: Selector<FeedProvider, Tuple2<List<Video>, bool>>(
            selector: (p0, p1) => Tuple2(p1.videos, p1.observeLikeChange),
            builder: (context, data, child) => SliverPadding(
              padding: const EdgeInsets.only(bottom: 80),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    final Video video = data.item1[index];
                    return AutoScrollTag(
                      key: ValueKey(index),
                      controller: _scrollController,
                      index: index,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: VideoWidget(
                          customVideoPlayerController:
                          _customVideoPlayerController,
                          isliked: video.isLiked,
                          isLoading: isLoading,
                          isPlaying: playingVideoIndex == index,
                          video: video,
                          onFullscreenTap: (video) {
                            _startFullScreenVideo(index, video);
                          },
                          onLikeTap: (video) {
                            _feedProvider.toggleLikeVideo(video);
                          },
                          onPlayTap: (video) {
                            _startVideo(video.videoUrl, index);
                          },
                          onShareTap: (video) {
                            _shareLink(video);
                          },
                        ),
                      ),
                    );
                  },
                  childCount: data.item1.length,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _buildRecentWidget(BuildContext context, bool isActive) {
    return GestureDetector(
      onTap: () {
        _stopVideo();
        _feedProvider.loadAllVideos();
      },
      child: FeedCategory(
        text: "mostRecent".tr(),
        isActive: isActive,
        child: Transform.scale(
          scale: 1.3,
          child: Image.asset(
            "assets/icons/ic_content.png",
          ),
        ),
      ),
    );
  }

  _buildFeedCategory(BuildContext context, VideoCategory videoCategory,
      int? selectedFeedCategory) {
    return GestureDetector(
      onTap: () {
        _stopVideo();
        _feedProvider.setSelectedCategory(videoCategory.id);
      },
      child: FeedCategory(
        text: videoCategory.name,
        isActive: selectedFeedCategory == videoCategory.id,
        child: CachedNetworkImage(
          imageUrl: videoCategory.iconUrl,
          errorWidget: (context, url, error) => _buildFeedCategoryPlaceHolder(),
        ),
      ),
    );
  }

  Widget _buildFeedCategoryPlaceHolder() {
    return SvgPicture.asset(
      "assets/icons/ic_content.svg",
      height: 50,
      color: AppColors.grey,
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    return Selector<FeedProvider, Tuple2<List<VideoCategory>, int?>>(
      selector: (p0, p1) => Tuple2(p1.categories, p1.selectedCategoryId),
      builder: (context, data, child) {
        final List<VideoCategory> categories = data.item1;
        final selectedCategoryId = data.item2;
        return SliverAppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          expandedHeight: appBarHeight,
          collapsedHeight: appBarHeight,
          flexibleSpace: Container(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              itemBuilder: (_, index) {
                return GestureDetector(
                  child: index == 0
                      ? _buildRecentWidget(context, selectedCategoryId == null)
                      : _buildFeedCategory(
                      context, categories[index - 1], selectedCategoryId),
                );
              },
              scrollDirection: Axis.horizontal,
              itemCount: categories.isEmpty ? 1 : categories.length + 1,
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  width: 24,
                );
              },
            ),
          ),
        );
      },
    );
  }

  _setupInitialVideoPlayer() {
    _videoPlayerController = VideoPlayerController.network("");
    _customVideoPlayerController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: false,
      looping: false,
      showControls: true,
    );
  }

  Future<void> _startVideo(String url, int videoIndex) async {
    setState(() {
      isLoading = true;
      playingVideoIndex = videoIndex;
    });
    _videoPlayerController = VideoPlayerController.network(url);
    await _videoPlayerController.initialize();
    _customVideoPlayerController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: false,
      showControls: true,
      allowFullScreen: true,
    );
    setState(() {
      isLoading = false;
    });
  }

  _stopVideo() {
    _videoPlayerController.pause();
    setState(() {
      isLoading = false;
      playingVideoIndex = undefinedIndex;
    });
  }

  _handleDeeplink() async {
    final args = ModalRoute.of(context)!.settings.arguments as FeedsArguments?;
    if (args != null) {
      final index = _feedProvider.videos
          .indexWhere((element) => element.id == args.videoId);
      if (index != -1) {
        _jumpToVideo(index);
      } else {
        _navigateToVideoPage(args.videoId);
      }
    }
  }

  _jumpToVideo(int index) async {
    await _scrollController.scrollToIndex(index,
        preferPosition: AutoScrollPosition.middle);

    _startFullScreenVideo(index, _feedProvider.videos[index]);
  }

  _navigateToVideoPage(int videoId) {
    _feedProvider.getVideo(videoId).then((video) {
      if (video != null) {
        Navigator.of(context, rootNavigator: true).pushNamed(
          VideoPage.route,
          arguments: VideoArgument(video),
        );
      }
    });
  }

  _startFullScreenVideo(int index, Video video) {
    _startVideo(video.videoUrl, index).then(
          (_) => _customVideoPlayerController.enterFullScreen(),
    );
  }

  _shareLink(Video video) async {
    Uri? shortLink =
    await _feedProvider.createVideoReferralLink(videoId: video.id);
    if (shortLink != null) {
      Share.share("${video.title}\n$shortLink");
    }
  }
}