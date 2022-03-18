import 'dart:io' show Platform;
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../core/date/date_bloc.dart';
import '../../core/transactions/transactions_bloc.dart';
import '../../resources/resources.dart';
import 'components/stat_card.dart';

class StatsScreen extends StatefulWidget {
  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  late DateBloc dateBloc;
  late TransactionsBloc txBloc;
  @override
  void initState() {
    dateBloc = context.read<DateBloc>();
    txBloc = context.read<TransactionsBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: StatsContent(),
    );
  }
}

class StatsContent extends StatelessWidget {
  const StatsContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionsBloc, TransactionsState>(
      builder: (context, state) {
        return CustomScrollView(
          shrinkWrap: true,
          slivers: [
            if (Platform.isIOS)
              CupertinoSliverNavigationBar(
                stretch: true,
                largeTitle: Text('Stats'),
              ),
            if (Platform.isAndroid)
              SliverAppBar(
                title: Text(
                  'Stats',
                ),
                elevation: 0.5,
                floating: true,
                pinned: true,
                actions: [
                  IconButton(
                    icon: Icon(Icons.sort),
                    onPressed: () {},
                  ),
                ],
              ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _DateFilterDelegate(),
            ),
            statCard(
              context,
              title: 'BALANCE',
              amount: 22300,
              graph: Icon(
                Icons.donut_large,
                size: 50,
                color: AppColors.primaryColor,
              ),
            ),
            statCard(
              context,
              title: 'INCOMES',
              amount: 5000,
              graph: Icon(
                Icons.donut_large,
                size: 50,
                color: AppColors.primaryColor,
              ),
            ),
            statCard(
              context,
              title: 'SPENDING',
              amount: 270,
              graph: Icon(
                Icons.donut_large,
                size: 50,
                color: AppColors.primaryColor,
              ),
            ),
            statCard(
              context,
              title: 'CASH FLOW',
              amount: 4730,
              graph: Icon(
                Icons.donut_large,
                size: 50,
                color: AppColors.primaryColor,
              ),
            ),
            statCard(
              context,
              title: 'ASSETS',
              amount: 100000,
              graph: Icon(
                Icons.donut_large,
                size: 50,
                color: AppColors.primaryColor,
              ),
            ),
            statCard(
              context,
              title: 'DEBT',
              amount: 50000,
              graph: Icon(
                Icons.donut_large,
                size: 50,
                color: AppColors.primaryColor,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _DateFilterDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return DateFilter();
  }

  @override
  double get maxExtent => 56;

  @override
  double get minExtent => 56;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class DateFilter extends StatefulWidget {
  const DateFilter({
    Key? key,
  }) : super(key: key);

  @override
  State<DateFilter> createState() => _DateFilterState();
}

class _DateFilterState extends State<DateFilter> {
  late TransactionsBloc bloc;
  late DateBloc dateBloc;
  @override
  void initState() {
    bloc = context.read<TransactionsBloc>();
    dateBloc = context.read<DateBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionsBloc, TransactionsState>(
      builder: (context, state) {
        return Stack(
          children: [
            ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: Container(
                  color: AppColors.white.withOpacity(0.4),
                  alignment: Alignment.center,
                  child: Container(
                    height: 30,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.primaryColor.withOpacity(0.8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          icon: Icon(
                            Icons.chevron_left,
                            color: AppColors.white.withOpacity(0.5),
                          ),
                          onPressed: () => dateBloc.add(MonthDecremented()),
                        ),
                        BlocListener<DateBloc, DateState>(
                          listenWhen: (previous, current) =>
                              previous.date != current.date,
                          listener: (context, state) {
                            bloc.add(TxsDateUpdated(date: state.date));
                          },
                          child: Text(
                            DateFormat(
                              'MMMM - yyyy',
                              AppLocalizations.of(context)!.localeName,
                            ).format(state.date),
                            style: TextStyle(
                              color: AppColors.white.withOpacity(0.5),
                            ),
                          ),
                        ),
                        IconButton(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          icon: Icon(
                            Icons.chevron_right,
                            color: AppColors.white.withOpacity(0.5),
                          ),
                          onPressed: () => dateBloc.add(MonthIncremented()),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
