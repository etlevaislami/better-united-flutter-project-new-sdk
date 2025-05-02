import 'package:flutter/material.dart';

class FixedButton extends StatelessWidget {
  final IconData iconData;
  final GestureTapCallback? onTap;
  final bool drawGradient;
  late final Gradient? gradient;
  final double? size;

  FixedButton({
    Key? key,
    required this.iconData,
    this.onTap,
    this.drawGradient = true,
    this.size,
  }) : super(key: key) {
    gradient = drawGradient
        ? const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF7B7B7B), Color(0xFF454545)],
          )
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(4),
        ),
        height: 40,
        width: 40,
        padding: const EdgeInsets.all(4),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xFFAAE15E),
            borderRadius: BorderRadius.circular(2),
          ),
          child: Icon(
            iconData,
            color: Colors.white,
            size: size ?? 14,
          ),
        ),
      ),
    );
  }
}
