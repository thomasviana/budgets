import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/transactions/application.dart';
import '../../../../core/transactions/domain.dart';
import '../../utils/observer.dart';

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
    on<TransactionsRequested>(_onTransactionsRequested);
    on<TransactionDeleted>(_onTransactionDeleted);
    on<TxsDateUpdated>(_onTxsDateUpdated);
    on<ToggleSortOption>(_onToggleSortOption);
  }

  Future<void> _onTransactionsRequested(
    TransactionsRequested event,
    Emitter emit,
  ) async {
    await emit.onEach<Option<List<Transaction>>>(
      getTransactions(),
      onData: (optionTransactions) => optionTransactions.fold(
        () => emit(
          state.copyWith(
            transactions: [],
            status: Status.failure,
          ),
        ),
        (transactions) => emit(
          state.copyWith(
            transactions: transactions,
            status: Status.success,
          ),
        ),
      ),
    );
  }

  Future<void> _onTransactionDeleted(
    TransactionDeleted event,
    Emitter emit,
  ) =>
      deleteTransaction(event.transactionId);

  Future<void> _onTxsDateUpdated(TxsDateUpdated event, Emitter emit) async =>
      emit(state.copyWith(date: event.date));

  Future<void> _onToggleSortOption(
    ToggleSortOption event,
    Emitter emit,
  ) async {
    if (state.sortOption == SortOption.ascending) {
      emit(state.copyWith(sortOption: SortOption.descending));
    } else {
      emit(state.copyWith(sortOption: SortOption.ascending));
    }
  }
}
