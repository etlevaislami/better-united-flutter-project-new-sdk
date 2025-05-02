import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

import '../figma/colors.dart';
import '../figma/text_styles.dart';

part 'extended_theme.tailor.dart';

@TailorMixin()
class ExtendedTheme extends ThemeExtension<ExtendedTheme>
    with _$ExtendedThemeTailorMixin {
  @override
  final TextStyle h3 = AppTextStyles.h3;
  @override
  final TextStyle rules = AppTextStyles.rules;
  @override
  final TextStyle bodyRegular = AppTextStyles.bodyRegular;
  @override
  final TextStyle bodyRegularWhite = AppTextStyles.bodyRegular.copyWith(
    color: Colors.white,
  );
  @override
  final TextStyle bodyBold = AppTextStyles.bodyBold;
  @override
  final TextStyle bodyBoldUnderline = AppTextStyles.bodyBoldUnderline;
  @override
  final TextStyle bodyBoldUnderlinePrimary =
      AppTextStyles.bodyBoldUnderline.copyWith(
    color: AppColors.primary,
    decorationThickness: 3,
  );
  @override
  final TextStyle labelBold = AppTextStyles.labelBold;
  @override
  final labelBoldItalic = AppTextStyles.labelBoldItalic;
  @override
  final TextStyle labelRegular = AppTextStyles.labelRegular;
  @override
  final TextStyle labelBetType = AppTextStyles.labelBetType;
  @override
  final TextStyle labelSemiBold = AppTextStyles.labelSemiBold;
  @override
  final TextStyle titleH1 = AppTextStyles.titleH1;
  @override
  final TextStyle titleH2 = AppTextStyles.titleH2;
  @override
  final TextStyle titleH3 = AppTextStyles.titleH3;
  @override
  final TextStyle buttonPrimaryUnderline = AppTextStyles.buttonPrimaryUnderline;

  @override
  final TextStyle titleH1White =
      AppTextStyles.titleH1.copyWith(color: Colors.white);

  ExtendedTheme({required TextStyle bodyRegular});
}
