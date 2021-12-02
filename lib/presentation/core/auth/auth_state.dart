part of 'auth_cubit.dart';

// class AuthState extends Equatable {
//   const AuthState();

//   @override
//   List<Object?> get props => [];
// }

// class Initial extends AuthState {}

// class Authenticated extends AuthState {}

// class Unauthenticated extends AuthState {}

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
  }) =>
      AuthState(
        isAuthenticated: isAuthenticated ?? this.isAuthenticated,
        isUnauthenticated: isUnauthenticated ?? this.isUnauthenticated,
      );
}
