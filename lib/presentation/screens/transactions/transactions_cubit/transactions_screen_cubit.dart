import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/transactions/application.dart';
import '../../../../core/transactions/domain.dart';
import '../../../../core/user/application.dart';
import '../../../../core/user/domain.dart';

part 'transactions_screen_state.dart';

@injectable
class TransactionsScreenCubit extends Cubit<TransactionsScreenState> {
  GetTransactions getTransactions;
  GetProfileInfo getProfileInfo;
  AddTransaction createTransaction;

  TransactionsScreenCubit(
    this.getTransactions,
    this.getProfileInfo,
    this.createTransaction,
  ) : super(TransactionsScreenState.initial());

  Future<void> init() async {
    final userOption = await getProfileInfo();
    userOption.fold(
      () => null,
      (user) => emit(state.copyWith(user: user, isLoading: false)),
    );
    getUserTransactions();
  }

  Future<void> getUserTransactions() async {
    final userTransactions =
        await getTransactions(TransactionUserId(state.user!.id.value));
    userTransactions.fold(
      () => null,
      (transactions) => emit(state.copyWith(transactions: transactions)),
    );
  }
}
