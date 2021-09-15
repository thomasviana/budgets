import 'package:flutter/material.dart';

import 'package:budgets/presentation/screens/auth/auth_screen.dart';
import 'package:budgets/presentation/screens/intro/intro_screen.dart';
import 'package:budgets/presentation/screens/main/main_app_screen.dart';
import 'package:budgets/presentation/screens/profile/profile_screen.dart';
import 'package:budgets/presentation/screens/splash/splash_screen.dart';

class Routes {
  static const splash = '/';
  static const intro = '/intro';
  static const auth = '/auth';
  static const main = '/main';
  static const profile = '/profile';

  static Route routes(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return _buildRoute(SplashScreen.create);
      case intro:
        return _buildRoute(IntroScreen.create);
      case auth:
        return _buildRoute(AuthScreen.create);
      case main:
        return _buildRoute(MainAppScreen.create);
      case profile:
        return _buildRoute(ProfileSreen.create);
      default:
        throw Exception('Route does not exist');
    }
  }

  static MaterialPageRoute _buildRoute(Function build) {
    return MaterialPageRoute(builder: (context) => build(context));
  }
}
