part of 'auth_cubit.dart';

class AuthState {
  final bool isAuthenticated;
  final bool isUnauthenticated;
  final UserEntity userEntity;

  AuthState({
    required this.isAuthenticated,
    required this.isUnauthenticated,
    required this.userEntity,
  });

  factory AuthState.initial() => AuthState(
        isAuthenticated: false,
        isUnauthenticated: true,
        userEntity: UserEntity.empty(),
      );

  AuthState copyWith(
          {bool? isAuthenticated,
          bool? isUnauthenticated,
          UserEntity? userEntity}) =>
      AuthState(
        isAuthenticated: isAuthenticated ?? this.isAuthenticated,
        isUnauthenticated: isUnauthenticated ?? this.isUnauthenticated,
        userEntity: userEntity ?? this.userEntity,
      );
}
