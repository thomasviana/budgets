import 'package:budgets/constants.dart';
import 'package:budgets/presentation/screens/home/home_screen.dart';
import 'package:budgets/presentation/screens/records/records_screen.dart';
import 'package:budgets/presentation/screens/settings/settings_screen.dart';
import 'package:budgets/presentation/screens/stats/stats_screen.dart';
import 'package:flutter/material.dart';

class MainAppScreen extends StatefulWidget {
  static const routeName = '/';
  @override
  _MainAppScreenState createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  int _currentIndex = 0;

  List _screens = [
    HomeScreen(),
    StatsScreen(),
    RecordsScreen(),
    SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  MaterialButton(
                    highlightColor: Colors.white,
                    minWidth: 80,
                    onPressed: () {
                      setState(() {
                        _currentIndex = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _currentIndex == 0 ? Icons.home : Icons.home_outlined,
                          size: 35,
                          color:
                              _currentIndex == 0 ? kAccentColor : Colors.grey,
                        ),
                        Text(
                          'Home',
                          style: TextStyle(
                            fontSize: 10,
                            color:
                                _currentIndex == 0 ? kAccentColor : Colors.grey,
                          ),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    highlightColor: Colors.white,
                    minWidth: 80,
                    onPressed: () {
                      setState(() {
                        _currentIndex = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _currentIndex == 1
                              ? Icons.pie_chart
                              : Icons.pie_chart_outline,
                          size: 30,
                          color:
                              _currentIndex == 1 ? kAccentColor : Colors.grey,
                        ),
                        Text(
                          'Stats',
                          style: TextStyle(
                            fontSize: 10,
                            color:
                                _currentIndex == 1 ? kAccentColor : Colors.grey,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  MaterialButton(
                    highlightColor: Colors.white,
                    minWidth: 80,
                    onPressed: () {
                      setState(() {
                        _currentIndex = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.format_list_bulleted_rounded,
                          size: 30,
                          color:
                              _currentIndex == 2 ? kAccentColor : Colors.grey,
                        ),
                        Text(
                          'Records',
                          style: TextStyle(
                            fontSize: 10,
                            color:
                                _currentIndex == 2 ? kAccentColor : Colors.grey,
                          ),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    highlightColor: Colors.white,
                    minWidth: 80,
                    onPressed: () {
                      setState(() {
                        _currentIndex = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _currentIndex == 3
                              ? Icons.settings
                              : Icons.settings_outlined,
                          size: 30,
                          color:
                              _currentIndex == 3 ? kAccentColor : Colors.grey,
                        ),
                        Text(
                          'Settings',
                          style: TextStyle(
                            fontSize: 10,
                            color:
                                _currentIndex == 3 ? kAccentColor : Colors.grey,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
