import 'dart:ui';

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class FullscreenBaseDialog extends StatelessWidget {
  const FullscreenBaseDialog({
    Key? key,
    required this.child,
    required this.withAnimation,
    this.icon,
    required this.withConfetti,
    this.expandChild = true,
    this.bottomPadding = 100.0,
  }) : super(key: key);
  final Widget child;
  final bool withAnimation;
  final bool withConfetti;
  final Widget? icon;
  final bool? expandChild;
  final double bottomPadding;

  @override
  Widget build(BuildContext context) {
    final circleHeight = context.width * 0.6;
    final position = circleHeight * 0.6;
    return Container(
      alignment: Alignment.center,
      child: Stack(
        children: [
          Positioned.fill(
              child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(),
          )),
          Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  height: circleHeight,
                  width: circleHeight,
                  child: Stack(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Color(0xffBAD450),
                          shape: BoxShape.circle,
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(0, circleHeight * 0.1),
                        child: Transform.scale(
                            scale: 2.1,
                            child: withAnimation
                                ? Lottie.asset(
                                    'assets/animations/daily-rewards.json')
                                : const SizedBox()),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(
                    top: circleHeight * 0.55, left: 14, right: 14, bottom: bottomPadding),
                decoration: const BoxDecoration(
                  color: Color(0xff2B2B2B),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                child: expandChild == true
                    ? Column(
                        children: [Expanded(child: child)],
                      )
                    : child,
              ),
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                    height: circleHeight,
                    width: circleHeight,
                    child: Transform.scale(scale: 0.65, child: icon)),
              ),
            ],
          ),
          withConfetti
              ? Transform.translate(
                  offset: Offset(0, -position),
                  child: IgnorePointer(
                    child: Lottie.asset(
                      'assets/animations/confetti.json',
                      repeat: false,
                    ),
                  ))
              : const SizedBox(),
          // Load a Lottie file from your assets
        ],
      ),
    );
  }
}
