import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../di/dependency_injection.dart';
import '../../core/date/date_bloc.dart';
import '../../resources/colors.dart';
import '../../routes/app_navigator.dart';
import '../home/home_bloc/home_screen_bloc.dart';
import '../home/home_screen.dart';
import '../settings/cubit/settings_screen_cubit.dart';
import '../settings/settings_screen.dart';
import '../stats/stats_screen.dart';
import '../transactions/transactions_screen.dart';
import 'main_app_cubit/main_screen_cubit.dart';

class MainAppScreen extends StatefulWidget {
  @override
  _MainAppScreenState createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  late DateBloc dateBloc;
  late MainScreenCubit cubit;
  @override
  void initState() {
    dateBloc = context.read<DateBloc>();
    cubit = context.read<MainScreenCubit>();
    super.initState();
  }

  Widget _buildPage(BuildContext context, int selectedPageIndex) {
    switch (selectedPageIndex) {
      case 0:
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => sl<HomeScreenBloc>(),
            ),
          ],
          child: HomeScreen(),
        );
      case 1:
        return StatsScreen();
      case 2:
        return TransactionsScreen();
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
    return BlocBuilder<MainScreenCubit, MainScreenState>(
      builder: (context, state) {
        return Scaffold(
          body: _buildPage(context, state.selectedPageIndex ?? 0),
          bottomNavigationBar: BottomAppBar(
            shape: CircularNotchedRectangle(),
            notchMargin: 10,
            child: SizedBox(
              height: 60,
              child: Row(
                children: [
                  NavBarButton(
                    isSelected: state.homeSelected,
                    onPressed: () {
                      cubit.onSelectedPageIndexChanged(0);
                    },
                    icon: Icons.home_outlined,
                    iconSelected: Icons.home,
                  ),
                  NavBarButton(
                    isSelected: state.statsSelected,
                    onPressed: () {
                      cubit.onSelectedPageIndexChanged(1);
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
                    isSelected: state.recordsSelected,
                    onPressed: () {
                      cubit.onSelectedPageIndexChanged(2);
                    },
                    icon: Icons.format_list_bulleted_rounded,
                    iconSelected: Icons.format_list_bulleted_rounded,
                  ),
                  NavBarButton(
                    isSelected: state.settingSelected,
                    onPressed: () {
                      cubit.onSelectedPageIndexChanged(3);
                    },
                    icon: Icons.settings_outlined,
                    iconSelected: Icons.settings,
                  ),
                ],
              ),
            ),
          ),
        );
      },
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
