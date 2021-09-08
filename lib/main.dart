import 'package:budgets/presentation/screens/auth/auth_screen.dart';
import 'package:budgets/presentation/screens/home/home_screen.dart';
import 'package:flutter/material.dart';

import 'package:budgets/constants.dart';
import 'package:budgets/presentation/screens/main/main_app_screen.dart';
import 'package:budgets/presentation/screens/records/records_screen.dart';
import 'package:budgets/presentation/screens/settings/settings_screen.dart';
import 'package:budgets/presentation/screens/stats/stats_screen.dart';

void main() {
  runApp(AppView());
}

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Budgets App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: kBackgroundColor,
        primaryColor: kPrimayColor,
        accentColor: kAccentColor,
        textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
      ),
      home: AuthScreen(),
      routes: {
        MainAppScreen.routeName: (ctx) => MainAppScreen(),
        HomeScreen.routeName: (ctx) => HomeScreen(),
        StatsScreen.routeName: (ctx) => StatsScreen(),
        RecordsScreen.routeName: (ctx) => RecordsScreen(),
        SettingsScreen.routeName: (ctx) => SettingsScreen(),
      },
    );
  }
}
