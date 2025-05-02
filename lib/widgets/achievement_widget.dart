import 'package:flutter/material.dart';
import 'package:flutter_better_united/util/extensions/color_extension.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/app_colors.dart';

class AchievementWidget extends StatelessWidget {
  AchievementWidget({
    Key? key,
    required this.levelNumber,
    this.width = 80,
    this.ratio = 2,
  }) : super(key: key) {
    if (levelNumber < 5) {
      color = AppColors.dryMoss;
      icon = SvgPicture.asset(
        "assets/icons/ic_level_1.svg",
      );
    } else if (levelNumber < 10) {
      // 1 star
      color = AppColors.posterBlue;
      icon = SvgPicture.asset(
        "assets/icons/ic_level_5.svg",
      );
    } else if (levelNumber < 15) {
      // 2 stars
      color = AppColors.demonicKiss;
      icon = SvgPicture.asset(
        "assets/icons/ic_level_10.svg",
      );
    } else if (levelNumber < 20) {
      // 3 stars
      color = AppColors.sapphireSiren;
      icon = SvgPicture.asset(
        "assets/icons/ic_level_15.svg",
      );
    } else if (levelNumber < 25) {
      // 4 stars
      color = AppColors.smaragdine;
      icon = SvgPicture.asset(
        "assets/icons/ic_level_20.svg",
      );
    } else {
      // diamond
      color = AppColors.flyway;
      icon = SvgPicture.asset(
        "assets/icons/ic_level_25.svg",
      );
    }
  }

  late final Color color;
  final int levelNumber;
  final double width;
  final double ratio;
  late final Widget icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: width * ratio,
      width: width,
      child: LayoutBuilder(
        builder: (context, constraints) => Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: CustomPaint(
                size: Size(constraints.maxWidth - constraints.maxWidth * 0.2,
                    constraints.maxHeight - constraints.maxWidth * 0.2),
                painter: RankBackgroundPainter(color),
              ),
            ),
            SizedBox(
              width: width,
              height: width,
              child: SvgPicture.asset(
                "assets/icons/ic_medal.svg",
                color: color.increaseColorLightness(0.2),
              ),
            ),
            SizedBox(
              width: width,
              height: width,
              child: Opacity(
                opacity: 0.1,
                child: SvgPicture.asset(
                  "assets/icons/ic_shader.svg",
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(width * 0.13),
              width: width,
              height: width,
              child: icon,
            ),
          ],
        ),
      ),
    );
  }
}

class RankBackgroundPainter extends CustomPainter {
  final Color color;

  RankBackgroundPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paintBackground = Paint()..style = PaintingStyle.fill;
    paintBackground.color = Colors.transparent;
    canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width, size.height), paintBackground);

    Path path = Path();
    path.moveTo(size.width * 0.03844231, 0);
    path.lineTo(size.width * 0.9615577, 0);
    path.quadraticBezierTo(size.width * 0.9634462, 0, size.width * 0.9653250,
        size.height * 0.00008157398);
    path.quadraticBezierTo(size.width * 0.9672058, size.height * 0.0001631483,
        size.width * 0.9690577, size.height * 0.0003255102);
    path.quadraticBezierTo(size.width * 0.9709096, size.height * 0.0004878729,
        size.width * 0.9727173, size.height * 0.0007294602);
    path.quadraticBezierTo(size.width * 0.9745250, size.height * 0.0009710508,
        size.width * 0.9762692, size.height * 0.001289534);
    path.quadraticBezierTo(size.width * 0.9780135, size.height * 0.001608017,
        size.width * 0.9796788, size.height * 0.002000331);
    path.quadraticBezierTo(size.width * 0.9813442, size.height * 0.002392653,
        size.width * 0.9829154, size.height * 0.002855017);
    path.quadraticBezierTo(size.width * 0.9844846, size.height * 0.003317390,
        size.width * 0.9859442, size.height * 0.003845356);
    path.quadraticBezierTo(size.width * 0.9874058, size.height * 0.004373322,
        size.width * 0.9887404, size.height * 0.004961814);
    path.quadraticBezierTo(size.width * 0.9900750, size.height * 0.005550297,
        size.width * 0.9912731, size.height * 0.006193627);
    path.quadraticBezierTo(size.width * 0.9924712, size.height * 0.006836958,
        size.width * 0.9935212, size.height * 0.007528941);
    path.quadraticBezierTo(size.width * 0.9945712, size.height * 0.008220924,
        size.width * 0.9954615, size.height * 0.008954915);
    path.quadraticBezierTo(size.width * 0.9963500, size.height * 0.009688898,
        size.width * 0.9970731, size.height * 0.01045780);
    path.quadraticBezierTo(size.width * 0.9977962, size.height * 0.01122661,
        size.width * 0.9983442, size.height * 0.01202305);
    path.quadraticBezierTo(size.width * 0.9988923, size.height * 0.01281949,
        size.width * 0.9992615, size.height * 0.01363568);
    path.quadraticBezierTo(size.width * 0.9996288, size.height * 0.01445195,
        size.width * 0.9998154, size.height * 0.01528017);
    path.quadraticBezierTo(size.width, size.height * 0.01610847, size.width,
        size.height * 0.01694068);
    path.lineTo(size.width, size.height * 0.9610847);
    path.quadraticBezierTo(size.width, size.height * 0.9618729,
        size.width * 0.9998885, size.height * 0.9626610);
    path.quadraticBezierTo(size.width * 0.9997788, size.height * 0.9634492,
        size.width * 0.9995577, size.height * 0.9642288);
    path.quadraticBezierTo(size.width * 0.9993365, size.height * 0.9650085,
        size.width * 0.9990038, size.height * 0.9657881);
    path.quadraticBezierTo(size.width * 0.9986731, size.height * 0.9665593,
        size.width * 0.9982346, size.height * 0.9673220);
    path.quadraticBezierTo(size.width * 0.9977962, size.height * 0.9680932,
        size.width * 0.9972500, size.height * 0.9688390);
    path.quadraticBezierTo(size.width * 0.9967038, size.height * 0.9695932,
        size.width * 0.9960538, size.height * 0.9703220);
    path.quadraticBezierTo(size.width * 0.9954038, size.height * 0.9710593,
        size.width * 0.9946500, size.height * 0.9717712);
    path.quadraticBezierTo(size.width * 0.9938981, size.height * 0.9724915,
        size.width * 0.9930462, size.height * 0.9731864);
    path.quadraticBezierTo(size.width * 0.9921962, size.height * 0.9738729,
        size.width * 0.9912481, size.height * 0.9745424);
    path.quadraticBezierTo(size.width * 0.9903000, size.height * 0.9752119,
        size.width * 0.9892615, size.height * 0.9758559);
    path.quadraticBezierTo(size.width * 0.9882212, size.height * 0.9765000,
        size.width * 0.9870923, size.height * 0.9771102);
    path.quadraticBezierTo(size.width * 0.9859654, size.height * 0.9777203,
        size.width * 0.9847538, size.height * 0.9783051);
    path.quadraticBezierTo(size.width * 0.9835423, size.height * 0.9788814,
        size.width * 0.9822500, size.height * 0.9794237);
    path.quadraticBezierTo(size.width * 0.9809596, size.height * 0.9799746,
        size.width * 0.9795942, size.height * 0.9804831);
    path.quadraticBezierTo(size.width * 0.9782288, size.height * 0.9809915,
        size.width * 0.9767962, size.height * 0.9814661);
    path.quadraticBezierTo(size.width * 0.9753615, size.height * 0.9819322,
        size.width * 0.9738635, size.height * 0.9823644);
    path.quadraticBezierTo(size.width * 0.9723654, size.height * 0.9827966,
        size.width * 0.9708096, size.height * 0.9831864);
    path.quadraticBezierTo(size.width * 0.9692538, size.height * 0.9835763,
        size.width * 0.9676481, size.height * 0.9839237);
    path.quadraticBezierTo(size.width * 0.9660404, size.height * 0.9842627,
        size.width * 0.9643865, size.height * 0.9845678);
    path.quadraticBezierTo(size.width * 0.9627346, size.height * 0.9848729,
        size.width * 0.9610423, size.height * 0.9851271);
    path.quadraticBezierTo(size.width * 0.9593500, size.height * 0.9853814,
        size.width * 0.9576250, size.height * 0.9855932);
    path.quadraticBezierTo(size.width * 0.9559000, size.height * 0.9857966,
        size.width * 0.9541500, size.height * 0.9859576);
    path.quadraticBezierTo(size.width * 0.9524000, size.height * 0.9861186,
        size.width * 0.9506288, size.height * 0.9862373);
    path.quadraticBezierTo(size.width * 0.9488577, size.height * 0.9863475,
        size.width * 0.9470750, size.height * 0.9864153);
    path.quadraticBezierTo(size.width * 0.9452923, size.height * 0.9864831,
        size.width * 0.9435038, size.height * 0.9864915);
    path.quadraticBezierTo(size.width * 0.9417154, size.height * 0.9865085,
        size.width * 0.9399288, size.height * 0.9864831);
    path.quadraticBezierTo(size.width * 0.9381404, size.height * 0.9864492,
        size.width * 0.9363615, size.height * 0.9863644);
    path.quadraticBezierTo(size.width * 0.9345827, size.height * 0.9862797,
        size.width * 0.9328192, size.height * 0.9861525);
    path.quadraticBezierTo(size.width * 0.9310538, size.height * 0.9860254,
        size.width * 0.9293115, size.height * 0.9858475);
    path.quadraticBezierTo(size.width * 0.9275692, size.height * 0.9856695,
        size.width * 0.9258538, size.height * 0.9854407);
    path.quadraticBezierTo(size.width * 0.9241404, size.height * 0.9852203,
        size.width * 0.9224615, size.height * 0.9849492);
    path.quadraticBezierTo(size.width * 0.9207808, size.height * 0.9846780,
        size.width * 0.9191423, size.height * 0.9843559);
    path.lineTo(size.width * 0.5040365, size.height * 0.9040508);
    path.quadraticBezierTo(size.width * 0.5005365, size.height * 0.9033729,
        size.width * 0.4968019, size.height * 0.9030085);
    path.quadraticBezierTo(size.width * 0.4930673, size.height * 0.9026525,
        size.width * 0.4892442, size.height * 0.9026186);
    path.quadraticBezierTo(size.width * 0.4854231, size.height * 0.9025932,
        size.width * 0.4816615, size.height * 0.9028983);
    path.quadraticBezierTo(size.width * 0.4779019, size.height * 0.9032034,
        size.width * 0.4743500, size.height * 0.9038220);
    path.lineTo(size.width * 0.07902692, size.height * 0.9732627);
    path.quadraticBezierTo(size.width * 0.07739404, size.height * 0.9735508,
        size.width * 0.07572442, size.height * 0.9737881);
    path.quadraticBezierTo(size.width * 0.07405500, size.height * 0.9740339,
        size.width * 0.07235500, size.height * 0.9742288);
    path.quadraticBezierTo(size.width * 0.07065500, size.height * 0.9744237,
        size.width * 0.06893115, size.height * 0.9745763);
    path.quadraticBezierTo(size.width * 0.06720712, size.height * 0.9747288,
        size.width * 0.06546538, size.height * 0.9748305);
    path.quadraticBezierTo(size.width * 0.06372365, size.height * 0.9749407,
        size.width * 0.06197058, size.height * 0.9750000);
    path.quadraticBezierTo(size.width * 0.06021769, size.height * 0.9750508,
        size.width * 0.05846000, size.height * 0.9750678);
    path.quadraticBezierTo(size.width * 0.05670231, size.height * 0.9750763,
        size.width * 0.05494635, size.height * 0.9750424);
    path.quadraticBezierTo(size.width * 0.05319058, size.height * 0.9750000,
        size.width * 0.05144308, size.height * 0.9749153);
    path.quadraticBezierTo(size.width * 0.04969538, size.height * 0.9748305,
        size.width * 0.04796269, size.height * 0.9747034);
    path.quadraticBezierTo(size.width * 0.04623000, size.height * 0.9745763,
        size.width * 0.04451846, size.height * 0.9743983);
    path.quadraticBezierTo(size.width * 0.04280692, size.height * 0.9742203,
        size.width * 0.04112308, size.height * 0.9740000);
    path.quadraticBezierTo(size.width * 0.03943904, size.height * 0.9737797,
        size.width * 0.03778904, size.height * 0.9735085);
    path.quadraticBezierTo(size.width * 0.03613904, size.height * 0.9732458,
        size.width * 0.03452885, size.height * 0.9729322);
    path.quadraticBezierTo(size.width * 0.03291885, size.height * 0.9726186,
        size.width * 0.03135462, size.height * 0.9722627);
    path.quadraticBezierTo(size.width * 0.02979058, size.height * 0.9719153,
        size.width * 0.02827808, size.height * 0.9715169);
    path.quadraticBezierTo(size.width * 0.02676577, size.height * 0.9711271,
        size.width * 0.02531077, size.height * 0.9706864);
    path.quadraticBezierTo(size.width * 0.02385577, size.height * 0.9702542,
        size.width * 0.02246346, size.height * 0.9697797);
    path.quadraticBezierTo(size.width * 0.02107115, size.height * 0.9693051,
        size.width * 0.01974692, size.height * 0.9687966);
    path.quadraticBezierTo(size.width * 0.01842265, size.height * 0.9682881,
        size.width * 0.01717123, size.height * 0.9677458);
    path.quadraticBezierTo(size.width * 0.01591979, size.height * 0.9672034,
        size.width * 0.01474587, size.height * 0.9666271);
    path.quadraticBezierTo(size.width * 0.01357192, size.height * 0.9660508,
        size.width * 0.01247987, size.height * 0.9654407);
    path.quadraticBezierTo(size.width * 0.01138781, size.height * 0.9648305,
        size.width * 0.01038165, size.height * 0.9641949);
    path.quadraticBezierTo(size.width * 0.009375500, size.height * 0.9635678,
        size.width * 0.008459019, size.height * 0.9628983);
    path.quadraticBezierTo(size.width * 0.007542519, size.height * 0.9622458,
        size.width * 0.006719077, size.height * 0.9615593);
    path.quadraticBezierTo(size.width * 0.005895635, size.height * 0.9608729,
        size.width * 0.005168308, size.height * 0.9601695);
    path.quadraticBezierTo(size.width * 0.004440981, size.height * 0.9594661,
        size.width * 0.003812481, size.height * 0.9587373);
    path.quadraticBezierTo(size.width * 0.003183962, size.height * 0.9580169,
        size.width * 0.002656596, size.height * 0.9572797);
    path.quadraticBezierTo(size.width * 0.002129231, size.height * 0.9565339,
        size.width * 0.001704971, size.height * 0.9557881);
    path.quadraticBezierTo(size.width * 0.001280710, size.height * 0.9550339,
        size.width * 0.0009611288, size.height * 0.9542712);
    path.quadraticBezierTo(size.width * 0.0006415462, size.height * 0.9535085,
        size.width * 0.0004278288, size.height * 0.9527458);
    path.quadraticBezierTo(size.width * 0.0002141135, size.height * 0.9519746,
        size.width * 0.0001070567, size.height * 0.9512034);
    path.quadraticBezierTo(
        0, size.height * 0.9504237, 0, size.height * 0.9496525);
    path.lineTo(0, size.height * 0.01694068);
    path.quadraticBezierTo(0, size.height * 0.01610847,
        size.width * 0.0001851102, size.height * 0.01528017);
    path.quadraticBezierTo(size.width * 0.0003702212, size.height * 0.01445195,
        size.width * 0.0007386577, size.height * 0.01363568);
    path.quadraticBezierTo(size.width * 0.001107096, size.height * 0.01281949,
        size.width * 0.001655313, size.height * 0.01202305);
    path.quadraticBezierTo(size.width * 0.002203538, size.height * 0.01122661,
        size.width * 0.002926250, size.height * 0.01045780);
    path.quadraticBezierTo(size.width * 0.003648962, size.height * 0.009688898,
        size.width * 0.004539212, size.height * 0.008954915);
    path.quadraticBezierTo(size.width * 0.005429481, size.height * 0.008220924,
        size.width * 0.006478692, size.height * 0.007528941);
    path.quadraticBezierTo(size.width * 0.007527923, size.height * 0.006836958,
        size.width * 0.008726000, size.height * 0.006193627);
    path.quadraticBezierTo(size.width * 0.009924077, size.height * 0.005550297,
        size.width * 0.01125950, size.height * 0.004961814);
    path.quadraticBezierTo(size.width * 0.01259490, size.height * 0.004373322,
        size.width * 0.01405477, size.height * 0.003845356);
    path.quadraticBezierTo(size.width * 0.01551463, size.height * 0.003317390,
        size.width * 0.01708490, size.height * 0.002855017);
    path.quadraticBezierTo(size.width * 0.01865517, size.height * 0.002392653,
        size.width * 0.02032077, size.height * 0.002000331);
    path.quadraticBezierTo(size.width * 0.02198635, size.height * 0.001608017,
        size.width * 0.02373115, size.height * 0.001289534);
    path.quadraticBezierTo(size.width * 0.02547577, size.height * 0.0009710508,
        size.width * 0.02728308, size.height * 0.0007294602);
    path.quadraticBezierTo(size.width * 0.02909038, size.height * 0.0004878729,
        size.width * 0.03094250, size.height * 0.0003255102);
    path.quadraticBezierTo(size.width * 0.03279481, size.height * 0.0001631483,
        size.width * 0.03467423, size.height * 0.00008157398);
    path.quadraticBezierTo(
        size.width * 0.03655385, 0, size.width * 0.03844231, 0);
    path.lineTo(size.width * 0.03844231, 0);
    path.close();

    Paint paintFill = Paint()..style = PaintingStyle.fill;
    paintFill.color = color;
    canvas.drawPath(path, paintFill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
