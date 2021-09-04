import 'package:budgets/constants.dart';
import 'package:budgets/screens/budgets/budgets_screen.dart';
import 'package:budgets/screens/home/home_screen.dart';
import 'package:budgets/screens/main_app_screen.dart';
import 'package:budgets/screens/records/records_screen.dart';
import 'package:budgets/screens/settings/settings_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
      home: MainAppScreen(),
      routes: {
        HomeScreen.routeName: (ctx) => HomeScreen(),
        BudgetsScreen.routeName: (ctx) => BudgetsScreen(),
        RecordsScreen.routeName: (ctx) => RecordsScreen(),
        SettingScreen.routeName: (ctx) => SettingScreen(),
      },
    );
  }
}
