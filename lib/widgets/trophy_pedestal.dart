import 'dart:async';
import 'dart:ui' as ui;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_better_united/constants/extended_theme.dart';
import 'package:flutter_better_united/figma/colors.dart';

import 'rank_widget.dart';

class TrophyPedestal extends StatefulWidget {
  const TrophyPedestal(
      {Key? key,
      required this.coinsForFirst,
      required this.coinsForSecond,
      required this.coinsForThird,
      required this.coinsForOthers})
      : super(key: key);

  final int coinsForFirst;
  final int coinsForSecond;
  final int coinsForThird;
  final int coinsForOthers;
  final int otherRangeStart = 4;
  final int otherRangeEnd = 11;

  @override
  State<TrophyPedestal> createState() => _TrophyPedestalState();
}

class _ImageData {
  final ui.Image trophyFirst;
  final ui.Image trophySecond;
  final ui.Image trophyThird;

  _ImageData(
      {required this.trophyFirst,
      required this.trophySecond,
      required this.trophyThird});
}

class _TrophyPedestalState extends State<TrophyPedestal> {
  Future<_ImageData> _loadAssets() async {
    final trophyFirst = await _loadImage('assets/icons/ic-trophy-gold.png');
    final trophySecond = await _loadImage('assets/icons/ic-trophy-silver.png');
    final trophyThird = await _loadImage('assets/icons/ic-trophy-bronze.png');
    return _ImageData(
      trophyFirst: trophyFirst,
      trophySecond: trophySecond,
      trophyThird: trophyThird,
    );
  }

  final AutoSizeGroup _group = AutoSizeGroup();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<_ImageData>(
        future: _loadAssets(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          }
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: 170,
                    child: CustomPaint(
                        painter: _TrophyPedestalPainter(
                          firstTrophy: snapshot.data!.trophyFirst,
                          secondTrophy: snapshot.data!.trophySecond,
                          thirdTrophy: snapshot.data!.trophyThird,
                          numberTextStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.italic,
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(0, 1.85),
                                blurRadius: 15.0,
                                color: Color(0x80000000),
                              ),
                            ],
                          ),
                        ),
                        child: Container()),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: const Alignment(0, 0.95),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: constraints.maxWidth * 0.08),
                            child: Row(
                              children: [
                                _CoinWidget(
                                  amount: widget.coinsForSecond,
                                  group: _group,
                                ),
                                _CoinWidget(
                                  amount: widget.coinsForFirst,
                                  group: _group,
                                ),
                                _CoinWidget(
                                  amount: widget.coinsForThird,
                                  group: _group,
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
              Container(
                  decoration: BoxDecoration(
                    color: const Color(0xff292929),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RankWidget(
                        text:
                            "${widget.otherRangeStart} - ${widget.otherRangeEnd}"
                                .toString(),
                        linearGradient: const LinearGradient(
                          colors: [Color(0xff353535), Color(0xff353535)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: AutoSizeText(
                                NumberFormat.decimalPattern("nl_NL")
                                    .format(widget.coinsForOthers),
                                style: context.labelRegular
                                    .copyWith(color: Colors.white),
                                textAlign: TextAlign.right,
                                minFontSize: 1,
                                maxLines: 1,
                              ),
                            ),
                            Image.asset(
                              'assets/icons/ic_coins.png',
                              height: 24,
                              width: 24,
                            ),
                          ],
                        ),
                      )
                    ],
                  ))
            ],
          );
        });
  }

  Future<ui.Image> _loadImage(
    String imageAssetPath,
  ) async {
    final ByteData data = await rootBundle.load(imageAssetPath);
    final codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      allowUpscaling: true,
    );
    var frame = await codec.getNextFrame();
    return frame.image;
  }

  Future<ui.Image> assetImageToUiImage(AssetImage assetImage) {
    final Completer<ui.Image> completer = Completer();
    final ImageStream stream = assetImage.resolve(ImageConfiguration.empty);
    final listener = ImageStreamListener((ImageInfo info, bool _) {
      if (!completer.isCompleted) {
        completer.complete(info.image);
      }
    });
    stream.addListener(listener);
    completer.future.then((_) => stream.removeListener(listener));
    return completer.future;
  }
}

class _CoinWidget extends StatelessWidget {
  const _CoinWidget({
    required this.amount,
    this.group,
  });

  final int amount;
  final AutoSizeGroup? group;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Wrap(alignment: WrapAlignment.center, children: [
      Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AutoSizeText(
                NumberFormat.decimalPattern("nl_NL").format(amount),
                group: group,
                minFontSize: 1,
                maxLines: 1,
                style: const TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.right,
              ),
              const SizedBox(
                width: 2,
              ),
              SizedBox(
                width: 12,
                height: 12,
                child: Image.asset(
                  'assets/icons/ic_coins.png',
                ),
              )
            ],
          )),
    ]));
  }
}

class _TrophyPedestalPainter extends CustomPainter {
  final TextStyle numberTextStyle;
  final ui.Image firstTrophy;
  final ui.Image secondTrophy;
  final ui.Image thirdTrophy;

  _TrophyPedestalPainter({
    required this.numberTextStyle,
    required this.firstTrophy,
    required this.secondTrophy,
    required this.thirdTrophy,
  });

  final position1Gradient = const LinearGradient(
    colors: [Color(0xffFFE068), Color(0x30FDF2C4)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  final position2Gradient = const LinearGradient(
    colors: [Color(0xffFFFFFF), Color(0x61FFFFFF)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  final position3Gradient = const LinearGradient(
    colors: [Color(0xffEC8135), Color(0x1FF08B43)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Rect.fromLTWH(0, 0, size.width, size.height));

    final outerCircleOffset = Offset(size.width / 2, size.height);
    final outerCircleRadius = size.height * 0.95;

    final innerCircleOffset = Offset(size.width / 2, size.height);
    final innerCircleRadius = size.height * 0.8;

    final outerCirclePaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0x009AE343), Color(0xffD6FFA5)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromCircle(
          center: outerCircleOffset, radius: outerCircleRadius));

    final innerCirclePaint = Paint()
      ..shader = LinearGradient(
        colors: [Colors.white.withOpacity(0), const Color(0xffD6FFA5)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromCircle(
          center: innerCircleOffset, radius: innerCircleRadius));

    canvas.drawCircle(innerCircleOffset, innerCircleRadius, innerCirclePaint);
    canvas.drawCircle(outerCircleOffset, outerCircleRadius, outerCirclePaint);

    final width = size.width;
    final widthPortion = width * 0.28;
    final padding = width * 0.08;
    canvas.translate(padding, 0);
    draw(
      canvas,
      size,
      widthPortion,
      size.height * 0.5,
      secondTrophy,
      imageSize: const Size(47, 57),
      number: 2,
      gradient: position2Gradient,
    );
    canvas.translate(widthPortion, 0);
    draw(
      canvas,
      size,
      widthPortion,
      size.height * 0.6,
      firstTrophy,
      imageSize: const Size(58, 70),
      number: 1,
      gradient: position1Gradient,
    );

    canvas.translate(widthPortion, 0);
    draw(
      canvas,
      size,
      widthPortion,
      size.height * 0.45,
      thirdTrophy,
      imageSize: const Size(47, 57),
      number: 3,
      gradient: position3Gradient,
    );
  }

  void draw(
    Canvas canvas,
    Size size,
    double widthPortion,
    double height,
    ui.Image trophyImage, {
    required Size imageSize,
    required int number,
    required LinearGradient gradient,
  }) {
    final circleHeight = size.height * 0.2;

    final rect = Rect.fromLTWH(0, size.height - height, widthPortion, height);
    final circleRect = Rect.fromCenter(
        center: Offset(widthPortion / 2, size.height - height),
        width: widthPortion,
        height: circleHeight);
    final circleRect2 = Rect.fromCenter(
        center: Offset(widthPortion / 2, size.height - height - height * 0.05),
        width: widthPortion * 0.85,
        height: circleHeight * 0.7);

    final paint = Paint()
      ..isAntiAlias = true
      ..shader = const LinearGradient(
              colors: [Color(0xff1D1D1D), Color(0xff323232)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight)
          .createShader(rect)
      ..style = PaintingStyle.fill;

    final paint2 = Paint()
      ..shader = const LinearGradient(
              colors: [Color(0xff404040), Color(0xff1D1D1D)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight)
          .createShader(circleRect)
      ..style = PaintingStyle.fill;

    final paint3 = Paint()
      ..shader = const LinearGradient(
              colors: [Color(0xff9AE343), Color(0x009AE343)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight)
          .createShader(circleRect2)
      ..style = PaintingStyle.fill;
    canvas.drawRect(rect, paint);
    canvas.drawOval(circleRect, paint2);
    canvas.drawOval(circleRect2, paint3);
    paintImage(
        canvas: canvas,
        rect: Rect.fromCenter(
            center: Offset(widthPortion / 2,
                size.height - height - imageSize.height * 0.45),
            width: imageSize.width,
            height: imageSize.height),
        image: trophyImage,
        fit: BoxFit.scaleDown,
        repeat: ImageRepeat.repeatX,
        scale: 1.0,
        alignment: Alignment.center,
        flipHorizontally: false,
        filterQuality: FilterQuality.high);
    final style = numberTextStyle;

    TextPainter test = TextPainter(
      text: TextSpan(style: style, text: number.toString()),
      textAlign: TextAlign.left,
      textDirection: ui.TextDirection.ltr,
    );
    test.layout();
    final numberPositionOffset = Offset(widthPortion / 2 - test.width / 2,
        size.height - test.height - height + circleHeight + 5);

    final Paint _gradientShaderPaint = Paint()
      ..shader = gradient.createShader(Rect.fromLTWH(numberPositionOffset.dx,
          numberPositionOffset.dy, test.width, test.height));

    final styleParagraph = ui.TextStyle(
      foreground: _gradientShaderPaint,
      fontSize: style.fontSize,
      fontFamily: style.fontFamily,
      fontWeight: style.fontWeight,
      shadows: style.shadows,
    );

    final ui.ParagraphBuilder _builder =
        ui.ParagraphBuilder(ui.ParagraphStyle())
          ..pushStyle(styleParagraph)
          ..addText(number.toString());
    final ui.Paragraph _paragraph = _builder.build();
    _paragraph.layout(ui.ParagraphConstraints(width: size.width));
    canvas.drawParagraph(_paragraph, numberPositionOffset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
