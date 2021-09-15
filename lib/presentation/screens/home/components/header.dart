import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:budgets/constants.dart';
import 'package:budgets/presentation/widgets/main_card.dart';
import 'package:budgets/bloc/cubit/user_cubit.dart';

class HomeHeader extends SliverPersistentHeader {
  HomeHeader() : super(delegate: HeaderDelegate());
}

class HeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Header();
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  double get maxExtent => 235;

  @override
  double get minExtent => 235;
}

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: kDefaultPadding),
          height: 205,
          color: kBackgroundColor,
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(
                    left: kDefaultPadding,
                    right: kDefaultPadding,
                    top: kDefaultPadding,
                    bottom: kDefaultPadding),
                height: 170,
                width: size.width,
                decoration: BoxDecoration(
                  color: kPrimayColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(60),
                    bottomRight: Radius.circular(60),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 25,
                child: BlocBuilder<UserCubit, UserState>(
                  builder: (_, state) {
                    if (state is UserLoadingState) {
                      return CircularProgressIndicator();
                    }
                    if (state is UserReadyState) {
                      return Text(
                        'Hi ${state.user.name!.split(' ')[0]}!',
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      );
                    }
                    throw Exception();
                  },
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MainCard(
                      icon: Icons.food_bank,
                      title: 'BANK',
                      amount: 100000,
                    ),
                    MainCard(
                      icon: Icons.money,
                      title: 'CASH',
                      amount: 100000,
                    ),
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
