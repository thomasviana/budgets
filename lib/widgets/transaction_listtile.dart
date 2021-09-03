import 'package:budgets/constants.dart';
import 'package:flutter/material.dart';

class TransactionListTile extends StatelessWidget {
  const TransactionListTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 0),
      minVerticalPadding: 20,
      leading: CircleAvatar(
        backgroundColor: kPrimayColor,
        child: Icon(Icons.money, color: Colors.white),
      ),
      title: Text(
        'Expense title',
        style: Theme.of(context).textTheme.bodyText1,
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("-\$ 400,00"),
          Text(
            '1 Sept 2021',
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}
