

// 🎨 Custom Painter to draw the blurred overlay with a cut-out shape defined by [holePath].
import 'dart:ui';

import 'package:flutter/material.dart';

class BlurHolePainter extends CustomPainter {
  final Path holePath;

  BlurHolePainter(this.holePath);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black.withOpacity(0.75);
    final fullPath = Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    fullPath.addPath(holePath, Offset.zero);
    fullPath.fillType = PathFillType.evenOdd;

    canvas.drawPath(fullPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
