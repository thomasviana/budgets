import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

import '../../resources/colors.dart';
import 'components/accounts_tab.dart';
import 'components/budgets_tab.dart';
import 'components/home_silver_app_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final List<Tuple2> tabs = [
    Tuple2('Presupuestos', BudgetsTab()),
    Tuple2('Cuentas', AccountsTab()),
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
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
                  labelColor: AppColors.black,
                  indicatorColor: AppColors.primaryVariant,
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

class SliverPersistentHeaderDelegateImpl
    extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;
  final Color color;

  const SliverPersistentHeaderDelegateImpl({
    this.color = Colors.transparent,
    required this.tabBar,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: color,
      child: tabBar,
    );
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
