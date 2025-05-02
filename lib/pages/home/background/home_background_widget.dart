import 'dart:ui';

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/figma/colors.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: context.height * 0.46,
          child: ClipPath(
            clipper: _VShapeClipper(),
            child: SizedBox(
              height: context.height * 0.46,
              child: ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  stops: [0.0, 0.6],
                  colors: [Color(0xffBAE54F), Colors.white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ).createShader(bounds),
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        color: const Color(0xffFFFBEB),
                      ),
                    ),
                    Image.asset(
                      "assets/images/img_stadium.png",
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),

              //Add the child widget....
            ),
          ),
        ),
        Positioned.fill(
            child: Align(
          alignment: const Alignment(0, -0.1),
          child: SizedBox(
            height: context.height * 0.3,
            child: Transform.scale(
                scale: 1.6,
                child: Lottie.asset('assets/animations/friends-poule.json')),
          ),
        )),
        Positioned.fill(
          child: Align(
            alignment: const Alignment(0, 0.8),
            child: SizedBox(
              height: 125,
              width: context.width * 0.85,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipPath(
                      clipper: _InvertedRect(),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xff96DE42).withOpacity(0.25),
                                Colors.white,
                                const Color(0xff96DE42).withOpacity(0.25),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.topRight,
                            ),
                          ),
                          padding: const EdgeInsets.only(bottom: 12),
                          child: ClipPath(
                            clipper: _InvertedRect(),
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    const Color(0xff96DE42).withOpacity(0),
                                    const Color(0xff99E243),
                                    const Color(0xff96DE42).withOpacity(0),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.topRight,
                                ),
                              ),
                              child: Align(
                                  alignment: const Alignment(0, 0.9),
                                  child: SizedBox(
                                    height: 23,
                                    width: 120,
                                    child: SvgPicture.asset(
                                        "assets/figma/svg/components/exported_icons/v_shape.svg"),
                                  )),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    child: Visibility(
                      visible: true,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 24),
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.secondary,
                          border:
                              Border.all(color: AppColors.primary, width: 1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: GlowText(
                          "competeWithFriendsInPoule".tr().toUpperCase(),
                          blurRadius: 8,
                          glowColor: AppColors.primary,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            height: 1.5,
                            fontSize: 14,
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _VShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const fraction = 0.8;
    var path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height * fraction)
      ..lineTo(size.width / 2, size.height)
      ..lineTo(0, size.height * fraction)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class _InvertedRect extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    return Path()
      ..moveTo(0, 0)
      ..lineTo(size.width / 2, size.height / 2)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height / 2)
      ..lineTo(size.width / 2, size.height)
      ..lineTo(0, size.height / 2)
      ..moveTo(0, 0)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}