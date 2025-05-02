import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';
import 'package:image/image.dart' as img;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/constants/extended_theme.dart';
import 'package:flutter_better_united/data/model/promoted_bet.dart';
import 'package:flutter_better_united/figma/shadows.dart';
import 'package:flutter_better_united/run.dart';
import 'package:flutter_better_united/widgets/primary_button.dart';
import 'package:flutter_better_united/widgets/secondary_button.dart';
import 'package:lottie/lottie.dart';
import 'package:screenshot/screenshot.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import '../../../figma/colors.dart';
import '../../../util/locale_util.dart';

class RevealPredictionDialog extends StatefulWidget {
  const RevealPredictionDialog(
      {super.key, required this.bookieImage, required this.promotedBet});

  final MemoryImage bookieImage;
  final PromotedBet promotedBet;

  static Future<dynamic> show(BuildContext context,
      {required MemoryImage bookieImage, required PromotedBet promotedBet}) {
    return showDialog(
      useSafeArea: false,
      barrierDismissible: false,
      context: context,
      useRootNavigator: false,
      builder: (context) => RevealPredictionDialog(
        bookieImage: bookieImage,
        promotedBet: promotedBet,
      ),
    );
  }

  @override
  State<RevealPredictionDialog> createState() => _RevealPredictionDialogState();
}

class _RevealPredictionDialogState extends State<RevealPredictionDialog>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final AnimationController _fadeAwayAnimationController;
  late final AnimationController _fadeInAnimationController;
  late final Animation<double> _fadeAwayAnimation;
  late final Animation<double> _fadeInAnimation;
  final Completer _targetRevealed = Completer();
  bool _isTappedOnce = false;

  @override
  void initState() {
    super.initState();
    _fadeAwayAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _fadeInAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 5000));
    _fadeAwayAnimation =
        Tween(begin: 1.0, end: 0.0).animate(_fadeAwayAnimationController);
    _fadeInAnimation =
        Tween(begin: 0.0, end: 1.0).animate(_fadeInAnimationController);
    _handleMainAnimation();
    _controller.addListener(() {
      if (_controller.value > 0.6 && !_targetRevealed.isCompleted) {
        _targetRevealed.complete();
        _fadeInAnimationController.forward();
      }
    });
  }

  _handleMainAnimation() async {
    final ticker = _controller.repeat(
        reverse: true,
        max: 0.09,
        min: 0.02,
        period: const Duration(milliseconds: 800));
    ticker.whenCompleteOrCancel(() {
      _controller.animateTo(1,
          duration: const Duration(milliseconds: 5000), curve: Curves.linear);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _fadeAwayAnimationController.dispose();
    _fadeInAnimationController.dispose();
    super.dispose();
  }

  _onTapAnywhere() {
    if (_isTappedOnce) return;
    _isTappedOnce = true;
    _controller.stop(canceled: true);
    _fadeAwayAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTapAnywhere,
      child: Stack(
        children: [
          Positioned.fill(
              child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(),
          )),
          Positioned.fill(
            child: Container(
              color: AppColors.primary.withOpacity(0.2),
            ),
          ),
          Positioned.fill(
              child: Lottie.asset(
                  "assets/animations/background-shine-stars.json")),
          Positioned.fill(
              child: AbsorbPointer(
            child: Lottie.asset(
              onLoaded: (p0) {},
              controller: _controller,
              imageProviderFactory: (p0) {
                if (p0.id == "image_0") {
                  return const AssetImage("assets/animations/img_0.png");
                } else if (p0.id == "image_1") {
                  return widget.bookieImage;
                } else if (p0.id == "image_2") {
                  return const AssetImage("assets/animations/img_2.png");
                } else if (p0.id == "image_3") {
                  return const AssetImage("assets/animations/img_3.png");
                }
                throw Exception("unknown image id");
              },
              'assets/animations/reveal-full.json',
            ),
          )),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    FadeTransition(
                      opacity: _fadeAwayAnimation,
                      child: Text(
                        "tapAnywhere".tr().toUpperCase(),
                        textAlign: TextAlign.center,
                        style: context.titleH2
                            .copyWith(shadows: AppShadows.textShadows),
                      ),
                    ),
                    FadeTransition(
                      opacity: _fadeInAnimation,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          PrimaryButton(
                            text: "playPrediction".tr(),
                            onPressed: () {
                              if (_fadeInAnimationController.isCompleted) {
                                _launchUrl(
                                    Uri.parse(widget.promotedBet.bookmakerUrl));
                                context.pop();
                              } else {
                                _onTapAnywhere();
                              }
                            },
                          ),
                          SecondaryButton.labelText(
                            "backToOverview".tr(),
                            withUnderline: true,
                            onPressed: () {
                              if (_fadeInAnimationController.isCompleted) {
                                context.pop();
                              } else {
                                _onTapAnywhere();
                              }
                            },
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              top: 45,
              left: 0,
              right: 0,
              child: SafeArea(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    FadeTransition(
                      opacity: _fadeAwayAnimation,
                      child: Text(
                        "letsRevealPrediction".tr(),
                        style: context.titleH1.copyWith(
                            color: Colors.white,
                            shadows: AppShadows.textShadows),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    FadeTransition(
                      opacity: _fadeInAnimation,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("predictionOfTheDay".tr(),
                              style: context.titleH1
                                  .copyWith(color: Colors.white)),
                          Text(
                            "tomorrowAnewDay".tr(),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Future<void> _launchUrl(Uri uri) async {
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      logger.e("cannot launch url");
    }
  }
}

class BookieCard extends StatelessWidget {
  const BookieCard({super.key});

//using same assets/animations/img_1.png resolution
  static const int targetWidth = 686;
  static const targetHeight = 470;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      width: context.width * 0.6,
      height: 150,
      child: Column(
        children: [
          Container(
            color: AppColors.secondary,
            width: 64,
            height: 32,
          ),
          const SizedBox(
            height: 12,
          ),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: AutoSizeText(
                "",
                textAlign: TextAlign.center,
                maxLines: 2,
                minFontSize: 1,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(2),
              ),
              child: AutoSizeText(
                "",
                maxLines: 1,
                minFontSize: 1,
                style: context.titleH2,
              ),
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  static Future<MemoryImage> generateImage(
      BuildContext context, String imageNl, String imageEn) async {
    try {
      final imageUrl =
          context.locale.languageCode == dutchLanguageCode ? imageNl : imageEn;
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;
        return MemoryImage(await resizeMemoryImage(
            Uint8List.fromList(bytes), targetWidth, targetHeight));
      } else {
        return await _captureFromWidget(context);
      }
    } catch (e) {
      return await _captureFromWidget(context);
    }
  }

  static Future<MemoryImage> _captureFromWidget(BuildContext context) async {
    ScreenshotController screenshotController = ScreenshotController();
    final list = await screenshotController.captureFromWidget(
        pixelRatio: MediaQuery.of(context).devicePixelRatio,
        context: context,
        const BookieCard());
    return MemoryImage(
        await resizeMemoryImage(list, targetWidth, targetHeight));
  }

  static Future<Uint8List> resizeMemoryImage(
      Uint8List imageData, int targetWidth, int targetHeight) async {
    // Decode the image
    img.Image? originalImage = img.decodeImage(imageData);
    if (originalImage == null) {
      return imageData; // Return original if decoding fails
    }

    // Calculate the aspect ratio
    double aspectRatio = originalImage.width / originalImage.height;

    int newWidth = targetWidth;
    int newHeight = targetHeight;

    // Adjust the dimensions based on the aspect ratio
    if (newWidth / newHeight > aspectRatio) {
      // Resize using height as the constraint
      newWidth = (newHeight * aspectRatio).round();
    } else {
      // Resize using width as the constraint
      newHeight = (newWidth / aspectRatio).round();
    }

    // Resize the image
    img.Image resizedImage =
        img.copyResize(originalImage, width: newWidth, height: newHeight);

    // Encode the resized image back to Uint8List
    return Uint8List.fromList(img.encodeJpg(resizedImage));
  }
}
