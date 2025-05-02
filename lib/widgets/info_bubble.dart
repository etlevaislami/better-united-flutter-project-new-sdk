import 'package:flutter/material.dart';
import 'package:flutter_better_united/constants/extended_theme.dart';
import 'package:flutter_better_united/figma/colors.dart';
import 'package:flutter_better_united/util/betterUnited_icons.dart';

class InfoBubble extends StatelessWidget {
  const InfoBubble({
    Key? key,
    required this.description,
    this.child,
    this.backgroundColor = AppColors.secondary,
    this.title,
    this.padding = const EdgeInsets.all(16),
  }) : super(key: key);
  final String description;
  final String? title;

  final Widget? child;
  final Color backgroundColor;
  final EdgeInsetsGeometry? padding;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(BetterUnited.bubble,
                  size: 25, color: AppColors.primary),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: title != null ? "$title\n\n" : "",
                        style: context.labelRegular.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: description,
                        style: context.labelRegular.copyWith(
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          child != null
              ? Padding(padding: const EdgeInsets.only(top: 16), child: child!)
              : const SizedBox()
        ],
      ),
    );
  }
}
