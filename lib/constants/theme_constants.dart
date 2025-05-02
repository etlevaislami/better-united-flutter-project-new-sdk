import 'package:flutter/material.dart';
import 'package:flutter_better_united/figma/text_styles.dart';

import 'app_colors.dart';
import 'extended_theme.dart';

ThemeData darkTheme = ThemeData(
  // Define the default font family.
  fontFamily: "Open Sans",
  hintColor: AppColors.hint,
  useMaterial3: false,
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Color(0xff9AE343),
  ),
  primaryColor: AppColors.primaryColor,
  primarySwatch: MaterialColor(AppColors.primaryColor.value, const {
    50: Color(0xffF3F8EB),
    100: Color(0xffE1ECCE),
    200: Color(0xffCDE0AD),
    300: Color(0xffB9D48C),
    400: Color(0xffAACA73),
    500: Color(0xff9BC15A),
    600: Color(0xff93BB52),
    700: Color(0xff89B348),
    800: Color(0xff7FAB3F),
    900: Color(0xff6D9E2E),
  }),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.primaryColor,
    toolbarHeight: 0,
    elevation: 0,
  ),
  highlightColor: AppColors.primaryColor,
  iconTheme: const IconThemeData(color: Colors.white),
  scaffoldBackgroundColor: const Color(0xff1D1D1D),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      textStyle: const TextStyle(
          fontSize: 16.0,
          color: AppColors.forgedSteel,
          fontWeight: FontWeight.bold),
    ),
  ),

  // Define the default `TextTheme`. Use this to specify the default
  // text styling for headlines, titles, bodies of text, and more.
  textTheme: const TextTheme(
    titleMedium: TextStyle(
        fontSize: 16.0, fontWeight: FontWeight.w700, color: Colors.white),
    titleLarge: TextStyle(
        fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white),
    titleSmall: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
      color: Colors.white,
    ),
    labelSmall: TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.bold,
      color: AppColors.forgedSteel,
    ),
    labelMedium: TextStyle(
        fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.white),
    bodyMedium: AppTextStyles.bodyRegular,
    bodySmall: TextStyle(
      fontSize: 12.0,
      color: AppColors.grey400,
      fontWeight: FontWeight.normal,
    ),
    displaySmall: TextStyle(
      fontSize: 12.0,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
  ),
  extensions: <ThemeExtension<dynamic>>[
    ExtendedTheme(bodyRegular: AppTextStyles.bodyRegular),
  ],
);
