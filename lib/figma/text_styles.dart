import 'package:flutter/material.dart';
import 'package:flutter_better_united/figma/shadows.dart';

class AppTextStyles {
  static const h3 = TextStyle(
    fontFamily: "Open Sans",
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.italic,
    fontSize: 16,
    decoration: TextDecoration.none,
    letterSpacing: 0,
    height: 0,
    leadingDistribution: TextLeadingDistribution.even,
  );

  static const rules = TextStyle(
    fontFamily: "Bedug",
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    fontSize: 10,
    decoration: TextDecoration.none,
    letterSpacing: 0,
    height: 0,
    leadingDistribution: TextLeadingDistribution.even,
  );

  static const bodyRegular = TextStyle(
    fontFamily: "Open Sans",
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    fontSize: 14,
    decoration: TextDecoration.none,
    letterSpacing: 0,
    height: 0,
    color: Colors.white,
    leadingDistribution: TextLeadingDistribution.even,
  );

  static const bodyBold = TextStyle(
    fontFamily: "Open Sans",
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
    fontSize: 14,
    decoration: TextDecoration.none,
    letterSpacing: 0,
    height: 0,
    leadingDistribution: TextLeadingDistribution.even,
  );

  static const bodyBoldUnderline = TextStyle(
    fontFamily: "Open Sans",
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
    fontSize: 14,
    decoration: TextDecoration.underline,
    letterSpacing: 0,
    height: 0,
    leadingDistribution: TextLeadingDistribution.even,
  );

  static const labelBold = TextStyle(
      fontFamily: "Open Sans",
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.normal,
      fontSize: 12,
      decoration: TextDecoration.none,
      letterSpacing: 0,
      height: 0,
      leadingDistribution: TextLeadingDistribution.even,
      shadows: AppShadows.textShadows);

  static const labelBoldItalic = TextStyle(
    fontFamily: "Open Sans",
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.italic,
    fontSize: 12,
    decoration: TextDecoration.none,
    letterSpacing: 0,
    height: 0,
    leadingDistribution: TextLeadingDistribution.even,
  );

  static const labelRegular = TextStyle(
    fontFamily: "Open Sans",
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    fontSize: 12,
    decoration: TextDecoration.none,
    letterSpacing: 0,
    height: 0,
    leadingDistribution: TextLeadingDistribution.even,
  );

  static const labelBetType = TextStyle(
    fontFamily: "Open Sans",
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
    fontSize: 11,
    decoration: TextDecoration.none,
    letterSpacing: 0,
    height: 1.8181818181818181,
    leadingDistribution: TextLeadingDistribution.even,
  );

  static const labelSemiBold = TextStyle(
    fontFamily: "Open Sans",
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
    fontSize: 12,
    decoration: TextDecoration.none,
    letterSpacing: 0,
    height: 0,
    leadingDistribution: TextLeadingDistribution.even,
  );

  static const titleH1 = TextStyle(
    fontFamily: "Open Sans",
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.italic,
    fontSize: 22,
    decoration: TextDecoration.none,
    letterSpacing: 0,
    height: 0,
    leadingDistribution: TextLeadingDistribution.even,
  );

  static const titleH2 = TextStyle(
      fontFamily: "Open Sans",
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.italic,
      fontSize: 18,
      decoration: TextDecoration.none,
      letterSpacing: 0,
      height: 0,
      leadingDistribution: TextLeadingDistribution.even,
      shadows: AppShadows.textShadows);

  static const titleH3 = TextStyle(
    fontFamily: "Open Sans",
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.italic,
    fontSize: 16,
    decoration: TextDecoration.none,
    letterSpacing: 0,
    height: 0,
    leadingDistribution: TextLeadingDistribution.even,
  );

  static const buttonPrimaryUnderline = TextStyle(
    fontFamily: "Open Sans",
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.italic,
    fontSize: 14,
    decoration: TextDecoration.underline,
    letterSpacing: 0,
    height: 0,
    leadingDistribution: TextLeadingDistribution.even,
  );

  static const textStyle1 = TextStyle(
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.w700,
      color: Colors.white);

  static const textStyle2 = TextStyle(
      fontSize: 14, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic);

  static const textStyle3 = TextStyle(
      fontSize: 14,
      color: Colors.white,
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.italic,
      shadows: [
        Shadow(
          color: Color(0x00000080),
          offset: Offset(0, 2),
          blurRadius: 16,
        ),
      ]);

  static const TextStyle textStyle4 = TextStyle(
    fontSize: 22,
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.bold,
  );

  static const textStyle5 =
      TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white);

  static const textStyle6 = TextStyle(fontSize: 17, color: Colors.white);

  static const textStyle7 = TextStyle(
    color: Colors.white,
    fontSize: 10,
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.bold,
  );

  static const textStyle8 = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      shadows: [
        Shadow(
          color: Color(0x00000080),
          offset: Offset(0, 2),
          blurRadius: 16,
        ),
      ],
      fontSize: 12);

  static const labelSemiBoldItalic = TextStyle(
    fontFamily: "Open Sans",
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.italic,
    fontSize: 12,
    decoration: TextDecoration.none,
    letterSpacing: 0,
    height: 0,
    leadingDistribution: TextLeadingDistribution.even,
  );

  AppTextStyles._();
}
