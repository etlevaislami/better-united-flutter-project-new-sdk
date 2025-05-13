import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/figma/colors.dart';
import 'package:flutter_better_united/util/betterUnited_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../data/model/video.dart';
import '../../util/date_util.dart';

class VideoWidget extends StatelessWidget {
  const VideoWidget(
      {Key? key,
        required this.isPlaying,
        required this.isLoading,
        required this.customVideoPlayerController,
        required this.video,
        required this.isliked,
        required this.onLikeTap,
        required this.onPlayTap,
        required this.onFullscreenTap,
        required this.onShareTap})
      : super(key: key);

  final bool isPlaying;
  final bool isLoading;
  final Video video;
  final bool isliked;
  final Function(Video video) onLikeTap;
  final Function(Video video) onPlayTap;
  final Function(Video video) onFullscreenTap;
  final Function(Video video) onShareTap;

  final ChewieController customVideoPlayerController;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(
        Radius.circular(4),
      ),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: AppColors.secondary,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (isPlaying && isLoading)
                ? Container(
              alignment: Alignment.center,
              color: Colors.black,
              height: 180,
              child: const SpinKitThreeBounce(
                color: Colors.white,
                size: 25.0,
              ),
            )
                : SizedBox(
              width: double.infinity,
              height: 180,
              child: isPlaying
                  ? Chewie(
                controller: customVideoPlayerController,
              )
                  : _buildPlaceHolderVideo(context),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    video.title,
                    style: context.labelMedium,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    "sharedOn".tr(args: [
                      fullNotationDateWithHours.format(video.createdAt)
                    ]),
                    style: context.bodySmall
                        ?.copyWith(color: const Color(0xff989898)),
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => onLikeTap.call(video),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 7.0),
                          child: Icon(
                            video.isLiked
                                ? BetterUnited.heartFilled
                                : BetterUnited.heart,
                            color: video.isLiked
                                ? AppColors.primary
                                : Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "likesArgs".plural(video.likeCount),
                          style: context.labelMedium?.copyWith(fontSize: 12),
                        ),
                      ),
                      GestureDetector(
                          onTap: () async {
                            onShareTap.call(video);
                          },
                          child: const Icon(
                            BetterUnited.share,
                            size: 18,
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildPlaceHolderVideo(BuildContext context) {
    return Container(
      color: Colors.black,
      height: 180,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 6.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Spacer(),
                  GestureDetector(
                    onTap: () => onFullscreenTap.call(video),
                    child: const Padding(
                        padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                        child: Icon(
                          BetterUnited.fullscreen,
                          size: 18,
                        )),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () => onPlayTap(video),
              child: const Icon(BetterUnited.play, size: 68),
            ),
          )
        ],
      ),
    );
  }
}
