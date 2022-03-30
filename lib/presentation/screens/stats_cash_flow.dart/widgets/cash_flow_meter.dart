import 'package:flutter/material.dart';

import '../../../../common/extensions.dart';
import '../../../resources/colors.dart';

class CashFlowMeter extends StatefulWidget {
  final double expenses;
  final double incomes;
  const CashFlowMeter({
    Key? key,
    required this.expenses,
    required this.incomes,
  }) : super(key: key);

  @override
  State<CashFlowMeter> createState() => _CashFlowMeterState();
}

class _CashFlowMeterState extends State<CashFlowMeter>
    with TickerProviderStateMixin {
  static const double _meterHeight = 24.0;
  static const double _indicatorSize = 48.0;
  static const double _resultFixedWidth = 100.0;

  late Animation<double> _animation;
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;
  late AnimationController _opacityAnimationController;

  late double balance;
  late double cashFlowRatio;
  late String cashFlowLabel;
  double animatedOpacity = 0;
  double meterAnimation = 0;

  @override
  void initState() {
    super.initState();
    balance = widget.incomes - widget.expenses;
    cashFlowRatio = widget.incomes / (widget.incomes + widget.expenses);
    if (cashFlowRatio == 0.5) {
      cashFlowLabel = 'Neutro';
    } else if (cashFlowRatio > 0.5) {
      cashFlowLabel = 'Superávit';
    } else if (cashFlowRatio < 0.5) {
      cashFlowLabel = 'Déficit';
    }
    _animationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    )..addListener(() {
        setState(() {
          meterAnimation = _animation.value;
        });
      });
    _opacityAnimationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    _opacityAnimation = CurvedAnimation(
      parent: _opacityAnimationController,
      curve: Curves.linear,
    )..addListener(() {
        setState(() {
          animatedOpacity = _opacityAnimation.value;
        });
      });
    triggerAnimation();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _opacityAnimationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(CashFlowMeter old) {
    triggerAnimation();
    super.didUpdateWidget(old);
  }

  void triggerAnimation() {
    _opacityAnimationController.reset();
    _animationController
      ..reset()
      ..forward();

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _opacityAnimationController.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final renderBox = context.findRenderObject() as RenderBox?;
    final size = renderBox?.size;
    final meterWidth = size?.width;

    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.topCenter,
            clipBehavior: Clip.none,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: _meterHeight,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 234, 0, 0),
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: _meterHeight,
                      decoration: BoxDecoration(
                        color: AppColors.red,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: _meterHeight,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        Container(
                          height: _meterHeight,
                          decoration: BoxDecoration(
                            color: AppColors.amber,
                          ),
                        ),
                        Container(
                          height: _meterHeight + 16,
                          width: 2,
                          color: AppColors.greySecondary,
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: _meterHeight,
                      decoration: BoxDecoration(
                        color: AppColors.green,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: _meterHeight,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 41, 170, 39),
                        borderRadius: BorderRadius.horizontal(
                          right: Radius.circular(12.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: -2,
                left: ((meterWidth ?? 0.0) - _indicatorSize) *
                    cashFlowRatio *
                    meterAnimation,
                child: Icon(
                  Icons.airplay_rounded,
                  color: AppColors.greySecondary,
                  size: _indicatorSize,
                ),
              ),
              SizedBox(height: 90),
              Positioned(
                top: 58,
                left: ((meterWidth ?? 0.0) - _resultFixedWidth) *
                    cashFlowRatio *
                    meterAnimation,
                child: SizedBox(
                  width: _resultFixedWidth,
                  child: Column(
                    children: [
                      FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          cashFlowLabel,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.textColor
                                .withOpacity(animatedOpacity),
                          ),
                        ),
                      ),
                      FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          balance.toCurrencyFormat(),
                          style: TextStyle(
                            color: AppColors.textColor
                                .withOpacity(animatedOpacity),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
