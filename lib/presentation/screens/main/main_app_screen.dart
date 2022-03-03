import 'package:budgets/presentation/routes/app_navigator.dart';
import 'package:budgets/presentation/screens/home/home_bloc/home_screen_bloc.dart';
import 'package:budgets/presentation/screens/transactions/transactions_bloc/transactions_screen_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../di/dependency_injection.dart';
import '../../resources/colors.dart';
import '../home/home_screen.dart';
import '../settings/cubit/settings_screen_cubit.dart';
import '../settings/settings_screen.dart';
import '../stats/stats_screen.dart';
import '../transactions/transactions_screen.dart';

class MainAppScreen extends StatefulWidget {
  @override
  _MainAppScreenState createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  final _transactionsBloc = sl<TransactionsScreenBloc>()
    ..add(GetUserTransactions());

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
    if (selectedIcon == 'transactions') {
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
          create: (context) => sl<HomeScreenBloc>(),
          child: HomeScreen(),
        );
      case 1:
        return StatsScreen();
      case 2:
        return BlocProvider.value(
          value: _transactionsBloc,
          child: TransactionsScreen(),
        );
      case 3:
        return BlocProvider(
          create: (context) => sl<SettingsScreenCubit>(),
          child: SettingsScreen(),
        );

      default:
        return Placeholder(color: AppColors.black);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPage(context, selectedPageIndex),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: SizedBox(
          height: 60,
          child: Row(
            children: [
              NavBarButton(
                isSelected: homeSelected,
                onPressed: () {
                  setState(() {
                    selectedPageIndex = 0;
                    selectIcon('home');
                  });
                },
                icon: Icons.home_outlined,
                iconSelected: Icons.home,
              ),
              NavBarButton(
                isSelected: statsSelected,
                onPressed: () {
                  setState(() {
                    selectedPageIndex = 1;
                    selectIcon('stats');
                  });
                },
                icon: Icons.pie_chart_outline,
                iconSelected: Icons.pie_chart,
              ),
              Expanded(
                child: RawMaterialButton(
                  padding: const EdgeInsets.all(8.0),
                  fillColor: AppColors.primaryColor,
                  shape: CircleBorder(),
                  child: Icon(
                    Icons.add,
                    color: AppColors.white,
                    size: 28,
                  ),
                  onPressed: () =>
                      AppNavigator.navigateToEditTransactionPage(context),
                ),
              ),
              NavBarButton(
                isSelected: recordsSelected,
                onPressed: () {
                  setState(() {
                    selectedPageIndex = 2;
                    selectIcon('transactions');
                  });
                },
                icon: Icons.format_list_bulleted_rounded,
                iconSelected: Icons.format_list_bulleted_rounded,
              ),
              NavBarButton(
                isSelected: settingSelected,
                onPressed: () {
                  setState(() {
                    selectedPageIndex = 3;
                    selectIcon('settings');
                  });
                },
                icon: Icons.settings_outlined,
                iconSelected: Icons.settings,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NavBarButton extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onPressed;
  final IconData icon;
  final IconData iconSelected;
  const NavBarButton({
    Key? key,
    required this.isSelected,
    required this.onPressed,
    required this.icon,
    required this.iconSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MaterialButton(
        highlightColor: AppColors.white,
        splashColor: AppColors.white,
        onPressed: onPressed,
        child: Icon(
          isSelected ? iconSelected : icon,
          size: 32,
          color: isSelected ? AppColors.primaryColor : AppColors.greySecondary,
        ),
      ),
    );
  }
}
