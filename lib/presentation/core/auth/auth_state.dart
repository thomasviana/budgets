part of 'auth_cubit.dart';

class AuthState {
  final bool isAuthenticated;
  final bool isUnauthenticated;

  AuthState({
    required this.isAuthenticated,
    required this.isUnauthenticated,
  });

  factory AuthState.initial() => AuthState(
        isAuthenticated: false,
        isUnauthenticated: true,
      );

  AuthState copyWith({
    bool? isAuthenticated,
    bool? isUnauthenticated,
    UserEntity? userEntity,
  }) =>
      AuthState(
        isAuthenticated: isAuthenticated ?? this.isAuthenticated,
        isUnauthenticated: isUnauthenticated ?? this.isUnauthenticated,
      );
}
