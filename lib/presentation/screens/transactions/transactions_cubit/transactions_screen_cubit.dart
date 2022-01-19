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
    getProfileInfo().then(
      (optionUser) => optionUser.fold(
        () {},
        (user) => getTransactions(TransactionUserId(user.id.value)).then(
          (optionTransactions) => optionTransactions.fold(
            () {},
            (transactions) => emit(state.copyWith(transactions: transactions)),
          ),
        ),
      ),
    );
  }
}
