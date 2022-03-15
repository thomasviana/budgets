part of 'profile_sceen_bloc.dart';

enum FormStatus { initial, saving, saved, done }

class ProfileScreenState extends MyState with EquatableMixin {
  final UserEntity? user;
  final FormStatus formStatus;
  final bool isSaveButtonEnabled;

  const ProfileScreenState({
    required Status status,
    required this.user,
    required this.formStatus,
    required this.isSaveButtonEnabled,
  }) : super(status: status);

  factory ProfileScreenState.initial() => ProfileScreenState(
        status: Status.initial,
        user: UserEntity.empty(),
        formStatus: FormStatus.initial,
        isSaveButtonEnabled: false,
      );

  ProfileScreenState copyWith({
    Status? status,
    UserEntity? user,
    FormStatus? formStatus,
    bool? isSaveButtonEnabled,
  }) {
    return ProfileScreenState(
      status: status ?? this.status,
      user: user ?? this.user,
      formStatus: formStatus ?? this.formStatus,
      isSaveButtonEnabled: isSaveButtonEnabled ?? this.isSaveButtonEnabled,
    );
  }

  @override
  List<Object?> get props => [status, user, formStatus, isSaveButtonEnabled];
}
