import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../dependency_injection.dart';
import '../../resources/colors.dart';
import '../home/cubit/home_screen_cubit.dart';
import '../home/home_screen.dart';
import '../settings/cubit/settings_screen_cubit.dart';
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
  int selectedPageIndex = 0;

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

  Widget _buildPage(BuildContext context, int selectedPageIndex) {
    switch (selectedPageIndex) {
      case 0:
        return BlocProvider(
          create: (context) => sl<HomeScreenCubit>(),
          child: HomeScreen(),
        );
      case 1:
        return StatsScreen();
      case 2:
        return StatsScreen();
      case 3:
        return BlocProvider(
          create: (context) => sl<SettingsScreenCubit>(),
          child: SettingsScreen(),
        );

      default:
        return Placeholder(color: Colors.black);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: _buildPage(context, selectedPageIndex),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: () {
      //     showModalBottomSheet(
      //       backgroundColor: Colors.transparent,
      //       isScrollControlled: true,
      //       context: context,
      //       builder: (context) => StatsScreen(),
      //     );
      //   },
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildNavButton(
                isSelected: homeSelected,
                onPressed: () {
                  setState(() {
                    selectedPageIndex = 0;
                    selectIcon('home');
                  });
                },
                icon: Icons.home_outlined,
                iconSelected: Icons.home,
                label: 'Home',
              ),
              buildNavButton(
                isSelected: statsSelected,
                onPressed: () {
                  setState(() {
                    selectedPageIndex = 1;
                    selectIcon('stats');
                  });
                },
                icon: Icons.pie_chart_outline,
                iconSelected: Icons.pie_chart,
                label: 'Stats',
              ),
              buildNavButton(
                isSelected: recordsSelected,
                onPressed: () {
                  setState(() {
                    selectedPageIndex = 2;
                    selectIcon('records');
                  });
                },
                icon: Icons.format_list_bulleted_rounded,
                iconSelected: Icons.format_list_bulleted_rounded,
                label: 'Records',
              ),
              buildNavButton(
                isSelected: settingSelected,
                onPressed: () {
                  setState(() {
                    selectedPageIndex = 3;
                    selectIcon('settings');
                  });
                },
                icon: Icons.settings_outlined,
                iconSelected: Icons.settings,
                label: 'Settings',
              ),
            ],
          ),
        ),
      ),
    );
  }

  MaterialButton buildNavButton({
    required bool isSelected,
    required final VoidCallback onPressed,
    required final IconData icon,
    required final IconData iconSelected,
    required final String label,
  }) {
    return MaterialButton(
      highlightColor: Colors.white,
      minWidth: 80,
      onPressed: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isSelected ? iconSelected : icon,
            size: 35,
            color:
                isSelected ? AppColors.primaryColor : AppColors.greySecondary,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color:
                  isSelected ? AppColors.primaryColor : AppColors.greySecondary,
            ),
          )
        ],
      ),
    );
  }
}
