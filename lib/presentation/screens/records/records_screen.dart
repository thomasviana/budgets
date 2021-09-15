import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:budgets/constants.dart';
import 'package:budgets/presentation/widgets/transaction_listtile.dart';
import 'package:budgets/src/bloc/cubit/record_cubit.dart';

class RecordsScreen extends StatefulWidget {
  @override
  _RecordsScreenState createState() => _RecordsScreenState();
}

class _RecordsScreenState extends State<RecordsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecordCubit, RecordState>(
      builder: (context, state) {
        if (state is RecordLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is RecordReadyState) {
          final recordList = state.recordList;

          return CupertinoPageScaffold(
            child: NestedScrollView(
              headerSliverBuilder: (context, isScrolled) => [
                CupertinoSliverNavigationBar(
                  largeTitle: Text('Records'),
                ),
              ],
              body: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: CustomScrollView(
                  physics: BouncingScrollPhysics(),
                  slivers: [
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => TransactionListTile(
                          title: recordList[index].title,
                          subtitle: recordList[index].tag,
                          amount:
                              '\$${currency.format(recordList[index].amount)}',
                          date: DateFormat.MMMd()
                              .add_jm()
                              .format((recordList[index].date.toDate()))
                              .toString(),
                        ),
                        childCount: recordList.length,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        throw Exception();
      },
    );
  }
}
