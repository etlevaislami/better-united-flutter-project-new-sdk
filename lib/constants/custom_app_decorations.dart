import 'package:flutter/material.dart';
import 'package:flutter_better_united/constants/app_colors.dart';

class CustomAppDecorations {
  static Gradient bottomTransparentGradient() {
    return LinearGradient(

      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: const [0, 0.7, 0.9, 1],
      colors: <Color>[
        Colors.black,
        AppColors.greenShadeGradient1.withOpacity(0.6),
        AppColors.greenShadeGradient1.withOpacity(0.2),
        Colors.transparent,
      ],
    );
  }
}
