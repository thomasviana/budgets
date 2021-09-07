import 'package:budgets/constants.dart';
import 'package:budgets/presentation/widgets/transaction_listtile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecordsScreen extends StatelessWidget {
  static const routeName = '/records-screen';
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: NestedScrollView(
        headerSliverBuilder: (context, isScrolled) => [
          CupertinoSliverNavigationBar(
            largeTitle: Text('Records'),
          ),
        ],
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                    (context, index) => TransactionListTile()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
