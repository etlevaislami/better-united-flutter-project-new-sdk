import 'package:flutter/material.dart';

class AppShadows {
  static const dropShadowText = BoxShadow(
    color: Color(0x80000000),
    offset: Offset(0, 2),
    blurRadius: 16,
    spreadRadius: 0,
  );

  static const dropShadowButton = BoxShadow(
    color: Color(0x80000000),
    offset: Offset(0, 2),
    blurRadius: 8,
    spreadRadius: 0,
  );

  static const outerGlowCard = BoxShadow(
    color: Color(0x3d9ae343),
    offset: Offset(0, 0),
    blurRadius: 24,
    spreadRadius: 0,
  );

  static const outerGlowText = BoxShadow(
    color: Color(0x8f9ae343),
    offset: Offset(0, 0),
    blurRadius: 16,
    spreadRadius: 0,
  );

  static const outerGlowLabel = BoxShadow(
    color: Color(0xff9ae244),
    offset: Offset(0, 0),
    blurRadius: 8,
    spreadRadius: 0,
  );

  AppShadows._();
}
