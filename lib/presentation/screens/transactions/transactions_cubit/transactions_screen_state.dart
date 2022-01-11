part of 'transactions_screen_cubit.dart';

class BudgetsScreenState {
  final bool isLoading;
  List<Budget> budgets;
  UserEntity? user;

  BudgetsScreenState({
    required this.isLoading,
    required this.budgets,
    this.user,
  });

  factory BudgetsScreenState.initial() => BudgetsScreenState(
        isLoading: false,
        budgets: Budget.defaultBudgets,
      );

  BudgetsScreenState copyWith({
    bool? isLoading,
    List<Budget>? budgets,
    UserEntity? user,
  }) {
    return BudgetsScreenState(
      isLoading: isLoading ?? this.isLoading,
      budgets: budgets ?? this.budgets,
      user: user ?? this.user,
    );
  }
}
