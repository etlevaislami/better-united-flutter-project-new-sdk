import 'package:flutter/material.dart';

class GreyColorFiltered extends StatelessWidget {
  const GreyColorFiltered({Key? key, this.child, this.isEnabled = true})
      : super(key: key);
  final bool isEnabled;
  final Widget? child;

  static const ColorFilter greyFilter = ColorFilter.matrix(<double>[
    0.2126, 0.7152, 0.0722, 0, 0, //
    0.2126, 0.7152, 0.0722, 0, 0,
    0.2126, 0.7152, 0.0722, 0, 0,
    0, 0, 0, 1, 0,
  ]);

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: isEnabled
          ? greyFilter
          : const ColorFilter.mode(Colors.transparent, BlendMode.overlay),
      child: child,
    );
  }
}
