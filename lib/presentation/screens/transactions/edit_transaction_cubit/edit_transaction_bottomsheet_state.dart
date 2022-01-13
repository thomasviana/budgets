part of 'edit_transaction_bottomsheet_cubit.dart';

class EditTransactionBottomSheetState {
  final Transaction? transaction;
  final UserEntity? user;
  final bool isLoading;
  final bool isEditMode;

  EditTransactionBottomSheetState({
    this.transaction,
    this.user,
    required this.isLoading,
    required this.isEditMode,
  });

  factory EditTransactionBottomSheetState.initial() =>
      EditTransactionBottomSheetState(
        isLoading: false,
        isEditMode: true,
      );

  EditTransactionBottomSheetState copyWith({
    Transaction? transaction,
    UserEntity? user,
    bool? isLoading,
    bool? isSaving,
    bool? isEditMode,
  }) {
    return EditTransactionBottomSheetState(
      transaction: transaction ?? this.transaction,
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      isEditMode: isEditMode ?? this.isEditMode,
    );
  }
}
