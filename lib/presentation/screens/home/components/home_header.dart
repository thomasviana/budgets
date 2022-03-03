import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../../resources/resources.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      delegate: _HomeHeaderDelegate(
        topPadding: MediaQuery.of(context).padding.top,
      ),
    );
  }
}

class _HomeHeaderDelegate extends SliverPersistentHeaderDelegate {
  static const double _defaultElevation = 4.0;
  static const double _defaultHeaderHeight = 148;
  static const double _mainCardHeight = 110;
  final double topPadding;

  _HomeHeaderDelegate({
    required this.topPadding,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final double extentDiff = maxExtent - minExtent;
    final double elevation =
        (shrinkOffset > extentDiff) ? _defaultElevation : 0.0;
    final double shrinkRatio = shrinkOffset / extentDiff; // 0 ... 1
    final double opacity = 1 - shrinkRatio; // 1 ... 0
    const space = 95 - kToolbarHeight;
    final percent =
        lerpDouble(0.0, -pi / 2, ((shrinkOffset / 2) / space).clamp(0.0, 1.0));

    return AnimatedHeader(
      elevation: elevation,
      opacity: opacity,
      percent: percent,
    );
  }

  @override
  double get maxExtent =>
      topPadding + _defaultHeaderHeight + (_mainCardHeight / 2);

  @override
  double get minExtent => 0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class AnimatedHeader extends StatefulWidget {
  const AnimatedHeader({
    Key? key,
    required this.elevation,
    required this.opacity,
    required this.percent,
  }) : super(key: key);

  final double elevation;
  final double opacity;
  final double? percent;

  @override
  State<AnimatedHeader> createState() => _AnimatedHeaderState();
}

class _AnimatedHeaderState extends State<AnimatedHeader>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animationController;

  late double headerOpacity;

  @override
  void initState() {
    headerOpacity = 0;
    animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();

    animation = Tween<double>(begin: 0, end: 1).animate(animationController)
      ..addListener(() {
        setState(() {
          headerOpacity = animation.value;
        });
      });
    super.initState();
  }

  @override
  void dispose() {
    animation.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: widget.elevation,
      child: Stack(
        children: [
          Positioned.fill(
            bottom: 50 * widget.opacity,
            child: Container(
              color: AppColors.primaryColor,
            ),
          ),
          Positioned(
            top: 12 * widget.opacity,
            left: 0,
            right: 0,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateX(widget.percent!)
                ..scale(headerOpacity.clamp(0.8, 1)),
              child: Column(
                children: [
                  Text(
                    'Balance',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.white.withOpacity(0.5 * headerOpacity),
                    ),
                  ),
                  Text(
                    '\$ ${currency.format(5000000)}',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white.withOpacity(0.9 * widget.opacity),
                    ),
                  ),
                  Container(
                    height: 30,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.white.withOpacity(0.2 * widget.opacity),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          icon: Icon(
                            Icons.chevron_left,
                            color: AppColors.white
                                .withOpacity(0.5 * widget.opacity),
                          ),
                          onPressed: () {},
                        ),
                        Text(
                          DateFormat(
                            'MMMM - yyyy',
                            AppLocalizations.of(context)!.localeName,
                          ).format(DateTime.now()),
                          style: TextStyle(
                            color: AppColors.white
                                .withOpacity(0.5 * widget.opacity),
                          ),
                        ),
                        IconButton(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          icon: Icon(
                            Icons.chevron_right,
                            color: AppColors.white
                                .withOpacity(0.5 * widget.opacity),
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, -0.002)
                ..scale(widget.opacity)
                ..rotateX(-widget.percent!),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AccountCard(
                    icon: Icons.account_balance_wallet_outlined,
                    title: 'GENERAL',
                    amount: 4800000,
                    opacity: widget.opacity,
                  ),
                  AccountCard(
                    icon: Icons.account_balance_wallet_outlined,
                    title: 'BILLETERA',
                    amount: 200000,
                    opacity: widget.opacity,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
