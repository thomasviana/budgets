part of 'user_cubit.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

class UserLoadingState extends UserState {}

class UserReadyState extends UserState {
  final UserModel user;
  final File? pickedImage;

  const UserReadyState(
    this.user,
    this.pickedImage,
  );

  @override
  List<Object?> get props => [user, pickedImage?.path];
}
