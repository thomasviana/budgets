part of 'edit_account_screen_bloc.dart';

class EditAccountScreenState {
  final Account? account;
  final bool isLoading;
  final bool isEditMode;

  EditAccountScreenState({
    this.account,
    required this.isLoading,
    required this.isEditMode,
  });

  factory EditAccountScreenState.initial() => EditAccountScreenState(
        isLoading: false,
        isEditMode: true,
      );

  EditAccountScreenState copyWith({
    Account? account,
    bool? isLoading,
    bool? isEditMode,
  }) {
    return EditAccountScreenState(
      account: account ?? this.account,
      isLoading: isLoading ?? this.isLoading,
      isEditMode: isEditMode ?? this.isEditMode,
    );
  }
}
