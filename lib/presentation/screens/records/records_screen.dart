import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:budgets/constants.dart';
import 'package:budgets/presentation/widgets/transaction_listtile.dart';
import 'package:budgets/bloc/cubit/record_cubit.dart';

class RecordsScreen extends StatefulWidget {
  @override
  _RecordsScreenState createState() => _RecordsScreenState();
}

class _RecordsScreenState extends State<RecordsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecordCubit, RecordState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is RecordLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is RecordReadyState) {
          final recordList = state.recordList;

          return CupertinoPageScaffold(
            child: NestedScrollView(
              headerSliverBuilder: (context, isScrolled) => [
                const CupertinoSliverNavigationBar(
                  largeTitle: Text('Records'),
                ),
              ],
              body: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => TransactionListTile(
                          isIncome:
                              // ignore: avoid_bool_literals_in_conditional_expressions
                              recordList[index].type == 'Income' ? true : false,
                          title: recordList[index].title,
                          tag: recordList[index].tag,
                          amount:
                              '\$${currency.format(recordList[index].amount)}',
                          date: DateFormat.MMMd()
                              .add_jm()
                              .format(recordList[index].date.toDate())
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
