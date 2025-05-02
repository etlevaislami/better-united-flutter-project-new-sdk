import 'dart:ui';

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class BottomSheetBaseDialog extends StatelessWidget {
  const BottomSheetBaseDialog(
      {Key? key,
      required this.child,
      required this.withAnimation,
      this.icon,
      required this.withConfetti})
      : super(key: key);
  final Widget child;
  final bool withAnimation;
  final bool withConfetti;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    final circleHeight = context.width * 0.5;
    final imageHeight = circleHeight / 2;

    final dialogHeightFactor = 0.9;

    return Container(
      alignment: Alignment.center,
      child: Stack(
        children: [
          Positioned.fill(
              child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(),
          )),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: dialogHeightFactor * context.height,
              child: Stack(
                children: [
                  Align(
                    child: SizedBox(
                      height: circleHeight,
                      width: circleHeight,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color(0xffBAD450),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    alignment: Alignment.topCenter,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: dialogHeightFactor * context.height -
                          0.5 * circleHeight,
                      decoration: const BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(22),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[Color(0xff2A2A2A), Color(0xff111111)],
                          stops: <double>[0.0, 1.0],
                        ),
                      ),
                      child: Padding(
                          padding: EdgeInsets.only(top: 0.5 * imageHeight),
                          child: child),
                    ),
                  ),
                  Align(
                    child: SizedBox(
                      height: circleHeight,
                      width: circleHeight,
                      child: Center(
                          child: SizedBox(
                        width: imageHeight,
                        height: imageHeight,
                        child: icon,
                      )),
                    ),
                    alignment: Alignment.topCenter,
                  ),
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: withConfetti
                ? Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      child: Lottie.asset('assets/animations/confetti.json',
                          repeat: false),
                    ),
                  )
                : const SizedBox(),
          ),
        ],
      ),
    );
  }
}
