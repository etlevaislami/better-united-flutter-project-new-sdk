import 'package:flutter/material.dart';
import 'package:flutter_better_united/constants/extended_theme.dart';

class RankWidget extends StatelessWidget {
  const RankWidget({
    Key? key,
    required this.text,
    required this.linearGradient,
  }) : super(key: key);
  final String text;
  final LinearGradient linearGradient;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _BackgroundCustomPainter(
        linearGradient,
        context.labelBoldItalic.copyWith(color: Colors.white),
        text.toString(),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Transform.translate(
          offset: const Offset(0, 0),
          child: Text(
            text,
            style: context.labelBoldItalic.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class _BackgroundCustomPainter extends CustomPainter {
  final LinearGradient gradientColor;
  final TextStyle textStyle;
  final String text;

  _BackgroundCustomPainter(this.gradientColor, this.textStyle, this.text);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    final rect =
        Rect.fromPoints(const Offset(0, 0), Offset(size.width, size.height));
    paint.shader = gradientColor.createShader(rect);

    final portion = size.height * 0.2;

    final path = Path();
    path.moveTo(portion, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width - portion, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, paint);

    final textSpan = TextSpan(
      text: text,
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(minWidth: 0, maxWidth: size.width);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
