import 'package:flutter/cupertino.dart';

import '../figma/colors.dart';

class RoundedContainer extends StatelessWidget {
  const RoundedContainer({
    Key? key,
    this.backgroundColor = AppColors.primary,
    this.child,
    this.radius = 4,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
  }) : super(key: key);
  final Widget? child;
  final Color backgroundColor;
  final double radius;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: child,
    );
  }
}
