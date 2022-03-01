import 'package:bloc/bloc.dart';
import 'package:budgets/core/budgets/domain.dart';
import 'package:budgets/core/transactions/application.dart';
import 'package:budgets/core/transactions/domain.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

part 'home_screen_event.dart';
part 'home_screen_state.dart';

@injectable
class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  final GetTransactions getTransactions;
  HomeScreenBloc(
    this.getTransactions,
  ) : super(HomeScreenState.initial()) {
    on<BudgetsInfoRequested>((event, emit) async {
      await emit.onEach<Option<List<Transaction>>>(
        getTransactions(),
        onData: (optionTransacions) {
          optionTransacions.fold(
            () {},
            (transactions) {
              for (final budget in event.budgets) {
                state.budgetsInfo.putIfAbsent(budget, () {
                  var spent = 0.0;
                  var budgeted = 0.0;
                  for (final transaction in transactions) {
                    final newAmount1 = transaction
                        .budgetManagement![budget.id.value]!['spent']!;
                    spent += newAmount1;
                    final newAmount2 = transaction
                        .budgetManagement![budget.id.value]!['budgeted']!;
                    budgeted += newAmount2;
                  }
                  return {'spent': spent, 'budgeted': budgeted};
                });
              }
              emit(
                state.copyWith(
                  budgets: event.budgets,
                  budgetsInfo: state.budgetsInfo,
                  isLoading: false,
                ),
              );
            },
          );
        },
      );
    });
  }
}
