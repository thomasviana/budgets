import 'package:flutter/material.dart';

import '../../../resources/colors.dart';

class BudgetsTab extends StatelessWidget {
  const BudgetsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.greyBackground,
      child: Center(child: Text('Budgets')),
    );
  }
}
