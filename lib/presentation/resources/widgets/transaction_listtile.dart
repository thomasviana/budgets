import 'package:budgets/core/transactions/domain.dart';
import 'package:flutter/material.dart';

class TransactionListTile extends StatelessWidget {
  final String note;
  final String budget;
  final String amount;
  final String date;
  final TransactionType txType;

  const TransactionListTile({
    Key? key,
    required this.note,
    required this.budget,
    required this.amount,
    required this.date,
    required this.txType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final isIncome = txType == TransactionType.income;

    return ListTile(
      // minVerticalPadding: 20,
      leading: CircleAvatar(
        backgroundColor: isIncome
            ? theme.colorScheme.primary
            : theme.colorScheme.primaryVariant,
        child: Icon(
          isIncome ? Icons.chevron_right : Icons.chevron_left,
          color: Colors.white,
        ),
      ),
      title: Text(
        note,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      subtitle: Text(budget),
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
