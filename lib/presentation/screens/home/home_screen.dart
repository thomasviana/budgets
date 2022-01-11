import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuple/tuple.dart';

import '../../resources/colors.dart';
import 'components/accounts_tab.dart';
import 'components/budgets_tab.dart';
import 'components/home_silver_app_bar.dart';
import 'cubit/home_screen_cubit.dart';
import 'delegates/sliver_persistent_header_delegate_impl.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late HomeScreenCubit cubit;
  final List<Tuple2> tabs = [
    Tuple2('Cuentas', AccountsTab()),
    Tuple2('Presupuestos', BudgetsTab()),
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    cubit = context.read<HomeScreenCubit>();
    cubit.init();
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenCubit, HomeScreenState>(
      builder: _buildState,
    );
  }

  Widget _buildState(BuildContext context, HomeScreenState state) {
    return SafeArea(
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            HomeSliverAppBar(
              title: tabs[_tabController.index].item1 as String,
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: SliverPersistentHeaderDelegateImpl(
                color: AppColors.white,
                tabBar: TabBar(
                  labelColor: Colors.black,
                  indicatorColor: Colors.black,
                  controller: _tabController,
                  tabs: tabs
                      .map<Tab>(
                        (Tuple2 tab) => Tab(
                          text: tab.item1 as String,
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children:
              tabs.map<Widget>((Tuple2 tab) => tab.item2 as Widget).toList(),
        ),
      ),
    );
  }
}
