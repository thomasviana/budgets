import 'package:flutter/material.dart';

import '../screens/auth/auth_screen.dart';
import '../screens/intro/intro_screen.dart';
import '../screens/main/main_app_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/splash/splash_screen.dart';

class Routes {
  static const splash = '/';
  static const intro = '/intro';
  static const auth = '/auth';
  static const main = '/main';
  static const profile = '/profile';

  static Route routes(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return _buildRoute(SplashScreen());
      case intro:
        return _buildRoute(IntroScreen());
      case auth:
        return _buildRoute(AuthScreen());
      case main:
        return _buildRoute(MainAppScreen());
      case profile:
        return _buildRoute(ProfileSreen());
      default:
        throw Exception('Route does not exist');
    }
  }

  static MaterialPageRoute _buildRoute(Widget screen) {
    return MaterialPageRoute(builder: (context) => screen);
  }
}
