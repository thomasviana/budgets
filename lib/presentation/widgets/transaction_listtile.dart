import 'package:flutter/material.dart';

import 'package:budgets/constants.dart';

class TransactionListTile extends StatelessWidget {
  final String title;
  final String tag;
  final String amount;
  final String date;

  const TransactionListTile({
    required this.title,
    required this.tag,
    required this.amount,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minVerticalPadding: 20,
      leading: CircleAvatar(
        backgroundColor: kPrimayColor,
        child: Icon(Icons.money, color: Colors.white),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      subtitle: Text(tag),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(amount),
          Text(
            date,
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
      onTap: () {},
    );
  }
}
