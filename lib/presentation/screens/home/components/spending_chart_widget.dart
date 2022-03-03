import 'package:flutter/material.dart';

import '../../../resources/resources.dart';

class SpendingChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WidgetCard(
      title: 'Presupuestos',
      actionTitle: 'Ver mas',
      onActionPressed: () {},
      content: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: 250,
        child: Text(
          'Content',
          style: TextStyle(color: AppColors.greyDisabled),
        ),
      ),
    );
  }
}
