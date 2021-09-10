import 'package:budgets/presentation/screens/auth/auth_screen.dart';
import 'package:budgets/presentation/screens/home/home_screen.dart';
import 'package:budgets/src/bloc/cubit/auth_cubit.dart';
import 'package:budgets/src/navigation/routes.dart';
import 'package:budgets/src/ui/intro_screen.dart';
import 'package:budgets/src/ui/splash_screen.dart';
import 'package:flutter/material.dart';

import 'package:budgets/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final _navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  static Widget create() {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSignedOut) {
          _navigatorKey.currentState
              ?.pushNamedAndRemoveUntil(Routes.intro, (route) => false);
        } else if (state is AuthSignedIn) {
          _navigatorKey.currentState
              ?.pushNamedAndRemoveUntil(Routes.main, (route) => false);
        }
      },
      child: MyApp(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      title: 'Budgets App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: kBackgroundColor,
        primaryColor: kPrimayColor,
        accentColor: kAccentColor,
        textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
      ),
      onGenerateRoute: Routes.routes,
      // home: IntroScreen.create(context),
      // routes: {
      //   AuthScreen.routeName: (ctx) => AuthScreen(),
      //   MainAppScreen.routeName: (ctx) => MainAppScreen(),
      //   HomeScreen.routeName: (ctx) => HomeScreen(),
      //   StatsScreen.routeName: (ctx) => StatsScreen(),
      //   RecordsScreen.routeName: (ctx) => RecordsScreen(),
      //   SettingsScreen.routeName: (ctx) => SettingsScreen(),
      // },
    );
  }
}
