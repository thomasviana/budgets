import 'package:bloc/bloc.dart';
import 'package:budgets/core/transactions/application.dart';
import 'package:budgets/core/transactions/domain.dart';
import 'package:budgets/core/user/application.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

part 'transactions_screen_event.dart';
part 'transactions_screen_state.dart';

@injectable
class TransactionsScreenBloc
    extends Bloc<TransactionScreenEvent, TransactionsScreenState> {
  GetTransactions getTransactions;
  GetProfileInfo getProfileInfo;
  DeleteTransaction deleteTransaction;
  TransactionsScreenBloc(
    this.getTransactions,
    this.getProfileInfo,
    this.deleteTransaction,
  ) : super(TransactionsScreenState.initial()) {
    on<GetUserTransactions>((event, emit) async {
      final optionUser = await getProfileInfo();
      await emit.onEach<Option<List<Transaction>>>(
        optionUser.fold(() => Stream.empty(),
            (user) => getTransactions(TransactionUserId(user.id.value))),
        onData: (optionTransactions) => optionTransactions.fold(
          () {},
          (transactions) => emit(state.copyWith(transactions: transactions)),
        ),
      );
    });

    on<TransactionDeleted>(
      (event, emit) async => deleteTransaction(event.transactionId),
    );
  }
}
