import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/header.dart';
import 'components/header_actions.dart';
import 'components/last_records.dart';
import 'components/spending_chart.dart';
import 'cubit/home_screen_cubit.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeScreenCubit cubit;

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
    return Scaffold(
      body: CustomScrollView(
        slivers: homeWidgets,
      ),
    );
  }

  List<Widget> homeWidgets = [
    HeaderActions(),
    HomeHeader(),
    LastRecordsWidget(),
    SpendingChart(),
  ];
}
