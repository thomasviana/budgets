import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import '../../../core/budgets/domain.dart';
import '../../../core/transactions/domain.dart';
import '../resources.dart';

class TransactionListTile extends StatelessWidget {
  final Transaction transaction;
  final Budget budget;
  final VoidCallback onPressed;
  final Function(BuildContext?) onDeletePressed;

  const TransactionListTile({
    Key? key,
    required this.transaction,
    required this.budget,
    required this.onPressed,
    required this.onDeletePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: const ValueKey(0),
      endActionPane: ActionPane(
        extentRatio: 0.25,
        motion: ScrollMotion(),
        dismissible:
            DismissiblePane(onDismissed: () => onDeletePressed(context)),
        children: [
          SlidableAction(
            onPressed: onDeletePressed,
            backgroundColor: AppColors.red,
            icon: Icons.delete_outline_outlined,
            label: 'Eliminar',
          ),
        ],
      ),
      child: ListTile(
        dense: true,
        leading: CircleAvatar(
          radius: 20,
          backgroundColor: Color(transaction.color),
          child: CircleAvatar(
            radius: 18,
            backgroundColor: AppColors.white,
            child: Icon(
              IconData(
                transaction.icon,
                fontFamily: 'MaterialIcons',
              ),
              color: Color(transaction.color),
            ),
          ),
        ),
        title: Text(
          transaction.title ?? '',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        subtitle: Row(
          children: [
            Text(
              transaction.isExpense
                  ? budget.abbreviation!
                  : transaction.incomeType == IncomeType.active
                      ? 'IA'
                      : 'IP',
              style: TextStyle(
                color: Color(budget.color),
                fontWeight: FontWeight.bold,
              ),
            ),
            if (transaction.note!.isNotEmpty)
              Text(
                ' - ${transaction.note}',
                style: TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 12,
                ),
              )
          ],
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '\$${currency.format(transaction.amount)}',
              style: TextStyle(
                color: transaction.isExpense ? AppColors.red : AppColors.green,
              ),
            ),
            Text(
              DateFormat().add_jm().format(transaction.date),
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
        onTap: onPressed,
      ),
    );
  }
}

class LastTransactionsListTile extends StatelessWidget {
  final Transaction transaction;
  final Budget budget;
  final VoidCallback onPressed;

  const LastTransactionsListTile({
    Key? key,
    required this.transaction,
    required this.budget,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      minLeadingWidth: 8,
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        radius: 18,
        backgroundColor: Color(transaction.color),
        child: CircleAvatar(
          radius: 16,
          backgroundColor: AppColors.white,
          child: Icon(
            IconData(
              transaction.icon,
              fontFamily: 'MaterialIcons',
            ),
            color: Color(transaction.color),
          ),
        ),
      ),
      title: Text(
        transaction.title ?? '',
        style: Theme.of(context).textTheme.bodyText1,
      ),
      subtitle: Row(
        children: [
          Text(
            transaction.isExpense
                ? budget.abbreviation!
                : transaction.incomeType == IncomeType.active
                    ? 'IA'
                    : 'IP',
            style: TextStyle(
              color: Color(budget.color),
              fontWeight: FontWeight.bold,
            ),
          ),
          if (transaction.note!.isNotEmpty)
            Text(
              ' - ${transaction.note}',
              style: TextStyle(
                fontWeight: FontWeight.w200,
                fontSize: 12,
              ),
            )
        ],
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '\$${currency.format(transaction.amount)}',
            style: TextStyle(
              color: transaction.isExpense ? AppColors.red : AppColors.green,
            ),
          ),
          Text(
            DateFormat('MMMM d').format(transaction.date),
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
      onTap: onPressed,
    );
  }
}
