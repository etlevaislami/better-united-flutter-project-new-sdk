import 'package:flutter/material.dart';

import 'background_container.dart';

class SettingButton extends StatelessWidget {
  const SettingButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      required this.prefixIcon})
      : super(key: key);
  final String text;
  final VoidCallback onPressed;
  final Widget prefixIcon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: BackgroundContainer(
        height: 48,
        widthRatio: 0.23,
        isCenterChildConstrained: false,
        leadingChild: Container(
          alignment: Alignment.centerLeft,
          child: prefixIcon,
        ),
        centerChild: Text(
          text.toUpperCase(),
          style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.italic),
        ),
        withGradient: false,
        foregroundColor: const Color(0xff353535),
        backgroundColor: const Color(0xff535353),
      ),
    );
  }
}
