import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/util/ranking/ranking_util.dart';
import 'package:flutter_svg/svg.dart';

import '../figma/colors.dart';
import '../util/betterUnited_icons.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget(
      {Key? key,
      this.isFollowButtonVisible = false,
      this.isRankVisible = true,
      this.defaultSize = 54,
      this.profileUrl,
      required this.level,
      this.imageAsset,
      this.gradient,
      this.shadowColor = Colors.transparent,
      this.border})
      : super(key: key);

  final bool isFollowButtonVisible;
  final bool isRankVisible;
  final double defaultSize;
  final String? profileUrl;
  final int level;
  final String? imageAsset;
  final LinearGradient? gradient;
  final Color shadowColor;
  final BoxBorder? border;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final size = constraints.maxWidth == double.infinity
          ? defaultSize
          : constraints.maxWidth;

      final iconSize = size / 2.5;
      final extraPadding = size / 15;
      return Container(
        padding: EdgeInsets.all(extraPadding),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              blurRadius: 24,
              spreadRadius: 0,
              offset: const Offset(0, 0),
            )
          ],
          gradient: gradient,
          shape: BoxShape.circle,
          border: border,
        ),
        width: size,
        height: size,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  right: isFollowButtonVisible ? extraPadding : 0),
              child: imageAsset != null
                  ? Image.asset(imageAsset!)
                  :profileUrl == null
                  ? const _ProfilePlaceHolder()
                  : CachedNetworkImage(
                      imageUrl: profileUrl!,
                      imageBuilder: (context, imageProvider) =>
                          _getAvatarWidget(imageProvider, size),
                      placeholder: (context, url) =>
                const _ProfilePlaceHolder(),
                errorWidget: (context, url, error) =>
                const _ProfilePlaceHolder(),
              ),
            ),
            Visibility(
              visible: isRankVisible,
              child: RankingUtil.buildLevelIcon(level, size),
            ),
            Visibility(
              visible: isFollowButtonVisible,
              child: Positioned(
                right: 0,
                bottom: 0,
                child: SvgPicture.asset(
                  "assets/images/ic_add.svg",
                  height: iconSize,
                ),
              ),
            )
          ],
        ),
      );
    });
  }

  _getAvatarWidget(ImageProvider imageProvider, double size) {
    return CircleAvatar(
      backgroundColor: AppColors.background,
      foregroundColor: Colors.transparent,
      foregroundImage: imageProvider,
      radius: size,
    );
  }
}

class _ProfilePlaceHolder extends StatelessWidget {
  const _ProfilePlaceHolder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.secondary,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Icon(
            BetterUnited.logo,
            color: AppColors.primary,
            size: constraints.maxHeight / 2,
          );
        },
      ),
    );
  }
}
