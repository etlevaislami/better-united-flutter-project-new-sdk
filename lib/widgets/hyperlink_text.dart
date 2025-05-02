import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';

class HyperlinkText extends StatelessWidget {
  const HyperlinkText(
    this.text, {
    Key? key,
    this.onTap,
    this.color = Colors.white,
  }) : super(key: key);
  final GestureTapCallback? onTap;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                text,
                style: context.labelMedium?.copyWith(
                    decoration: TextDecoration.underline, color: color),
              ),
              Container(
                color: Colors.red,
                height: 5,
              ),
              const Divider(
                color: Colors.white,
                thickness: 1,
              )
            ],
          ),
        ],
      ),
    );
  }
}
