import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/constants/extended_theme.dart';
import 'package:flutter_better_united/data/enum/tip_settlement.dart';
import 'package:flutter_better_united/widgets/points_widget.dart';

import '../figma/colors.dart';

class PredictionResultCard extends StatelessWidget {
  PredictionResultCard(
      {super.key,
      required this.isVoided,
      required this.odd,
      required this.tipSettlement,
      required this.points}) {
    if (isVoided) {
      gradientColors = [Color(0xffBBBBBB), Color(0xff353535).withOpacity(0)];
      highlightedColor = AppColors.textEmpty;
      pointColor = AppColors.buttonInnactive;
      result = "voided".tr();
    } else {
      switch (tipSettlement) {
        case TipSettlement.notStarted:
          gradientColors = [const Color(0xff9AE243), const Color(0xff353535)];
          highlightedColor = AppColors.textWhite;
          pointColor = AppColors.buttonInnactive;
          result = "";
          break;
        case TipSettlement.undetermined:
          gradientColors = [const Color(0xff9AE243), const Color(0xff353535)];
          highlightedColor = AppColors.textWhite;
          pointColor = AppColors.buttonInnactive;
          result = "active".tr();
          break;
        case TipSettlement.won:
          gradientColors = [const Color(0xff9AE243), const Color(0xff353535)];
          highlightedColor = AppColors.primary;
          pointColor = AppColors.primary;
          result = "won".tr();
          break;
        case TipSettlement.lost:
          gradientColors = [
            const Color(0xffF03D3D),
            const Color(0xffF03D3D).withOpacity(0)
          ];
          highlightedColor = AppColors.textError;
          pointColor = AppColors.buttonInnactive;
          result = "lost".tr();
          break;
      }
    }
  }

  final String odd;
  final TipSettlement tipSettlement;
  final int points;
  late final List<Color> gradientColors;
  late final Color highlightedColor;
  late final Color pointColor;
  late final String result;
  final bool isVoided;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xff353535), borderRadius: BorderRadius.circular(4)),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: gradientColors,
            ),
            borderRadius: BorderRadius.circular(4)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: CustomPaint(
            painter: _Painter(),
            child: Row(
              children: [
                Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "prediction".tr().toUpperCase(),
                            style: context.labelBoldItalic
                                .copyWith(color: Colors.white),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            odd,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: context.bodyRegular
                                .copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    )),
                Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: tipSettlement == TipSettlement.notStarted
                          ? Center(
                              child: PointsWidget(points: points),
                            )
                          : _getResultText(context),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getResultText(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          result.toUpperCase(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: highlightedColor,
          ),
        ),
        SizedBox(
          height: 4,
        ),
        RichText(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          text: TextSpan(
            style: context.bodyBold
                .copyWith(fontStyle: FontStyle.italic, color: Colors.white),
            children: [
              TextSpan(
                  text: points.toString(),
                  style: context.bodyBold.copyWith(
                      fontSize: 24,
                      fontStyle: FontStyle.italic,
                      color: pointColor)),
              TextSpan(
                text: "pointArgs".plural(points),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Painter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint2 = Paint()
      ..color = const Color(0xff353535)
      ..style = PaintingStyle.fill;

    Paint paint3 = Paint()
      ..color = const Color(0xff535353)
      ..style = PaintingStyle.fill;

    final extra = size.width * 0.1;
    final spacing = extra / 3;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width * 0.6, 0)
      ..lineTo(size.width * 0.6 + extra, size.height)
      ..lineTo(0, size.height)
      ..moveTo(0, 0)
      ..close();

    canvas.drawPath(path, paint2);

    final path2 = Path()
      ..moveTo(size.width * 0.6 + spacing, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width * 0.6 + extra + spacing, size.height)
      ..moveTo(size.width * 0.6 + spacing, 0)
      ..close();

    canvas.drawPath(path2, paint3);

    //canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
