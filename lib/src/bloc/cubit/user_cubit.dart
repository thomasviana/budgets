import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:budgets/data/models/user_model.dart';
import 'package:budgets/data/repository/user_repository.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepositoryBase _userRepository;

  File? _pickedImage;
  late UserModel _user;

  UserCubit(this._userRepository) : super(UserLoadingState());

  void setImage(File? imageFile) {
    _pickedImage = imageFile;
    emit(UserReadyState(_user, _pickedImage));
  }

  Future<void> getUser() async {
    emit(UserLoadingState());
    print('getUserCubit');
    _user =
        await _userRepository.getUser() ?? UserModel('Thomas', 'Viasna', 'sss');
    print('close getUserCubit');
    emit(UserReadyState(_user, _pickedImage));
  }

  Future<void> saveUser(String uid, String name, String lastName) async {
    _user = UserModel(uid, name, lastName, image: _user.image);
    emit(UserReadyState(_user, _pickedImage, isSaving: true));

    await _userRepository.saveUser(_user, _pickedImage);
    emit(UserReadyState(_user, _pickedImage, isSaving: false));
  }
}
