import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/cubit/auth_cubit.dart';
import '../../../constants.dart';
import '../add%20record/add_record_screen.dart';
import '../home/home_screen.dart';
import '../records/records_screen.dart';
import '../settings/settings_screen.dart';
import '../stats/stats_screen.dart';

class MainAppScreen extends StatefulWidget {
  @override
  _MainAppScreenState createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  bool homeSelected = true;
  bool statsSelected = false;
  bool recordsSelected = false;
  bool settingSelected = false;
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    StatsScreen(),
    RecordsScreen(),
    SettingsScreen(),
  ];

  void selectIcon(String selectedIcon) {
    homeSelected = false;
    statsSelected = false;
    recordsSelected = false;
    settingSelected = false;
    if (selectedIcon == 'home') {
      homeSelected = true;
    }
    if (selectedIcon == 'stats') {
      statsSelected = true;
    }
    if (selectedIcon == 'records') {
      recordsSelected = true;
    }
    if (selectedIcon == 'settings') {
      settingSelected = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthCubit, AuthState>(
          buildWhen: (previous, current) => current is AuthSignedIn,
          builder: (_, state) {
            return _screens[_currentIndex];
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
            context: context,
            builder: (context) => AddRecord(),
          );
        },
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
                  buildNavButton(
                    isSelected: homeSelected,
                    setIndex: () {
                      setState(() {
                        _currentIndex = 0;
                        selectIcon("home");
                      });
                    },
                    icon: Icons.home_outlined,
                    iconSelected: Icons.home,
                    label: 'Home',
                  ),
                  buildNavButton(
                    isSelected: statsSelected,
                    setIndex: () {
                      setState(() {
                        _currentIndex = 1;
                        selectIcon("stats");
                      });
                    },
                    icon: Icons.pie_chart_outline,
                    iconSelected: Icons.pie_chart,
                    label: 'Stats',
                  ),
                ],
              ),
              Row(
                children: [
                  buildNavButton(
                    isSelected: recordsSelected,
                    setIndex: () {
                      setState(() {
                        _currentIndex = 2;
                        selectIcon("records");
                      });
                    },
                    icon: Icons.format_list_bulleted_rounded,
                    iconSelected: Icons.format_list_bulleted_rounded,
                    label: 'Records',
                  ),
                  buildNavButton(
                    isSelected: settingSelected,
                    setIndex: () {
                      setState(() {
                        _currentIndex = 3;
                        selectIcon("settings");
                      });
                    },
                    icon: Icons.settings_outlined,
                    iconSelected: Icons.settings,
                    label: 'Settings',
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  MaterialButton buildNavButton({
    required bool isSelected,
    required final VoidCallback setIndex,
    required final IconData icon,
    required final IconData iconSelected,
    required final String label,
  }) {
    return MaterialButton(
      highlightColor: Colors.white,
      minWidth: 80,
      onPressed: setIndex,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isSelected ? iconSelected : icon,
            size: 35,
            color: isSelected ? kAccentColor : Colors.grey,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: isSelected ? kAccentColor : Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}
