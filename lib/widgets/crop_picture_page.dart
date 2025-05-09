import 'dart:io';
import 'dart:math';

import 'package:custom_image_crop/custom_image_crop.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_better_united/util/ui_util.dart';
import 'package:flutter_svg/svg.dart';

class CropPicturePage extends StatefulWidget {
  final String photoPath;

  const CropPicturePage(this.photoPath, {Key? key}) : super(key: key);

  @override
  _CropPicturePageState createState() => _CropPicturePageState();
}

class _CropPicturePageState extends State<CropPicturePage> {
  final _controller = CustomImageCropController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      SystemChrome.setSystemUIOverlayStyle(
          const SystemUiOverlayStyle(statusBarColor: Colors.black));
    });
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              color: Colors.black,
              child: Row(
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("cancel".tr(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: Colors.white))),
                  Expanded(
                      child: Text(
                    "cropRotate".tr(),
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                  )),
                  TextButton(
                    child: Text("done".tr(),
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold)),
                    onPressed: () async {
                      beginLoading();
                      var data = await _controller.onCropImage();
                      endLoading();
                      Navigator.pop(context, data);
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: CustomImageCrop(
                backgroundColor: Colors.black,
                overlayColor: Colors.black.withOpacity(0.6),
                shape: CustomCropShape.Circle,
                drawPath: (path, {Color? outlineColor, double? outlineStrokeWidth, Paint? pathPaint}) =>
                    CustomPaint(painter: CustomCropPathPainter(path)),
                cropPercentage: 0.85,
                cropController: _controller,
                image: FileImage(File(widget.photoPath)),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10),
              color: Colors.black,
              child: IconButton(
                  icon: SvgPicture.asset('assets/images/ic_rotate.svg'),
                  iconSize: 25,
                  onPressed: () =>
                      _controller.addTransition(CropImageData(angle: -pi / 4))),
            )
          ],
        ),
      ),
    );
  }
}

/// Draw a solid path around the given path
class CustomCropPathPainter extends CustomPainter {
  final Path _path;
  final _circlePaint = Paint()
    ..color = Colors.transparent
    ..style = PaintingStyle.stroke
    ..strokeJoin = StrokeJoin.round;

  /// Draw a solid path around the given path
  CustomCropPathPainter(this._path);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPath(_path, _circlePaint);
  }

  @override
  bool shouldRepaint(covariant CustomCropPathPainter oldDelegate) =>
      oldDelegate._path != _path;
}
