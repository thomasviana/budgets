import 'package:bloc/bloc.dart';
import 'package:budgets/core/transactions/application.dart';
import 'package:budgets/core/transactions/domain.dart';
import 'package:budgets/core/user/application.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

part 'transactions_screen_event.dart';
part 'transactions_screen_state.dart';

@injectable
class TransactionsScreenBloc
    extends Bloc<TransactionScreenEvent, TransactionsScreenState> {
  GetTransactions getTransactions;
  GetProfileInfo getProfileInfo;
  TransactionsScreenBloc(
    this.getTransactions,
    this.getProfileInfo,
  ) : super(TransactionsScreenState.initial()) {
    on<GetUserTransactions>((event, emit) async {
      final optionUser = await getProfileInfo();
      await emit.onEach<Option<List<Transaction>>>(
        optionUser.fold(() => Stream.empty(),
            (user) => getTransactions(TransactionUserId(user.id.value))),
        onData: (optionTransactions) => optionTransactions.fold(
          () {
            print('naaaa');
          },
          (transactions) => emit(state.copyWith(transactions: transactions)),
        ),
      );
    });
  }
}