import 'package:budgets/core/transactions/domain.dart';
import 'package:flutter/material.dart';

import '../resources.dart';

class TransactionListTile extends StatelessWidget {
  final String title;
  final int icon;
  final int color;
  final String note;
  final String budget;
  final String amount;
  final String date;
  final TransactionType txType;

  const TransactionListTile({
    Key? key,
    required this.title,
    required this.icon,
    required this.color,
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
        maxRadius: 20,
        child: Icon(
          IconData(
            icon,
            fontFamily: 'MaterialIcons',
          ),
          color: AppColors.white,
        ),
        backgroundColor: Color(color),
      ),
      title: Text(
        title,
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
