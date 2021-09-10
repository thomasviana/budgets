import 'package:budgets/presentation/screens/auth/auth_screen.dart';
import 'package:budgets/presentation/screens/main/main_app_screen.dart';
import 'package:budgets/src/ui/intro_screen.dart';
import 'package:budgets/src/ui/splash_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static const splash = '/';
  static const intro = '/intro';
  static const auth = '/auth';
  static const main = '/main';

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
      default:
        throw Exception('Route does not exist');
    }
  }

  static MaterialPageRoute _buildRoute(Function build) {
    return MaterialPageRoute(builder: (context) => build(context));
  }
}
