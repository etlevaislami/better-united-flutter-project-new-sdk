import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';

import '../figma/colors.dart';

class LeagueIconWithPlaceholder extends StatelessWidget {
  const LeagueIconWithPlaceholder(
      {Key? key, this.logoUrl, this.withGlow = false})
      : super(key: key);
  final String? logoUrl;
  final bool withGlow;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: withGlow
            ? [
                //fix shadow
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.24),
                  blurRadius: 40,
                  spreadRadius: 0,
                  offset: const Offset(0, 0),
                ),
              ]
            : null,
      ),
      child: logoUrl == null
          ? const _PlaceHolder()
          : CachedNetworkImage(
              imageUrl: logoUrl!,
              placeholder: (context, url) => const _PlaceHolder(),
              errorWidget: (context, url, error) => const _PlaceHolder(),
            ),
    );
  }
}

class _PlaceHolder extends StatelessWidget {
  const _PlaceHolder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/icons/ic_public_league_badge.png",
    );
  }
}
