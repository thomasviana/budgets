part of 'profile_screen_cubit.dart';

class ProfileScreenState {
  final UserEntity? userEntity;
  final bool isLoading;
  final bool isSavingForm;
  final bool isSaveButtonEnabled;

  ProfileScreenState({
    this.userEntity,
    required this.isLoading,
    required this.isSavingForm,
    required this.isSaveButtonEnabled,
  });

  factory ProfileScreenState.initial() => ProfileScreenState(
        isLoading: false,
        isSavingForm: false,
        isSaveButtonEnabled: false,
      );

  ProfileScreenState copyWith({
    UserEntity? userEntity,
    bool? isLoading,
    bool? isSavingForm,
    bool? isSaveButtonEnabled,
  }) {
    return ProfileScreenState(
      userEntity: userEntity ?? this.userEntity,
      isLoading: isLoading ?? this.isLoading,
      isSavingForm: isSavingForm ?? this.isSavingForm,
      isSaveButtonEnabled: isSaveButtonEnabled ?? this.isSaveButtonEnabled,
    );
  }
}
