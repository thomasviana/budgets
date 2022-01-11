import 'package:bloc/bloc.dart';
import 'package:budgets/core/transactions/domain.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/budgets/application.dart';
import '../../../../core/budgets/domain.dart';
import '../../../../core/user/application.dart';
import '../../../../core/user/domain.dart';

part 'edit_transaction_screen_state.dart';

@injectable
class EditTransactionScreenCubit extends Cubit<EditTransactionScreenState> {
  UpdateTransaction updateTransaction;
  DeleteTransaction deleteTransaction;
  GetProfileInfo getProfileInfo;
  CreateTransaction createTransaction;

  EditTransactionScreenCubit(
    this.updateTransaction,
    this.deleteTransaction,
    this.getProfileInfo,
    this.createTransaction,
  ) : super(EditTransactionScreenState.initial());

  Future<void> init(Transaction? transaction) async {
    if (transaction != null) {
      emit(state.copyWith(transaction: transaction));
      final userOption = await getProfileInfo();
      userOption.fold(
        () => emit(state.copyWith(user: UserEntity.empty())),
        (user) => emit(state.copyWith(user: user)),
      );
    } else {
      emit(state.copyWith(isEditMode: false, transaction: Transaction.empty()));
      final userOption = await getProfileInfo();
      userOption.fold(
        () => emit(state.copyWith(user: UserEntity.empty())),
        (user) => emit(state.copyWith(user: user)),
      );
    }
  }

  Future<void> onTransactionDeleted() async {
    await deleteTransaction(state.transaction!.id);
  }

  Future<void> onTransactionSaved({bool isNewTransaction = false}) async {
    if (isNewTransaction) {
      await createTransaction(
        budgetUserId: TransactionUserId(state.user!.id.value),
        name: state.transaction!.name,
        color: state.transaction!.color,
        abbreviation: state.transaction!.abbreviation,
        balance: state.transaction!.balance,
      );
    } else {
      await updateTransaction(
        userId: TransactionUserId(state.user!.id.value),
        budgetId: state.transaction!.id,
        name: state.transaction!.name,
        color: state.transaction!.color,
        abbreviation: state.transaction!.abbreviation,
        balance: state.transaction!.balance,
      );
    }
  }

  Future<void> onColorUpdated(int newColor) async {
    emit(
      state.copyWith(
        transaction: state.transaction!..updateColor(newColor),
      ),
    );
  }

  void onNameChanged(String? name) {
    emit(
      state.copyWith(
        transaction: state.transaction!..updateName(name!),
      ),
    );
  }

  void onAbbreviationChanged(String? abbreviation) {
    emit(
      state.copyWith(
        transaction: state.transaction!..updateAbbreviation(abbreviation),
      ),
    );
  }

  void onBalanceChanged(double newBalance) {
    emit(
      state.copyWith(
        transaction: state.transaction!..updateBalance(newBalance),
      ),
    );
  }
}
