import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class ButtonChooser extends StatelessWidget {
  const ButtonChooser(
    this.text, {
    Key? key,
    this.assetName,
    this.onTap,
    required this.color,
    required this.icon,
    this.textColor = Colors.white,
    this.drawShadow = false,
    this.shadow,
    this.centerText,
    this.padding = const EdgeInsets.only(left: 21.0, top: 16, bottom: 16),
    this.iconWidth = 42,
  }) : super(key: key);
  final String text;
  final String? assetName;
  final Color color;
  final Color textColor;
  final Widget icon;
  final GestureTapCallback? onTap;
  final bool drawShadow;
  final BoxShadow? shadow;
  final bool? centerText;
  final EdgeInsets padding;
  final double iconWidth;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: padding,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
          boxShadow: drawShadow
              ? [
                  shadow ??
                      BoxShadow(
                        color: AppColors.blueGrey800.withAlpha(8),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: centerText == null
              ? MainAxisAlignment.start
              : MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(right: centerText == null ? 32.0 : 0),
              child: SizedBox(
                width: iconWidth,
                height: iconWidth,
                child: icon,
              ),
            ),
            Text(
              text,
              style: context.titleMedium,
            ).textColor(textColor),
            SizedBox(
              width: centerText != null ? 52 : 32.0,
              height: 42,
            ),
          ],
        ),
      ),
    );
  }
}
