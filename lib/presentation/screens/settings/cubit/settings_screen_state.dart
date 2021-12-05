part of 'settings_screen_cubit.dart';

class SettingsScreenState {
  final UserEntity userEntity;
  final bool isLoading;

  SettingsScreenState({
    required this.userEntity,
    required this.isLoading,
  });

  factory SettingsScreenState.initial() => SettingsScreenState(
        userEntity: UserEntity.empty(),
        isLoading: false,
      );

  SettingsScreenState copyWith({
    UserEntity? userEntity,
    bool? isLoading,
  }) {
    return SettingsScreenState(
      userEntity: userEntity ?? this.userEntity,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
