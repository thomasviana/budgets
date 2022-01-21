import 'package:bloc/bloc.dart';
import 'package:budgets/core/categories/application.dart';
import 'package:budgets/core/categories/domain.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/transactions/application.dart';
import '../../../../core/transactions/domain.dart';
import '../../../../core/user/application.dart';

part 'transactions_screen_state.dart';

@injectable
class TransactionsScreenCubit extends Cubit<TransactionsScreenState> {
  GetTransactions getTransactions;
  GetProfileInfo getProfileInfo;
  AddTransaction createTransaction;
  GetSubCategories getSubCategories;

  TransactionsScreenCubit(
    this.getTransactions,
    this.getProfileInfo,
    this.createTransaction,
    this.getSubCategories,
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

  Future<void> getSubCategory(TransactionCategoryId? id) async {
    getSubCategories(CategoryId(id!.value)).then(
      (optionSubCategories) => optionSubCategories.fold(
        () => emit(state.copyWith(subCategories: [])),
        (subCategories) => emit(state.copyWith(subCategories: subCategories)),
      ),
    );
  }
}
