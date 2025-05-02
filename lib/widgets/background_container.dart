import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BackgroundContainer extends StatelessWidget {
  const BackgroundContainer({
    Key? key,
    this.leadingChild,
    this.trailingChild,
    this.centerChild,
    required this.foregroundColor,
    required this.backgroundColor,
    this.withGradient = true,
    this.widthRatio = 0.8,
    this.isInclinationReversed = true,
    this.gradientEndColor,
    this.height,
    this.isCenterChildConstrained = true,
    this.padding = const EdgeInsets.symmetric(horizontal: 19),
    this.withShadow = true,
    this.borderRadius,
  }) : super(key: key);
  final Widget? leadingChild;
  final Widget? trailingChild;
  final Widget? centerChild;
  final Color foregroundColor;
  final Color backgroundColor;
  final bool withGradient;
  final double widthRatio;
  final bool isInclinationReversed;
  final Color? gradientEndColor;
  final double? height;
  final EdgeInsets? padding;
  final bool withShadow;
  final bool isCenterChildConstrained;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (p0, p1) {
      const inclinationRation = 1.0;
      return SizedBox(
        height: height,
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  boxShadow: withShadow
                      ? const [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.5),
                            // Specify shadow color
                            offset: Offset(0, 2),
                            // Specify the offset
                            blurRadius: 8,
                            // Specify the blur radius
                            spreadRadius: 0, // Specify the spread radius
                          ),
                        ]
                      : null,
                  color: const Color(0xff3C3C3C),
                  borderRadius: borderRadius ?? BorderRadius.circular(4.0),
                ),
                child: CustomPaint(
                  painter: _BackgroundPainter(
                    gradientEndColor: gradientEndColor,
                    isInclinationReversed: isInclinationReversed,
                    withGradient: withGradient,
                    inclinationRation: inclinationRation,
                    widthRatio: widthRatio,
                    foregroundColor: foregroundColor,
                    backgroundColor: backgroundColor,
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Row(
                children: [
                  Container(
                    padding: padding,
                    width: p1.maxWidth * widthRatio,
                    child: leadingChild,
                  ),
                  Expanded(
                      child: Container(
                    child: trailingChild,
                  )),
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: LayoutBuilder(builder: (context, constraints) {
                return ConstrainedBox(
                    constraints: BoxConstraints(
                        maxWidth: isCenterChildConstrained
                            ? constraints.maxWidth * widthRatio * 0.7
                            : constraints.maxWidth),
                    child: centerChild ?? Container());
              }),
            )
          ],
        ),
      );
    });
  }
}

class _BackgroundPainter extends CustomPainter {
  final double widthRatio;

  final double inclinationRation;
  final double gradientLengthRatio;
  final Color foregroundColor;
  final Color backgroundColor;
  late final Paint foregroundPaint;
  late final Paint backgroundPaint;
  final bool isInclinationReversed;

  Paint? gradientPaint;
  late final LinearGradient linearGradient;
  final Color? gradientEndColor;

  _BackgroundPainter({
    this.widthRatio = 0.9,
    this.inclinationRation = 0.6,

    /// ignore
    this.gradientLengthRatio = 0.04,
    this.foregroundColor = const Color(0xFFAAE15E),
    this.backgroundColor = const Color(0xff2B2B2B),
    bool withGradient = true,
    this.isInclinationReversed = true,
    this.gradientEndColor,
  }) {
    backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    foregroundPaint = Paint()
      ..color = foregroundColor
      ..style = PaintingStyle.fill;

    if (withGradient) {
      gradientPaint = Paint()..style = PaintingStyle.fill;
      linearGradient = LinearGradient(
        colors: [backgroundColor, gradientEndColor ?? foregroundColor],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final startingWidth = size.width * widthRatio;
    final gradientLength = size.width * gradientLengthRatio;
    final inclinationWidth = gradientLength * inclinationRation;
    final backgroundRect =
        Rect.fromPoints(const Offset(0, 0), Offset(size.width, size.height));

    canvas.drawRect(backgroundRect, backgroundPaint);

    if (gradientPaint != null) {
      final rect =
          Rect.fromPoints(const Offset(0, 0), Offset(size.width, size.height));
      gradientPaint!.shader = linearGradient.createShader(rect);

      final path = Path()
        ..moveTo(startingWidth - inclinationWidth * 2, 0)
        ..lineTo(startingWidth, 0)
        ..lineTo(
            isInclinationReversed
                ? (startingWidth + inclinationWidth)
                : (startingWidth - inclinationWidth),
            size.height) //here
        ..lineTo(startingWidth - inclinationWidth * 2, size.height)
        ..close();
      canvas.drawPath(path, gradientPaint!);
    }

    final s = isInclinationReversed
        ? startingWidth + gradientLength
        : startingWidth - gradientLength;
    final path2 = Path()
      ..moveTo(0, 0)
      ..lineTo(startingWidth - gradientLength, 0)
      ..lineTo(s - inclinationWidth, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(path2, foregroundPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
