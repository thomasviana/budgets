import 'package:flutter/material.dart';

import '../resources/constants.dart';

class TransactionListTile extends StatelessWidget {
  final String title;
  final String tag;
  final String amount;
  final String date;
  final bool isIncome;

  const TransactionListTile({
    required this.title,
    required this.tag,
    required this.amount,
    required this.date,
    required this.isIncome,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // minVerticalPadding: 20,
      leading: CircleAvatar(
        backgroundColor: isIncome ? Colors.greenAccent : kAccentColor,
        child: Icon(isIncome ? Icons.arrow_forward : Icons.arrow_back,
            color: Colors.white),
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
