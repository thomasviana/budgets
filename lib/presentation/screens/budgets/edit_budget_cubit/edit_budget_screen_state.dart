part of 'edit_budget_screen_cubit.dart';

class EditBudgetScreenState {
  final Budget? budget;
  final UserEntity? user;
  final bool isLoading;
  final bool isSaving;
  final bool isEditMode;

  EditBudgetScreenState({
    this.budget,
    this.user,
    required this.isLoading,
    required this.isSaving,
    required this.isEditMode,
  });

  factory EditBudgetScreenState.initial() => EditBudgetScreenState(
        isLoading: false,
        isSaving: false,
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
      isSaving: isSaving ?? this.isSaving,
      isEditMode: isEditMode ?? this.isEditMode,
    );
  }
}
