import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/transactions/domain.dart';
import '../../../core/user/domain.dart';
import '../../core/auth/auth_bloc.dart';
import '../../core/date/date_bloc.dart';
import '../../core/settings/settings_bloc.dart';
import '../../core/transactions/transactions_bloc.dart';
import 'components/budgets_info_widget.dart';
import 'components/home_app_bar.dart';
import 'components/home_header.dart';
import 'components/last_records_widget.dart';
import 'components/spending_chart_widget.dart';
import 'home_bloc/home_screen_bloc.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeScreenBloc bloc;
  late DateBloc dateBloc;
  late SettingsBloc settingsBloc;
  late UserEntity user;
  late List<Transaction> transactions;

  @override
  void initState() {
    super.initState();
    dateBloc = context.read<DateBloc>();
    settingsBloc = context.read<SettingsBloc>();
    user = context.read<AuthBloc>().state.userEntity;
    transactions = context.read<TransactionsBloc>().state.transactions;
    context.read<HomeScreenBloc>().add(
          HomeScreenInfoRequested(
            user: user,
            transactions: transactions,
            budgets: settingsBloc.state.budgets,
            date: dateBloc.state.date,
          ),
        );
  }

  List<Widget> homeWidgets = [
    LastRecordsWidget(),
    BudgetsInfoWidget(),
    SpendingChart(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          HomeAppBar(),
          HomeHeader(),
          SliverToBoxAdapter(child: SizedBox(height: 16)),
          ...homeWidgets,
        ],
      ),
    );
  }
}
