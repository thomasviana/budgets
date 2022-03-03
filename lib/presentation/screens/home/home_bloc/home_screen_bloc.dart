import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/budgets/domain.dart';
import '../../../../core/transactions/domain.dart';
import '../../../../core/user/application.dart';
import '../../../../core/user/domain.dart';

part 'home_screen_event.dart';
part 'home_screen_state.dart';

@injectable
class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  final GetProfileInfo getProfileInfo;

  HomeScreenBloc(
    this.getProfileInfo,
  ) : super(HomeScreenState.initial()) {
    on<HomeScreenInfoRequested>((event, emit) async {
      emit(
        state.copyWith(
          user: event.user,
          transactions: event.transactions,
          budgets: event.budgets,
          date: event.date,
          isLoading: false,
        ),
      );
    });
    on<BudgetsInfoRequested>(
      (event, emit) async {
        for (final budget in state.budgets) {
          state.budgetsInfo.putIfAbsent(budget, () {
            var spent = 0.0;
            var budgeted = 0.0;
            for (final transaction in state.transactions) {
              final newAmount1 =
                  transaction.budgetManagement![budget.id.value]!['spent']!;
              spent += newAmount1;
              final newAmount2 =
                  transaction.budgetManagement![budget.id.value]!['budgeted']!;
              budgeted += newAmount2;
            }
            return {'spent': spent, 'budgeted': budgeted};
          });
        }
        emit(
          state.copyWith(
            budgetsInfo: state.budgetsInfo,
          ),
        );
      },
    );
  }
}
