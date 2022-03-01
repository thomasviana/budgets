part of 'home_screen_bloc.dart';

class HomeScreenState {
  final List<Budget> budgets;
  final Map<Budget, Map<String, double>> budgetsInfo;
  final bool isLoading;
  HomeScreenState({
    required this.budgets,
    required this.budgetsInfo,
    required this.isLoading,
  });

  factory HomeScreenState.initial() => HomeScreenState(
        budgets: [],
        budgetsInfo: {},
        isLoading: true,
      );

  HomeScreenState copyWith({
    List<Budget>? budgets,
    final Map<Budget, Map<String, double>>? budgetsInfo,
    bool? isLoading,
  }) {
    return HomeScreenState(
      budgets: budgets ?? this.budgets,
      budgetsInfo: budgetsInfo ?? this.budgetsInfo,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
