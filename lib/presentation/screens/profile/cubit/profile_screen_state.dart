part of 'profile_screen_cubit.dart';

class ProfileScreenState {
  final UserEntity userEntity;
  final bool isLoading;
  final bool isSavingForm;

  ProfileScreenState({
    required this.userEntity,
    required this.isLoading,
    required this.isSavingForm,
  });

  factory ProfileScreenState.initial() => ProfileScreenState(
        userEntity: UserEntity.empty(),
        isLoading: false,
        isSavingForm: false,
      );

  ProfileScreenState copyWith({
    UserEntity? userEntity,
    bool? isLoading,
    bool? isSavingForm,
  }) {
    return ProfileScreenState(
      userEntity: userEntity ?? this.userEntity,
      isLoading: isLoading ?? this.isLoading,
      isSavingForm: isSavingForm ?? this.isSavingForm,
    );
  }
}
