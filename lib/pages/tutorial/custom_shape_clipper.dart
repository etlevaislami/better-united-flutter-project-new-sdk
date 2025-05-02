
// 🎨 Custom Clipper to shape the widget
import 'package:flutter/material.dart';

class CustomShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..addOval(Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        width: size.width,
        height: size.height,
      ));
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}