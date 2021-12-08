import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuple/tuple.dart';

import '../../resources/colors.dart';
import 'components/accounts_tab.dart';
import 'components/body.dart';
import 'components/budgets_tab.dart';
import 'cubit/home_screen_cubit.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeScreenCubit cubit;
  final List<Tuple2> _tabs = [
    Tuple2('Accounts', AccountsTab()),
    Tuple2('Budgets', BudgetsTab()),
  ];

  @override
  void initState() {
    super.initState();
    cubit = context.read<HomeScreenCubit>();
    cubit.init();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenCubit, HomeScreenState>(
      builder: _buildState,
    );
  }

  Widget _buildState(BuildContext context, HomeScreenState state) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        backgroundColor: AppColors.primayColor,
        body: Body(tabs: _tabs),
      ),
    );
  }
}
