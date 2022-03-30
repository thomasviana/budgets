import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../common/extensions.dart';
import '../../core/stats/stats_bloc.dart';
import '../../utils/observer.dart';
import '../resources.dart';

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

class _PieChartWidgetState extends State<PieChartWidget>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;
  late int touchedIndex = -1;

  double sectionAnimation = 0;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCirc,
    )..addListener(() {
        setState(() {
          sectionAnimation = _animation.value;
        });
      });
    triggerAnimation();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(PieChartWidget old) {
    triggerAnimation();

    super.didUpdateWidget(old);
  }

  void triggerAnimation() {
    _animationController
      ..reset()
      ..forward();
  }

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
            final double fontSize = isTouched ? 12 : 0;
            final int percent = (data.percent * 100).round();

            final value = PieChartSectionData(
              color: Color(data.color),
              value: data.percent,
              titleStyle: TextStyle(
                fontSize: fontSize,
                color: AppColors.white,
              ),
              title: '$percent%',
              radius: radious,
            );
            return MapEntry(index, value);
          })
          .values
          .toList()
        ..add(
          PieChartSectionData(
            value: -(sectionAnimation - 1) * 1,
            title: '',
            color: Colors.transparent,
          ),
        );
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
            ? total.toCurrencyFormat()
            : data[touchedIndex].amount.toCurrencyFormat();
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
          trailing: Text(category.amount.toCurrencyFormat()),
          onTap: () {},
        );
      },
    );
  }
}
