part of 'home_screen_cubit.dart';

class HomeScreenState {
  final UserName? userName;
  final bool isLoading;
  HomeScreenState({
    required this.userName,
    required this.isLoading,
  });

  factory HomeScreenState.initial() => HomeScreenState(
        userName: UserName(''),
        isLoading: true,
      );

  HomeScreenState copyWith({
    UserName? userName,
    bool? isLoading,
  }) {
    return HomeScreenState(
      userName: userName ?? this.userName,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
