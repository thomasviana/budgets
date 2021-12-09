import 'package:budgets/presentation/resources/colors.dart';
import 'package:flutter/material.dart';

class BudgetsTab extends StatelessWidget {
  const BudgetsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundColor,
      child: Center(child: Text('Budgets')),
    );
  }
}
