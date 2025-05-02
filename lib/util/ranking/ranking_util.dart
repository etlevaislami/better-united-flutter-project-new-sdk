import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class RankingUtil {
  static LinearGradient getRankGradient(int? rank, bool isConnectedUser) {
    switch (rank) {
      case 1:
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xffFFF6C6),
            Color(0xffFFD703),
            Color(0xffFFAE01),
          ],
        );
      case 2:
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xffD7D7D7), Color(0xffBBBBBB), Color(0xff979797)],
        );
      case 3:
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xffF98B39), Color(0xffE57D32), Color(0xffBB5821)],
        );
      default:
        if (isConnectedUser) {
          return const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xffFFFFFF),
              Color(0xffD1D1D1),
            ],
          );
        } else {
          return const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff838383),
              Color(0xff4C4C4C),
            ],
          );
        }

    }
  }

  static Color getShadowColor(int? rank) {
    switch (rank) {
      case 1:
        return const Color(0x80FFF396);
      case 2:
        return const Color(0x80C1C1C1);
      case 3:
        return const Color(0xffFD8E3A);
      default:
        return Colors.transparent;
    }
  }

  static Widget buildLevelIcon(int level, double size) {
    if (level < 5) {
      // 0 stars
      return const SizedBox();
    }
    if (level < 10) {
      // 1 star
      return Positioned(
        left: size / 15,
        top: size / 1.5,
        child: SvgPicture.asset(
          "assets/icons/star_1.svg",
          height: size * 0.30,
        ),
      );
    }

    if (level < 15) {
      // 2 stars
      return Positioned(
        left: -size / 18,
        bottom: -size / 18,
        child: SvgPicture.asset(
          "assets/icons/star_2.svg",
          height: size * 0.5,
        ),
      );
    }

    if (level < 20) {
      // 3 stars
      return Positioned(
        left: -size / 8,
        bottom: -size / 6,
        child: SvgPicture.asset(
          "assets/icons/star_3.svg",
          height: size * 0.8,
        ),
      );
    }

    if (level < 25) {
      // 4 stars
      return Positioned(
        left: -size / 5,
        bottom: -size / 5,
        child: SvgPicture.asset(
          "assets/icons/star_4.svg",
          height: size * 0.9,
        ),
      );
    }
    // diamond
    return Positioned(
      left: -size / 8,
      bottom: -size / 18,
      child: SvgPicture.asset(
        "assets/images/ic_diamond.svg",
        height: size * 0.45,
      ),
    );
  }

  static LinearGradient getBadgeGradient(int? rank, bool isConnectedUser) {
    switch (rank) {
      case 1:
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xffFFE93B), Color(0xffFFCF1B)],
        );
      case 2:
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xffD6D6D6),
            Color(0xffB9B9B9),
          ],
        );
      case 3:
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xffFF903B),
            Color(0xffC65F24),
          ],
        );
      default:
        return LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(isConnectedUser ? 0xff9AE343 : 0xff353535),
            Color(isConnectedUser ? 0xff9AE343 : 0xff353535),
          ],
        );
    }
  }

  // static GradientBoxBorder getGradientBorderForRank(
  //     int rank, bool isConnectedUser) {
  //
  //   List<Color> colors;
  //
  //
  //    switch (rank) {
  //     case 1:
  //       colors = [
  //         Color(0xff585858),
  //         Color(0xff353535),
  //       ];
  //       break;
  //     case 2:
  //       colors = [
  //         Color(0xff585858),
  //         Color(0xff353535),
  //       ];
  //       break;
  //     case 3:
  //       colors = [
  //         Color(0xff585858),
  //         Color(0xff353535),
  //       ];
  //       break;
  //     default:
  //       colors = [
  //         Color(0xff585858),
  //         Color(0xff353535),
  //       ];
  //       break;
  //   }
  //
  //   return GradientBoxBorder(
  //     gradient: LinearGradient(
  //         begin: Alignment.topCenter,
  //         end: Alignment.bottomCenter,
  //         colors: colors),
  //     width: 4,
  //   );
  // }
}
