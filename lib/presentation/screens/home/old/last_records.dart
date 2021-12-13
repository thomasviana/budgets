import 'package:flutter/material.dart';

import '../../../resources/colors.dart';
import '../../../widgets/transaction_listtile.dart';
import '../../../widgets/widget_card.dart';

class LastRecordsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WidgetCard(
      title: 'Last records',
      content: SizedBox(
        height: 250,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            TransactionListTile(
                isIncome: true,
                title: 'New shoes',
                tag: 'CLO',
                amount: '160,00',
                date: 'Sept 4'),
            TransactionListTile(
                isIncome: true,
                title: 'Restaurant',
                tag: 'DIV',
                amount: '110,00',
                date: 'Sept 1'),
            TransactionListTile(
                isIncome: false,
                title: 'Salary',
                tag: 'Active Income',
                amount: '5.000,00',
                date: 'Ago 30'),
            Spacer(),
            Text(
              'Show more',
              textAlign: TextAlign.end,
              style: TextStyle(
                color: AppColors.primaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
