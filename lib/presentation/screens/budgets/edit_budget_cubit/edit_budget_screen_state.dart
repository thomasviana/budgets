part of 'edit_budget_screen_cubit.dart';

class EditBudgetScreenState {
  final Budget? budget;
  final UserEntity? user;
  final bool isLoading;
  final bool isEditMode;

  EditBudgetScreenState({
    this.budget,
    this.user,
    required this.isLoading,
    required this.isEditMode,
  });

  factory EditBudgetScreenState.initial() => EditBudgetScreenState(
        isLoading: false,
        isEditMode: true,
      );

  EditBudgetScreenState copyWith({
    Budget? budget,
    UserEntity? user,
    bool? isLoading,
    bool? isSaving,
    bool? isEditMode,
  }) {
    return EditBudgetScreenState(
      budget: budget ?? this.budget,
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      isEditMode: isEditMode ?? this.isEditMode,
    );
  }
}
