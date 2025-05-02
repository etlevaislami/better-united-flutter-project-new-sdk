import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/constants/extended_theme.dart';
import 'package:flutter_better_united/figma/colors.dart';
import 'package:flutter_better_united/pages/create_friend_poule/create_friend_poule_page.dart';
import 'package:flutter_better_united/pages/public_poule/choose_public_poule_page.dart';
import 'package:flutter_better_united/util/shape/path_utils.dart';

class HomePageContent extends StatelessWidget {
  const HomePageContent(
      {super.key, this.unblurredLeftButtonKey, this.unblurredRightButtonKey});

  final GlobalKey? unblurredLeftButtonKey;
  final GlobalKey? unblurredRightButtonKey;

  @override
  Widget build(BuildContext context) {
    return _buildContent(context);
  }

  _buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: SizedBox(
        height: context.height * 0.3,
        child: LayoutBuilder(builder: (context, constraints) {
          return Transform.translate(
            offset: Offset(
              0,
              -(constraints.maxHeight * 0.1),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context, rootNavigator: true)
                          .push(ChoosePublicPoulePage.route());
                    },
                    child: _Button(
                      customPainterKey: unblurredLeftButtonKey,
                      painter: _LeftButtonPainter(),
                      text: "publicPoule".tr().toUpperCase(),
                      image: Transform.translate(
                        offset: const Offset(0, 12),
                        child: Transform.scale(
                          scale: 0.8,
                          child: Image.asset(
                            "assets/icons/ic_public_league_badge.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      actionText: "join".tr(),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 24,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      await Navigator.of(context, rootNavigator: true)
                          .push(CreateFriendPoulePage.route());
                    },
                    child: _Button(
                      customPainterKey: unblurredRightButtonKey,
                      actionText: "create".tr(),
                      painter: _RightButtonPainter(),
                      text: "friendsPoule".tr().toUpperCase(),
                      image: Transform.translate(
                        offset: const Offset(0, 16),
                        child: Transform.scale(
                          scale: 0.85,
                          child: Image.asset(
                            "assets/icons/ic-friendspoule.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class _Button extends StatelessWidget {
  final String text;
  final Widget image;
  final CustomPainter painter;
  final String actionText;

  // Key that is kept globally in order to make it possible to blur everything except for the CustomPaint shape of this button.
  final GlobalKey? customPainterKey;

  const _Button({
    Key? key,
    required this.text,
    required this.image,
    required this.painter,
    required this.actionText,
    this.customPainterKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return CustomPaint(
        painter: painter,
        child: Column(
          key: customPainterKey,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
                child: Align(
              alignment: Alignment.center,
              child: Container(
                  alignment: Alignment.bottomCenter,
                  child: //Add this CustomPaint widget to the Widget Tree
                      image),
            )),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Text(
                actionText.toUpperCase(),
                style: context.labelBold.copyWith(color: Colors.white),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(6),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: AppColors.primary,
              ),
              height: constraints.maxHeight * 0.2,
              child: Text(
                text,
                style: context.labelBold.copyWith(
                    color: Colors.white,
                    fontSize: 14,
                    fontStyle: FontStyle.italic),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class _LeftButtonPainter extends CustomPainter {
  _LeftButtonPainter();

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    var paint2 = Paint()
      ..color = const Color(0xff343434)
      ..style = PaintingStyle.fill;

    const linearGradient = LinearGradient(
      colors: [Color(0xff98E042), Color(0xff535353)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
    final offset = Offset(size.width, size.height);
    final rect =
        Rect.fromPoints(Offset(0, 0), offset);
    paint.shader = linearGradient.createShader(rect);

    var path = PathUtils.getLeftHomeButtonShapePath(size);
    canvas.drawPath(path, paint2);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _RightButtonPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    var paint2 = Paint()
      ..color = const Color(0xff343434)
      ..style = PaintingStyle.fill;

    const linearGradient = LinearGradient(
      colors: [Color(0xff98E042), Color(0xff535353)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
    final rect =
        Rect.fromPoints(const Offset(0, 0), Offset(size.width, size.height));
    paint.shader = linearGradient.createShader(rect);

    const cornerRadius = 8.0;

    // TODO the offset?
    var path = PathUtils.getRightHomeButtonShapePath(size);
    canvas.drawPath(path, paint2);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
