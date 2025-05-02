import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../figma/colors.dart';
import 'background_container.dart';

class TrophyPrimaryButton extends StatelessWidget {
  const TrophyPrimaryButton(
      {Key? key, required this.text, this.onPressed, this.predictionsLeft})
      : super(key: key);
  final String text;
  final VoidCallback? onPressed;
  final int? predictionsLeft;

  @override
  Widget build(BuildContext context) {
    return PredictionLeftContainer(
      predictionsLeft: predictionsLeft,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.all(4),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            boxShadow: onPressed == null
                ? null
                : [
                    const BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.50),
                      offset: Offset(0, 2),
                      blurRadius: 4,
                      spreadRadius: 0,
                    ),
                  ],
            borderRadius: BorderRadius.circular(8.0),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF7B7B7B), Color(0xFF454545)],
            ),
            color: Colors.grey,
          ),
          child: BackgroundContainer(
            padding: EdgeInsets.zero,
            height: 48,
            widthRatio: 0.9,
            leadingChild: Align(
                alignment: Alignment.centerLeft,
                child: ClipRRect(
                  child: Transform.translate(
                    offset: const Offset(-4, 4),
                    child: Transform.scale(
                        scale: 1.3,
                        child: SvgPicture.asset(
                          "assets/figma/svg/components/exported_icons/img_btn_trophy.svg",
                          clipBehavior: Clip.hardEdge,
                          color: Colors.white.withOpacity(0.7),
                        )),
                  ),
                )),
            isInclinationReversed: false,
            withGradient: onPressed != null,
            backgroundColor: onPressed == null
                ? const Color(0xff353535)
                : const Color(0xff3C3C3C),
            foregroundColor: onPressed == null
                ? AppColors.buttonInnactive
                : AppColors.primary,
            centerChild: Container(
              alignment: Alignment.center,
              child: Text(
                text.toUpperCase(),
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 16,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.5),
                        offset: const Offset(0, 2),
                        blurRadius: 16,
                      ),
                    ],
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
          width: double.infinity,
        ),
      ),
    );
  }
}

class PredictionLeftContainer extends StatelessWidget {
  const PredictionLeftContainer(
      {Key? key, this.predictionsLeft, required this.child})
      : super(key: key);
  final int? predictionsLeft;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        child,
        predictionsLeft == null
            ? const SizedBox()
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "predictionLeftArgs".plural(predictionsLeft!),
                      style: const TextStyle(
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    margin: const EdgeInsets.all(4),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xffF8801D),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ],
              ),
      ],
    );
  }
}
