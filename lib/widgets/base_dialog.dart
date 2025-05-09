import 'dart:ui';

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class BaseDialog extends StatelessWidget {
  const BaseDialog(
      {super.key,
      required this.child,
      required this.withAnimation,
      required this.withConfetti,
      required this.icon,
      this.positionMultiplier = 2});

  final Widget child;
  final Widget icon;
  final bool withAnimation;
  final bool withConfetti;
  final int positionMultiplier;

  @override
  Widget build(BuildContext context) {
    final circleHeight = context.width * 0.5;
    final position = circleHeight * 0.5;
    final imageHeight = circleHeight / 2;
    return Container(
      alignment: Alignment.center,
      child: Stack(
        children: [
          Positioned.fill(
              child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(),
          )),
          Positioned.fill(
            top: position * positionMultiplier,
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      clipBehavior: Clip.none,
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
                            withAnimation
                                ? Transform.scale(
                                    scale: 1.9,
                                    child: Lottie.asset(
                                        'assets/animations/daily-rewards.json'))
                                : const SizedBox()
                          ],
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(0, -position),
                      child: Material(
                        color: const Color(0xff2B2B2B),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8.0)),
                        elevation: 24,
                        clipBehavior: Clip.antiAlias,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: context.width,
                            minWidth: context.width,
                            maxHeight: context.height * 0.42,
                            minHeight: circleHeight,
                          ),
                          child: SizedBox(
                            width: context.width,
                            child: Padding(
                              padding: EdgeInsets.only(top: imageHeight / 2),
                              child: child,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: position * 0.5,
                  left: 0,
                  right: 0,
                  child: Center(
                      child: SizedBox(
                    width: imageHeight,
                    height: imageHeight,
                    child: icon,
                  )),
                ),
                // Load a Lottie file from your assets
              ],
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
