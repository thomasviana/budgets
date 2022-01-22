import 'package:budgets/core/budgets/domain.dart';
import 'package:budgets/core/transactions/domain.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../resources.dart';

class TransactionListTile extends StatelessWidget {
  final Transaction transaction;
  final Budget budget;
  final VoidCallback onPressed;

  const TransactionListTile({
    Key? key,
    required this.transaction,
    required this.budget,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        maxRadius: 20,
        child: Icon(
          IconData(
            transaction.icon,
            fontFamily: 'MaterialIcons',
          ),
          color: AppColors.white,
        ),
        backgroundColor: Color(transaction.color),
      ),
      title: Text(
        transaction.title,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      subtitle: Text(budget.abbreviation!),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('\$${currency.format(transaction.amount)}'),
          Text(
            DateFormat().add_jm().format(transaction.date),
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
      onTap: onPressed,
    );
  }
}
