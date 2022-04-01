import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../core/date/date_bloc.dart';
import '../../core/transactions/transactions_bloc.dart';
import '../resources.dart';

class DateFilterDelegate extends SliverPersistentHeaderDelegate {
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

class DateFilter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DateFilterView();
  }
}

class DateFilterView extends StatelessWidget {
  const DateFilterView({Key? key}) : super(key: key);

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
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Container(
                      height: 30,
                      constraints: BoxConstraints(minWidth: 200),
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
                            onPressed: () => context
                                .read<DateBloc>()
                                .add(MonthDecremented()),
                          ),
                          BlocListener<DateBloc, DateState>(
                            listenWhen: (previous, current) =>
                                previous.date != current.date,
                            listener: (context, state) {
                              context
                                  .read<TransactionsBloc>()
                                  .add(TxsDateUpdated(date: state.date));
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
                            onPressed: () => context
                                .read<DateBloc>()
                                .add(MonthIncremented()),
                          ),
                        ],
                      ),
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
