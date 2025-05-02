import 'package:flutter/material.dart';

class RankingAppBarBackgroundOverlayShapePath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0, 0);
    path.cubicTo(0, 0, size.width / 2, size.height * 0.44, size.width / 2, size.height * 0.44);
    path.cubicTo(size.width / 2, size.height * 0.44, size.width, 0, size.width, 0);
    path.cubicTo(size.width, 0, size.width, size.height * 0.56, size.width, size.height * 0.56);
    path.cubicTo(size.width, size.height * 0.56, size.width / 2, size.height, size.width / 2, size.height);
    path.cubicTo(size.width / 2, size.height, 0, size.height * 0.56, 0, size.height * 0.56);
    path.cubicTo(0, size.height * 0.56, 0, 0, 0, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
