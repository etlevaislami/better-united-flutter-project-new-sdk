import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/constants/app_colors.dart';

import 'background_container.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.foregroundColor = AppColors.primaryColor,
    this.prefixIcon,
    this.confineInSafeArea = true,
  }) : super(key: key);
  final String text;
  final VoidCallback? onPressed;
  final Color foregroundColor;
  final Widget? prefixIcon;
  final bool confineInSafeArea;

  @override
  Widget build(BuildContext context) {
    final opacity = onPressed == null ? 0.23 : 1.0;
    final button = GestureDetector(
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
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF7B7B7B).withOpacity(opacity),
              const Color(0xFF454545).withOpacity(opacity)
            ],
          ),
          color: Colors.grey,
        ),
        child: BackgroundContainer(
          padding: EdgeInsets.zero,
          height: 48,
          widthRatio: 0.9,
          leadingChild: prefixIcon,
          isInclinationReversed: false,
          withGradient: onPressed != null,
          backgroundColor: onPressed == null
              ? const Color(0xff353535)
              : const Color(0xff3C3C3C),
          foregroundColor:
              onPressed == null ? Colors.transparent : foregroundColor,
          centerChild: Container(
            alignment: Alignment.center,
            child: AutoSizeText(
              text.toUpperCase(),
              maxLines: 1,
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 16,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.5),
                      offset: const Offset(0, 2),
                      blurRadius: 16,
                    ),
                  ],
                  color: onPressed == null
                      ? const Color(0xff282828)
                      : Colors.white,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
        width: double.infinity,
      ),
    );
    return confineInSafeArea
        ? SafeArea(
            minimum: const EdgeInsets.symmetric(vertical: 12), child: button)
        : button;
  }
}
