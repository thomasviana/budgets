import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../core/stats/stats_bloc.dart';
import '../../utils/observer.dart';
import '../constants.dart';

class PieChartWidget extends StatefulWidget {
  static const double _defaultRadious = 72;
  static const double _tileHeight = 50;
  static const double _aditionalPadding = 84;
  final List<PieData> data;
  final double total;

  const PieChartWidget({
    Key? key,
    required this.data,
    required this.total,
  }) : super(key: key);

  @override
  State<PieChartWidget> createState() => _PieChartWidgetState();
}

class _PieChartWidgetState extends State<PieChartWidget> {
  late int touchedIndex = -1;
  @override
  Widget build(BuildContext context) {
    List<PieChartSectionData> getSections(
      int touchedIndex,
      List<PieData> data,
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

    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: PieChartWidget._defaultRadious * 2 +
          PieChartWidget._tileHeight * widget.data.length +
          PieChartWidget._aditionalPadding,
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
                    centerSpaceRadius: PieChartWidget._defaultRadious,
                    sections: getSections(touchedIndex, widget.data),
                  ),
                ),
                PieChartCenterText(
                  touchedIndex: touchedIndex,
                  total: widget.total,
                  data: widget.data,
                ),
              ],
            ),
          ),
          IndicatorsWidget(data: widget.data),
        ],
      ),
    );
  }
}

class PieChartCenterText extends StatelessWidget {
  final int touchedIndex;
  final double total;
  final List<PieData> data;
  const PieChartCenterText({
    Key? key,
    required this.touchedIndex,
    required this.total,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer<StatsBloc, StatsState>(
      onSuccess: (context, state) {
        final String title =
            touchedIndex == -1 ? 'Total' : data[touchedIndex].name;
        final String amount = touchedIndex == -1
            ? '\$${currency.format(total)}'
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
  final List<PieData> data;

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
