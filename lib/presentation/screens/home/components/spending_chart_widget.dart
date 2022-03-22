import 'package:budgets/presentation/core/stats/stats_bloc.dart';
import 'package:budgets/presentation/utils/observer.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../resources/resources.dart';

class SpendingChart extends StatefulWidget {
  @override
  State<SpendingChart> createState() => _SpendingChartState();
}

class _SpendingChartState extends State<SpendingChart> {
  late int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    List<PieChartSectionData> getSections(
      int touchedIndex,
      List<CategoryData> data,
    ) {
      return data
          .asMap()
          .map<int, PieChartSectionData>((index, data) {
            final isTouched = index == touchedIndex;
            final double radious = isTouched ? 40 : 32;

            final value = PieChartSectionData(
              color: Color(data.color),
              value: data.amount,
              title: '',
              radius: radious,
            );
            return MapEntry(index, value);
          })
          .values
          .toList();
    }

    return WidgetCard(
      title: 'Gastos por categoría',
      actionTitle: 'Ver mas',
      onActionPressed: () {},
      content: Observer<StatsBloc, StatsState>(
        onSuccess: (context, state) {
          return Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: 640,
            child: Column(
              children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      PieChart(
                        PieChartData(
                          pieTouchData: PieTouchData(
                            touchCallback: (touchEvent, pieTouchResponse) {
                              setState(() {
                                if (touchEvent is FlLongPressEnd) {
                                  touchedIndex = -1;
                                } else {
                                  if (pieTouchResponse != null) {
                                    touchedIndex = pieTouchResponse
                                        .touchedSection!.touchedSectionIndex;
                                  }
                                }
                              });
                            },
                          ),
                          borderData: FlBorderData(show: false),
                          sectionsSpace: 4,
                          centerSpaceRadius: 72,
                          sections:
                              getSections(touchedIndex, state.categoriesInfo),
                        ),
                      ),
                      PieChartCenterText(
                        touchedIndex: touchedIndex,
                        data: state.categoriesInfo,
                      ),
                    ],
                  ),
                ),
                IndicatorsWidget(data: state.categoriesInfo),
              ],
            ),
          );
        },
      ),
    );
  }
}

class PieChartCenterText extends StatelessWidget {
  final int touchedIndex;
  final List<CategoryData> data;
  const PieChartCenterText({
    Key? key,
    required this.touchedIndex,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer<StatsBloc, StatsState>(
      onSuccess: (context, state) {
        final String title =
            touchedIndex == -1 ? 'Total' : data[touchedIndex].name;
        final String amount = touchedIndex == -1
            ? '\$${currency.format(state.expenses)}'
            : '\$${currency.format(data[touchedIndex].amount)}';
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(amount),
          ],
        );
      },
    );
  }
}

class IndicatorsWidget extends StatelessWidget {
  final List<CategoryData> data;

  const IndicatorsWidget({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(top: 8),
      itemCount: data.length,
      separatorBuilder: (BuildContext context, int index) =>
          const Divider(height: 2),
      itemBuilder: (BuildContext context, int index) {
        final category = data[index];
        return ListTile(
          dense: true,
          horizontalTitleGap: 0,
          contentPadding: EdgeInsets.zero,
          title: Text(category.name),
          leading: Icon(
            IconData(
              category.icon,
              fontFamily: 'MaterialIcons',
            ),
            color: Color(category.color),
          ),
          trailing: Text('\$${currency.format(category.amount)}'),
          onTap: () {},
        );
      },
    );
  }
}
