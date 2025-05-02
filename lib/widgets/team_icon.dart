import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_better_united/util/betterUnited_icons.dart';

import '../figma/colors.dart';

class TeamIcon extends StatelessWidget {
  const TeamIcon(
      {Key? key, this.logoUrl, this.height = 53, this.invertColor = false})
      : super(key: key);
  final String? logoUrl;
  final double height;
  final bool invertColor;

  @override
  Widget build(BuildContext context) {
    final placeHolder = _PlaceHolder(
        height: height,
        color: invertColor ? AppColors.buttonInnactive : AppColors.background);
    return SizedBox(
      height: height,
      width: height,
      child: logoUrl == null
          ? placeHolder
          : CachedNetworkImage(
              imageUrl: logoUrl!,
              placeholder: (context, url) => placeHolder,
              errorWidget: (context, url, error) => placeHolder,
            ),
    );
  }
}

class _PlaceHolder extends StatelessWidget {
  const _PlaceHolder({Key? key, required this.color, required this.height})
      : super(key: key);
  final Color color;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Icon(BetterUnited.logo, size: height, color: color);
  }
}
