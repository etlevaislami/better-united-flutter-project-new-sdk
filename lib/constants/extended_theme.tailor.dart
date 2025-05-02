// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_element, unnecessary_cast

part of 'extended_theme.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$ExtendedThemeTailorMixin on ThemeExtension<ExtendedTheme> {
  TextStyle get h3;
  TextStyle get rules;
  TextStyle get bodyRegular;
  TextStyle get bodyRegularWhite;
  TextStyle get bodyBold;
  TextStyle get bodyBoldUnderline;
  TextStyle get bodyBoldUnderlinePrimary;
  TextStyle get labelBold;
  TextStyle get labelBoldItalic;
  TextStyle get labelRegular;
  TextStyle get labelBetType;
  TextStyle get labelSemiBold;
  TextStyle get titleH1;
  TextStyle get titleH2;
  TextStyle get titleH3;
  TextStyle get buttonPrimaryUnderline;
  TextStyle get titleH1White;

  @override
  ExtendedTheme copyWith({
    TextStyle? h3,
    TextStyle? rules,
    TextStyle? bodyRegular,
    TextStyle? bodyRegularWhite,
    TextStyle? bodyBold,
    TextStyle? bodyBoldUnderline,
    TextStyle? bodyBoldUnderlinePrimary,
    TextStyle? labelBold,
    TextStyle? labelBoldItalic,
    TextStyle? labelRegular,
    TextStyle? labelBetType,
    TextStyle? labelSemiBold,
    TextStyle? titleH1,
    TextStyle? titleH2,
    TextStyle? titleH3,
    TextStyle? buttonPrimaryUnderline,
    TextStyle? titleH1White,
  }) {
    return ExtendedTheme(
      bodyRegular: bodyRegular ?? this.bodyRegular,
    );
  }

  @override
  ExtendedTheme lerp(covariant ThemeExtension<ExtendedTheme>? other, double t) {
    if (other is! ExtendedTheme) return this as ExtendedTheme;
    return ExtendedTheme(
      bodyRegular: TextStyle.lerp(bodyRegular, other.bodyRegular, t)!,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ExtendedTheme &&
            const DeepCollectionEquality().equals(h3, other.h3) &&
            const DeepCollectionEquality().equals(rules, other.rules) &&
            const DeepCollectionEquality()
                .equals(bodyRegular, other.bodyRegular) &&
            const DeepCollectionEquality()
                .equals(bodyRegularWhite, other.bodyRegularWhite) &&
            const DeepCollectionEquality().equals(bodyBold, other.bodyBold) &&
            const DeepCollectionEquality()
                .equals(bodyBoldUnderline, other.bodyBoldUnderline) &&
            const DeepCollectionEquality().equals(
                bodyBoldUnderlinePrimary, other.bodyBoldUnderlinePrimary) &&
            const DeepCollectionEquality().equals(labelBold, other.labelBold) &&
            const DeepCollectionEquality()
                .equals(labelBoldItalic, other.labelBoldItalic) &&
            const DeepCollectionEquality()
                .equals(labelRegular, other.labelRegular) &&
            const DeepCollectionEquality()
                .equals(labelBetType, other.labelBetType) &&
            const DeepCollectionEquality()
                .equals(labelSemiBold, other.labelSemiBold) &&
            const DeepCollectionEquality().equals(titleH1, other.titleH1) &&
            const DeepCollectionEquality().equals(titleH2, other.titleH2) &&
            const DeepCollectionEquality().equals(titleH3, other.titleH3) &&
            const DeepCollectionEquality()
                .equals(buttonPrimaryUnderline, other.buttonPrimaryUnderline) &&
            const DeepCollectionEquality()
                .equals(titleH1White, other.titleH1White));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(h3),
      const DeepCollectionEquality().hash(rules),
      const DeepCollectionEquality().hash(bodyRegular),
      const DeepCollectionEquality().hash(bodyRegularWhite),
      const DeepCollectionEquality().hash(bodyBold),
      const DeepCollectionEquality().hash(bodyBoldUnderline),
      const DeepCollectionEquality().hash(bodyBoldUnderlinePrimary),
      const DeepCollectionEquality().hash(labelBold),
      const DeepCollectionEquality().hash(labelBoldItalic),
      const DeepCollectionEquality().hash(labelRegular),
      const DeepCollectionEquality().hash(labelBetType),
      const DeepCollectionEquality().hash(labelSemiBold),
      const DeepCollectionEquality().hash(titleH1),
      const DeepCollectionEquality().hash(titleH2),
      const DeepCollectionEquality().hash(titleH3),
      const DeepCollectionEquality().hash(buttonPrimaryUnderline),
      const DeepCollectionEquality().hash(titleH1White),
    );
  }
}

extension ExtendedThemeBuildContextProps on BuildContext {
  ExtendedTheme get extendedTheme => Theme.of(this).extension<ExtendedTheme>()!;
  TextStyle get h3 => extendedTheme.h3;
  TextStyle get rules => extendedTheme.rules;
  TextStyle get bodyRegular => extendedTheme.bodyRegular;
  TextStyle get bodyRegularWhite => extendedTheme.bodyRegularWhite;
  TextStyle get bodyBold => extendedTheme.bodyBold;
  TextStyle get bodyBoldUnderline => extendedTheme.bodyBoldUnderline;
  TextStyle get bodyBoldUnderlinePrimary =>
      extendedTheme.bodyBoldUnderlinePrimary;
  TextStyle get labelBold => extendedTheme.labelBold;
  TextStyle get labelBoldItalic => extendedTheme.labelBoldItalic;
  TextStyle get labelRegular => extendedTheme.labelRegular;
  TextStyle get labelBetType => extendedTheme.labelBetType;
  TextStyle get labelSemiBold => extendedTheme.labelSemiBold;
  TextStyle get titleH1 => extendedTheme.titleH1;
  TextStyle get titleH2 => extendedTheme.titleH2;
  TextStyle get titleH3 => extendedTheme.titleH3;
  TextStyle get buttonPrimaryUnderline => extendedTheme.buttonPrimaryUnderline;
  TextStyle get titleH1White => extendedTheme.titleH1White;
}
