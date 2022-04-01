import 'package:flutter/material.dart';

import '../../../core/stats/stats_bloc.dart';
import '../../../resources/resources.dart';

class TrailingProgressBars extends StatelessWidget {
  final List<BudgetData> data;
  const TrailingProgressBars({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.only(top: 8),
          itemCount: 6,
          itemBuilder: (BuildContext context, int index) {
            final budgetData = data[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AnimatedProgressBar(
                  currentValue: budgetData.percent,
                  displayText: '',
                  backgroundColor: AppColors.greyDisabled.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                  size: 4,
                  changeColorValue: 105,
                  changeProgressColor: AppColors.red.withOpacity(0.6),
                  displayTextStyle: TextStyle(color: Colors.transparent),
                ),
                SizedBox(height: 4),
              ],
            );
          },
        ),
      ],
    );
  }
}
