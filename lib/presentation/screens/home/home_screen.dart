import 'package:budgets/data/repository/implementation/auth_repository.dart';
import 'package:budgets/data/repository/implementation/user_repository.dart';
import 'package:budgets/src/bloc/cubit/auth_cubit.dart';
import 'package:budgets/src/bloc/cubit/user_cubit.dart';
import 'package:flutter/material.dart';

import 'package:budgets/presentation/screens/home/components/spending_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/header.dart';
import 'components/header_actions.dart';
import 'components/last_records.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> homeWidgets = [
    HeaderActions(),
    HomeHeader(),
    LastRecordsWidget(),
    SpendingChart(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit(UserRepository())..getUser(),
      child: Scaffold(
        body: CustomScrollView(
          slivers: homeWidgets,
        ),
      ),
    );
  }
}
