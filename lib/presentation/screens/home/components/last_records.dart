import 'package:flutter/material.dart';

import 'package:budgets/constants.dart';
import 'package:budgets/presentation/widgets/transaction_listtile.dart';
import 'package:budgets/presentation/widgets/widget_card.dart';

class LastRecordsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WidgetCard(
      title: 'Last records',
      content: Container(
        height: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TransactionListTile(),
            TransactionListTile(),
            TransactionListTile(),
            Spacer(),
            Text(
              'Show more',
              textAlign: TextAlign.end,
              style: TextStyle(color: kAccentColor),
            )
          ],
        ),
      ),
    );
  }
}
