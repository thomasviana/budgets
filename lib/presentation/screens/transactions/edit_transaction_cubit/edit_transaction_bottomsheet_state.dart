part of 'edit_transaction_bottomsheet_cubit.dart';

class EditTransactionBottomSheetState {
  final Transaction? transaction;
  final Account? account;
  final Category? category;
  final Budget? budget;
  final UserEntity? user;
  final bool isLoading;
  final bool isEditMode;

  EditTransactionBottomSheetState({
    this.transaction,
    this.account,
    this.category,
    this.budget,
    this.user,
    required this.isLoading,
    required this.isEditMode,
  });

  factory EditTransactionBottomSheetState.initial() =>
      EditTransactionBottomSheetState(
          isLoading: false,
          isEditMode: true,
          account: Account.bank(),
          budget: Budget.seg(),
          category: Category.housing());

  EditTransactionBottomSheetState copyWith({
    Transaction? transaction,
    Account? account,
    Category? category,
    Budget? budget,
    UserEntity? user,
    bool? isLoading,
    bool? isEditMode,
  }) {
    return EditTransactionBottomSheetState(
      transaction: transaction ?? this.transaction,
      account: account ?? this.account,
      category: category ?? this.category,
      budget: budget ?? this.budget,
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      isEditMode: isEditMode ?? this.isEditMode,
    );
  }
}
