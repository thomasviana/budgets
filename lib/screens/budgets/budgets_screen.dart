import 'package:flutter/cupertino.dart';

class BudgetsScreen extends StatelessWidget {
  static const routeName = '/budgets-screen';
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          CupertinoSliverNavigationBar(
            largeTitle: Text('Budgets'),
          ),
        ],
        body: Container(),
      ),
    );
  }
}
