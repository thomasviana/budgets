part of 'home_screen_bloc.dart';

class HomeScreenState {
  final UserEntity user;
  final List<Budget> budgets;
  final Map<Budget, Map<String, double>> budgetsInfo;
  final bool isLoading;
  HomeScreenState({
    required this.user,
    required this.budgets,
    required this.budgetsInfo,
    required this.isLoading,
  });

  factory HomeScreenState.initial() => HomeScreenState(
        user: UserEntity.empty(),
        budgets: [],
        budgetsInfo: {},
        isLoading: true,
      );

  HomeScreenState copyWith({
    UserEntity? user,
    List<Budget>? budgets,
    Map<Budget, Map<String, double>>? budgetsInfo,
    bool? isLoading,
  }) {
    return HomeScreenState(
      user: user ?? this.user,
      budgets: budgets ?? this.budgets,
      budgetsInfo: budgetsInfo ?? this.budgetsInfo,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
