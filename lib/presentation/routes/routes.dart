import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../dependency_injection.dart';
import '../../domain/categories.dart';
import '../screens/auth/auth_screen.dart';
import '../screens/auth/cubit/auth_screen_cubit.dart';
import '../screens/categories/categories_cubit/categories_screen_cubit.dart';
import '../screens/categories/categories_screen.dart';
import '../screens/categories/sub_categories_cubit/sub_categories_screen_cubit.dart';
import '../screens/categories/sub_categories_screen.dart';
import '../screens/intro/intro_screen.dart';
import '../screens/main/main_app_screen.dart';
import '../screens/profile/cubit/profile_screen_cubit.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/splash/splash_screen.dart';
import 'app_navigator.dart';

class Routes {
  static Route routes(RouteSettings settings) {
    switch (settings.name) {
      case AppNavigator.ROUTE_SPLASH_PAGE:
        return _buildRoute(
          settings,
          SplashScreen(),
        );
      case AppNavigator.ROUTE_INTRO_PAGE:
        return _buildRoute(
          settings,
          IntroScreen(),
        );
      case AppNavigator.ROUTE_AUTH_PAGE:
        return _buildRoute(
          settings,
          BlocProvider(
            create: (context) => sl<AuthScreenCubit>(),
            child: AuthScreen(),
          ),
        );
      case AppNavigator.ROUTE_MAIN_PAGE:
        return _buildRoute(
          settings,
          MainAppScreen(),
        );
      case AppNavigator.ROUTE_PROFILE_PAGE:
        return _buildRoute(
          settings,
          BlocProvider(
            create: (context) => sl<ProfileScreenCubit>(),
            child: ProfileSreen(),
          ),
        );
      case AppNavigator.ROUTE_CATEGORIES_PAGE:
        return _buildRoute(
          settings,
          BlocProvider(
            create: (context) => sl<CategoriesScreenCubit>(),
            child: CategoriesScreen(),
          ),
        );
      case AppNavigator.ROUTE_SUB_CATEGORIES_PAGE:
        final category = settings.arguments as Category;
        return _buildRoute(
          settings,
          BlocProvider(
            create: (context) => sl<SubCategoriesScreenCubit>(),
            child: SubCategoriesScreen(category: category),
          ),
        );
      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }

  static MaterialPageRoute _buildRoute(
    RouteSettings settings,
    Widget screen,
  ) {
    return MaterialPageRoute(
      settings: settings,
      builder: (context) => screen,
    );
  }
}
