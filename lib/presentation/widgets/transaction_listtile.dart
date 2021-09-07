import 'package:budgets/business_logic/bloc/bloc/transactions_bloc.dart';
import 'package:budgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final txBloc = BlocProvider.of<TransactionsBloc>(context);
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 0),
      minVerticalPadding: 20,
      leading: CircleAvatar(
        backgroundColor: kPrimayColor,
        child: Icon(Icons.money, color: Colors.white),
      ),
      title: Text(
        txBloc.state.title,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("${currency.format(txBloc.state.amount)}"),
          Text(
            '1 Sept 2021',
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}
