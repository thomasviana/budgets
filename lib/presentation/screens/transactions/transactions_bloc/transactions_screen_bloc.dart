import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/transactions/application.dart';
import '../../../../core/transactions/domain.dart';

part 'transactions_screen_event.dart';
part 'transactions_screen_state.dart';

@injectable
class TransactionsScreenBloc
    extends Bloc<TransactionScreenEvent, TransactionsScreenState> {
  GetTransactions getTransactions;
  DeleteTransaction deleteTransaction;
  TransactionsScreenBloc(
    this.getTransactions,
    this.deleteTransaction,
  ) : super(TransactionsScreenState.initial()) {
    on<GetUserTransactions>((event, emit) async {
      await emit.onEach<Option<List<Transaction>>>(
        getTransactions(),
        onData: (optionTransactions) => optionTransactions.fold(
          () => emit(state.copyWith(transactions: [], date: event.date)),
          (transactions) => emit(
            state.copyWith(transactions: transactions, date: event.date),
          ),
        ),
      );
    });

    on<TransactionDeleted>(
      (event, emit) async => deleteTransaction(event.transactionId),
    );

    on<DateUpdated>((event, emit) => emit(state.copyWith(date: event.date)));
  }
}
