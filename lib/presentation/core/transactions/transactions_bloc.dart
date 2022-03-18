import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/transactions/application.dart';
import '../../../../core/transactions/domain.dart';

part 'transactions_event.dart';
part 'transactions_state.dart';

@injectable
class TransactionsBloc extends Bloc<TransactionEvent, TransactionsState> {
  GetTransactions getTransactions;
  DeleteTransaction deleteTransaction;
  TransactionsBloc(
    this.getTransactions,
    this.deleteTransaction,
  ) : super(TransactionsState.initial()) {
    on<TransactionsRequested>((event, emit) async {
      await emit.onEach<Option<List<Transaction>>>(
        getTransactions(),
        onData: (optionTransactions) => optionTransactions.fold(
          () => emit(
            state.copyWith(
              transactions: [],
              isLoading: false,
            ),
          ),
          (transactions) => emit(
            state.copyWith(
              transactions: transactions,
              isLoading: false,
            ),
          ),
        ),
      );
    });

    on<TransactionDeleted>(
      (event, emit) async => deleteTransaction(event.transactionId),
    );

    on<TxsDateUpdated>((event, emit) => emit(state.copyWith(date: event.date)));
  }
}
