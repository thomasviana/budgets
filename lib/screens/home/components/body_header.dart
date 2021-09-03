import 'package:budgets/widgets/main_card.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class HeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final size = MediaQuery.of(context).size;
    return BodyHeader(size: size);
  }

  @override
  double get maxExtent => 234;

  @override
  double get minExtent => 234;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class BodyHeader extends StatelessWidget {
  const BodyHeader({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: kDefaultPadding),
          height: size.height * 0.23,
          color: kBackgroundColor,
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(
                    left: kDefaultPadding,
                    right: kDefaultPadding,
                    top: kDefaultPadding,
                    bottom: kDefaultPadding),
                height: size.height * 0.23 - 40,
                width: size.width,
                decoration: BoxDecoration(
                  color: kPrimayColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(60),
                    bottomRight: Radius.circular(60),
                  ),
                ),
                child: Text(
                  'Hi Thomas!',
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MainCard(),
                    MainCard(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
