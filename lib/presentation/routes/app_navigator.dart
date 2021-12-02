import 'package:flutter/material.dart';

class AppNavigator {
  AppNavigator._();

  static const ROUTE_SPLASH_PAGE = Navigator.defaultRouteName;
  static const ROUTE_INTRO_PAGE = '/intro';
  static const ROUTE_AUTH_PAGE = '/auth';
  static const ROUTE_MAIN_PAGE = '/main';

  // Settings
  static const ROUTE_PROFILE_PAGE = '/profile';

  static void navigateBack(BuildContext context) => Navigator.pop(context);

  static void closeFlow(BuildContext context) {
    final navigator = Navigator.of(context, rootNavigator: true);
    while (navigator.canPop()) {
      navigator.maybePop();
    }
  }

  static void navigateToIntroPage(BuildContext context) {
    Navigator.pushNamed(context, ROUTE_INTRO_PAGE);
  }

  static void navigateToAuthPage(BuildContext context) {
    Navigator.pushReplacementNamed(context, ROUTE_AUTH_PAGE);
  }

  static void navigateToMainPage(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
        context, ROUTE_MAIN_PAGE, (route) => false);
  }

  static void navigateBackToMainPage(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
        context, ROUTE_MAIN_PAGE, (route) => false);
  }

  static void navigateToProfilePage(BuildContext context) {
    Navigator.pushNamed(context, ROUTE_PROFILE_PAGE);
  }
}