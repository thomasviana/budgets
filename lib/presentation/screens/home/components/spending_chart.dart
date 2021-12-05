import 'package:flutter/material.dart';

import '../../../resources/colors.dart';
import '../../../widgets/widget_card.dart';

class SpendingChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WidgetCard(
      title: 'Spending',
      content: SizedBox(
        width: double.infinity,
        height: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Expanded(
              child: Center(
                child: Icon(Icons.donut_large, size: 150, color: Colors.orange),
              ),
            ),
            Text(
              'Show more',
              textAlign: TextAlign.end,
              style: TextStyle(
                color: AppColors.accentColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
