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

  final iconTheme = IconThemeData(color: AppColors.white);
  final listTileTheme =
      ListTileTheme(child: Text(''), iconColor: _colorSchemeLight.surface);

  static final appBarTheme = AppBarTheme(
    color: AppColors.white,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 16,
    ),
    iconTheme: IconThemeData(color: AppColors.primaryColor),
    elevation: 0,
  );

  static ThemeData get light {
    return ThemeData.from(
      colorScheme: _colorSchemeLight,
      textTheme: _textThemeBlack,
    ).copyWith(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      iconTheme: IconThemeData(color: Colors.white, size: 20),
      appBarTheme: appBarTheme,
      listTileTheme: ListTileThemeData(tileColor: AppColors.white),
    );
  }
}
