part of 'edit_budget_screen_cubit.dart';

class EditBudgetScreenState {
  final Budget? budget;
  final bool isLoading;
  final bool isEditMode;

  EditBudgetScreenState({
    this.budget,
    required this.isLoading,
    required this.isEditMode,
  });

  factory EditBudgetScreenState.initial() => EditBudgetScreenState(
        isLoading: false,
        isEditMode: true,
      );

  EditBudgetScreenState copyWith({
    Budget? budget,
    bool? isLoading,
    bool? isEditMode,
  }) {
    return EditBudgetScreenState(
      budget: budget ?? this.budget,
      isLoading: isLoading ?? this.isLoading,
      isEditMode: isEditMode ?? this.isEditMode,
    );
  }
}
