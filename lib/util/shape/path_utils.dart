import 'package:flutter/material.dart';
import 'package:flutter_better_united/util/shape/size_utils.dart';

class PathUtils {
  static Path getLeftHomeButtonShapePath(Size originalSize,
      {Offset offset = const Offset(0, 0),
      EdgeInsets padding = EdgeInsets.zero}) {
    final finalOffset = offset.translate(-padding.left, -padding.top);
    final size = originalSize.addPadding(padding);

    const cornerRadius = 8.0;

    final path = Path()
      ..moveTo(0 + cornerRadius, 0)
      ..lineTo(size.width - (cornerRadius / 2), 0 + size.height * 0.2)
      ..arcToPoint(
        Offset(size.width, 0 + size.height * 0.2 + cornerRadius),
        radius: const Radius.circular(cornerRadius),
        clockwise: true,
      )
      ..lineTo(size.width, size.height - (cornerRadius))
      ..arcToPoint(
        Offset(size.width - cornerRadius, size.height),
        radius: const Radius.circular(cornerRadius),
        clockwise: true,
      )
      ..lineTo(0 + cornerRadius, size.height)
      ..arcToPoint(
        Offset(0, size.height - cornerRadius),
        radius: const Radius.circular(cornerRadius),
        clockwise: true,
      )
      ..lineTo(0, 0 + cornerRadius)
      ..arcToPoint(
        const Offset(0 + cornerRadius, 0),
        radius: const Radius.circular(cornerRadius),
        clockwise: true,
      );

    return path.shift(finalOffset)..close();
  }

  static Path getRightHomeButtonShapePath(Size originalSize,
      {Offset offset = const Offset(0, 0),
      EdgeInsets padding = EdgeInsets.zero}) {
    final finalOffset = offset.translate(-padding.left, -padding.top);
    final size = originalSize.addPadding(padding);
    const cornerRadius = 8.0;

    final path = Path()
      ..moveTo(0 + cornerRadius, 0 + size.height * 0.2)
      ..lineTo(size.width - (cornerRadius / 2), 0)
      ..arcToPoint(
        Offset(size.width, 0 + cornerRadius),
        radius: const Radius.circular(cornerRadius),
        clockwise: true,
      )
      ..lineTo(size.width, size.height - (cornerRadius))
      ..arcToPoint(
        Offset(size.width - cornerRadius, size.height),
        radius: const Radius.circular(cornerRadius),
        clockwise: true,
      )
      ..lineTo(0 + cornerRadius, size.height)
      ..arcToPoint(
        Offset(0, size.height - cornerRadius),
        radius: const Radius.circular(cornerRadius),
        clockwise: true,
      )
      ..lineTo(0, size.height * 0.2 + cornerRadius)
      ..arcToPoint(
        Offset(0 + cornerRadius, size.height * 0.2),
        radius: const Radius.circular(cornerRadius),
        clockwise: true,
      );

    return path.shift(finalOffset)..close();
  }

  static Path getRoundedRectShapePath(Offset offset, Size size,
      {EdgeInsets padding = EdgeInsets.zero}) {
    final finalOffset = offset.translate(-padding.left, -padding.top);
    final finalSize = size.addPadding(padding);

    const cornerRadius = 5.0;
    return Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(finalOffset.dx, finalOffset.dy, finalSize.width,
              finalSize.height),
          const Radius.circular(cornerRadius), // Adjust corner radius
        ),
      )
      ..close();
  }
}
