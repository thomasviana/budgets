import 'package:budgets/constants.dart';
import 'package:budgets/screens/home/components/body.dart';
import 'package:budgets/screens/home/components/body_header.dart';
import 'package:budgets/widgets/main_card.dart';
import 'package:budgets/widgets/widget_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    MaterialButton(
                      minWidth: 80,
                      onPressed: () {
                        setState(() {
                          _currentIndex = 0;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _currentIndex == 0
                                ? Icons.home
                                : Icons.home_outlined,
                            size: 35,
                            color:
                                _currentIndex == 0 ? kAccentColor : Colors.grey,
                          ),
                          Text(
                            'Home',
                            style: TextStyle(
                              fontSize: 10,
                              color: _currentIndex == 0
                                  ? kAccentColor
                                  : Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 80,
                      onPressed: () {
                        setState(() {
                          _currentIndex = 1;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _currentIndex == 1
                                ? Icons.pie_chart
                                : Icons.pie_chart_outline,
                            size: 30,
                            color:
                                _currentIndex == 1 ? kAccentColor : Colors.grey,
                          ),
                          Text(
                            'Budgets',
                            style: TextStyle(
                              fontSize: 10,
                              color: _currentIndex == 1
                                  ? kAccentColor
                                  : Colors.grey,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    MaterialButton(
                      minWidth: 80,
                      onPressed: () {
                        setState(() {
                          _currentIndex = 2;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.format_list_bulleted_rounded,
                            size: 30,
                            color:
                                _currentIndex == 2 ? kAccentColor : Colors.grey,
                          ),
                          Text(
                            'Records',
                            style: TextStyle(
                              fontSize: 10,
                              color: _currentIndex == 2
                                  ? kAccentColor
                                  : Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 80,
                      onPressed: () {
                        setState(() {
                          _currentIndex = 3;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _currentIndex == 3
                                ? Icons.settings
                                : Icons.settings_outlined,
                            size: 30,
                            color:
                                _currentIndex == 3 ? kAccentColor : Colors.grey,
                          ),
                          Text(
                            'Settings',
                            style: TextStyle(
                              fontSize: 10,
                              color: _currentIndex == 3
                                  ? kAccentColor
                                  : Colors.grey,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            )),
        // child: BottomNavigationBar(
        //   type: BottomNavigationBarType.fixed,
        //   backgroundColor: kBackgroundColor,
        //   currentIndex: _currentIndex,
        //   selectedFontSize: 13,
        //   unselectedFontSize: 13,
        //   items: [
        //     BottomNavigationBarItem(
        //         icon: Icon(
        //           Icons.home,
        //         ),
        //         label: 'Home'),
        //     BottomNavigationBarItem(
        //         icon: Icon(
        //           Icons.home,
        //         ),
        //         label: 'Planning'),
        //     BottomNavigationBarItem(
        //         icon: Icon(
        //           Icons.home,
        //         ),
        //         label: 'Planning'),
        //     BottomNavigationBarItem(
        //         icon: Icon(
        //           Icons.home,
        //         ),
        //         label: 'Planning'),
        //     BottomNavigationBarItem(
        //         icon: Icon(
        //           Icons.home,
        //         ),
        //         label: 'Planning'),
        //   ],
        //   onTap: (index) {
        //     setState(() {
        //       _currentIndex = index;
        //     });
        //   },
        // ),
      ),
    );
  }
}
