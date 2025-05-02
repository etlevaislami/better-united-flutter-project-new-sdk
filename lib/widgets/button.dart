import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final bool? hasShadow;
  final Widget? icon;
  final Color backgroundColor;
  final Color foregroundColor;
  final double? fontSize;

  const Button(
      {Key? key,
      required this.onPressed,
      required this.text,
      this.hasShadow,
      this.icon,
      this.backgroundColor = const Color(0xffFECF43),
      this.foregroundColor = const Color(0xff5A5A5A),
      this.fontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: double.infinity),
      child: icon == null
          ? TextButton(
              style: getStyle(),
              onPressed: onPressed,
              child: getText(),
            )
          : TextButton.icon(
              onPressed: onPressed,
              icon: icon!,
              label: getText(),
              style: getStyle(),
            ),
    );
  }

  ButtonStyle getStyle() {
    return TextButton.styleFrom(
      padding:
          fontSize == null ? const EdgeInsets.only(top: 23, bottom: 23) : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      backgroundColor: onPressed == null
          ? backgroundColor.withOpacity(0.5)
          : backgroundColor,
    );
  }

  Text getText() {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: fontSize,
        color: onPressed == null
            ? foregroundColor.withOpacity(0.5)
            : foregroundColor,
      ),
    );
  }
}
