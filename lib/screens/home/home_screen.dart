import 'package:budgets/constants.dart';
import 'package:budgets/screens/budgets/budgets_screen.dart';
import 'package:budgets/screens/home/components/body_header.dart';
import 'package:budgets/screens/records/records_screen.dart';
import 'package:budgets/screens/settings/settings_screen.dart';
import 'package:budgets/widgets/widget_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            brightness: Brightness.light,
            backgroundColor: kPrimayColor,
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.notifications_on,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SliverPersistentHeader(
            delegate: HeaderDelegate(),
          ),
          SliverToBoxAdapter(
            child: WidgetCard(),
          ),
          SliverToBoxAdapter(
            child: WidgetCard(),
          ),
          SliverToBoxAdapter(
            child: WidgetCard(),
          ),
        ],
      ),
    );
  }
}
