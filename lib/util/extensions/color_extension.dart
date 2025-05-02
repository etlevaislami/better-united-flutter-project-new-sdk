import 'dart:math';

import 'package:flutter/widgets.dart';

extension ColorExtension on Color {
  Color increaseColorSaturation(double increment) {
    var hslColor = HSLColor.fromColor(this);
    var newValue = min(max(hslColor.saturation + increment, 0.0), 1.0);
    return hslColor.withSaturation(newValue).toColor();
  }

  Color increaseColorLightness(double increment) {
    var hslColor = HSLColor.fromColor(this);
    var newValue = min(max(hslColor.lightness + increment, 0.0), 1.0);
    return hslColor.withLightness(newValue).toColor();
  }

  Color increaseColorHue(double increment) {
    var hslColor = HSLColor.fromColor(this);
    var newValue = min(max(hslColor.lightness + increment, 0.0), 360.0);
    return hslColor.withHue(newValue).toColor();
  }
}
