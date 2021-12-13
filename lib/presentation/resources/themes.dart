import 'package:flutter/material.dart';

import 'colors.dart';

class AppTheme {
  AppTheme._();

  static const ColorScheme _colorSchemeLight = ColorScheme.light(
    background: AppColors.greyBackground,
    primary: AppColors.primaryColor,
    primaryVariant: AppColors.primaryVariant,
    secondary: AppColors.greyPrimary,
    secondaryVariant: AppColors.greySecondary,
  );

  static final TextTheme _textThemeBlack = TextTheme()
      .copyWith()
      .apply(fontFamily: 'Quicksand', bodyColor: AppColors.textColor);

  static ThemeData get light {
    return ThemeData.from(
      colorScheme: _colorSchemeLight,
      textTheme: _textThemeBlack,
    ).copyWith(
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}
