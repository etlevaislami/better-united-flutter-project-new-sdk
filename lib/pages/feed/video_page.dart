import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
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
  late VideoPlayerController _videoPlayerController;
  late ChewieController _customVideoPlayerController;
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
    _playVideo().then((_) => _customVideoPlayerController.enterFullScreen());
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

  Future<void> _playVideo() async {
    setState(() {
      isLoading = true;
      isPlaying = true;
    });
    _videoPlayerController =
        VideoPlayerController.network(video.videoUrl);
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

  _shareLink(Video video) async {
    Uri? shortLink =
    await _feedProvider.createVideoReferralLink(videoId: video.id);
    if (shortLink != null) {
      Share.share("${video.title}\n$shortLink");
    }
  }
}
