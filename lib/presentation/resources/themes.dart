import 'dart:io' show Platform;

import 'package:flutter/material.dart';

import 'colors.dart';

class AppTheme {
  AppTheme._();

  static const ColorScheme _colorSchemeLight = ColorScheme.light(
    background: AppColors.greyBackground,
    primary: AppColors.primaryColor,
    primaryContainer: AppColors.primaryVariant,
    secondary: AppColors.primaryColor,
    secondaryContainer: AppColors.greySecondary,
  );

  final iconTheme = IconThemeData(color: AppColors.white);
  final listTileTheme =
      ListTileTheme(child: Text(''), iconColor: _colorSchemeLight.surface);

  static final appBarTheme = Platform.isIOS
      ? AppBarTheme(
          color: AppColors.white,
          titleTextStyle: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          iconTheme: IconThemeData(color: AppColors.primaryColor),
          elevation: 0,
        )
      : AppBarTheme(
          color: AppColors.primaryColor,
        );

  static ThemeData get light {
    return ThemeData(fontFamily: 'Nunito').copyWith(
      colorScheme: _colorSchemeLight,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      iconTheme: IconThemeData(color: Colors.white, size: 20),
      appBarTheme: appBarTheme,
      listTileTheme: ListTileThemeData(tileColor: AppColors.white),
    );
  }
}
