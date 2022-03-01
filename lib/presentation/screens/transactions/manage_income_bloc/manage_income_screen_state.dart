part of 'manage_income_screen_bloc.dart';

class ManageIncomeScreenState {
  final TransactionId? transactionId;
  final List<Budget>? budgets;
  final double? incomeAmount;
  final double? managedAmount;
  final double? pendingAmount;
  final bool isLoading;
  List<double>? budgetAmounts;
  List<double>? budgetPercentages;

  ManageIncomeScreenState({
    this.transactionId,
    this.budgets,
    this.incomeAmount,
    this.managedAmount = 0,
    this.pendingAmount = 0,
    required this.isLoading,
    this.budgetAmounts,
    this.budgetPercentages,
  });

  bool get isDoneEnabled => pendingAmount == 0;
  bool isDecrementEnabled(int index) =>
      budgetPercentages![index] > 0.0 + 0.1; // + step
  bool isIncrementEnabled(int index) =>
      budgetPercentages![index] < 1.0 - 0.1 && pendingAmount! > 0; // - step

  factory ManageIncomeScreenState.initial() => ManageIncomeScreenState(
        isLoading: true,
        budgetAmounts: [],
        budgetPercentages: [],
      );

  ManageIncomeScreenState copyWith({
    TransactionId? transactionId,
    List<Budget>? budgets,
    double? incomeAmount,
    double? managedAmount,
    double? pendingAmount,
    bool? isLoading,
    List<double>? budgetAmounts,
    List<double>? budgetPercentages,
  }) {
    return ManageIncomeScreenState(
      transactionId: transactionId ?? this.transactionId,
      budgets: budgets ?? this.budgets,
      incomeAmount: incomeAmount ?? this.incomeAmount,
      managedAmount: managedAmount ?? this.managedAmount,
      pendingAmount: pendingAmount ?? this.pendingAmount,
      isLoading: isLoading ?? this.isLoading,
      budgetAmounts: budgetAmounts ?? this.budgetAmounts,
      budgetPercentages: budgetPercentages ?? this.budgetPercentages,
    );
  }
}
