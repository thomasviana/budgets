part of 'edit_account_screen_cubit.dart';

class EditAccountScreenState {
  final Account? account;
  final UserEntity? user;
  final bool isLoading;
  final bool isSaving;
  final bool isEditMode;

  EditAccountScreenState({
    this.account,
    this.user,
    required this.isLoading,
    required this.isSaving,
    required this.isEditMode,
  });

  factory EditAccountScreenState.initial() => EditAccountScreenState(
        isLoading: false,
        isSaving: false,
        isEditMode: true,
      );

  EditAccountScreenState copyWith({
    Account? account,
    UserEntity? user,
    bool? isLoading,
    bool? isSaving,
    bool? isEditMode,
  }) {
    return EditAccountScreenState(
      account: account ?? this.account,
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      isSaving: isSaving ?? this.isSaving,
      isEditMode: isEditMode ?? this.isEditMode,
    );
  }
}
