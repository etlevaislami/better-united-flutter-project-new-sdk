import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/pages/feed/video_widget.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../constants/app_colors.dart';
import '../../data/model/video.dart';
import '../../widgets/header_widget.dart';
import 'feed_provider.dart';

class VideoArgument {
  final Video video;

  VideoArgument(this.video);
}

class VideoPage extends StatefulWidget {
  const VideoPage({Key? key}) : super(key: key);
  static const route = "/feed_video";

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late Video video;
  late CachedVideoPlayerController _videoPlayerController;
  late CustomVideoPlayerController _customVideoPlayerController;
  final CustomVideoPlayerSettings _customVideoPlayerSettings =
      const CustomVideoPlayerSettings(settingsButtonAvailable: false);
  bool isPlaying = false;
  bool isLoading = false;
  late FeedProvider _feedProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _feedProvider = FeedProvider(context.read(), context.read());
    final args = ModalRoute.of(context)?.settings.arguments as VideoArgument;
    video = args.video;
    _setupInitialVideoPlayer();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _startFullScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _feedProvider,
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              color: AppColors.primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: HeaderWidget(
                icon: SvgPicture.asset("assets/icons/ic_content.svg"),
                title: video.title,
                onTap: () => context.pop(),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
              child: Selector<FeedProvider, bool>(
                selector: (p0, p1) => p1.observeLikeChange,
                builder: (context, _, child) => Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: VideoWidget(
                      customVideoPlayerController: _customVideoPlayerController,
                      isliked: video.isLiked,
                      isLoading: isLoading,
                      isPlaying: isPlaying,
                      video: video,
                      onFullscreenTap: (video) {
                        _startFullScreen();
                      },
                      onLikeTap: (video) {
                        _feedProvider.toggleLikeVideo(video);
                      },
                      onPlayTap: (video) {
                        _playVideo();
                      },
                      onShareTap: (video) {
                        _shareLink(video);
                      },
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _startFullScreen() {
    _playVideo().then((_) => _customVideoPlayerController.setFullscreen(true));
  }

  _setupInitialVideoPlayer() {
    _videoPlayerController = CachedVideoPlayerController.network("");
    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: _videoPlayerController,
      customVideoPlayerSettings: _customVideoPlayerSettings,
    );
  }

  Future<void> _playVideo() async {
    setState(() {
      isLoading = true;
      isPlaying = true;
    });
    _videoPlayerController =
        CachedVideoPlayerController.network(video.videoUrl);
    await _videoPlayerController.initialize();
    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: _videoPlayerController,
      customVideoPlayerSettings: _customVideoPlayerSettings,
    );
    setState(() {
      isLoading = false;
      _videoPlayerController.play();
    });
  }

  _shareLink(Video video) async {
    Uri? shortLink =
        await _feedProvider.createVideoReferralLink(videoId: video.id);
    if (shortLink != null) {
      Share.share("${video.title}\n$shortLink");
    }
  }
}
