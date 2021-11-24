import 'dart:io';

import 'user_model.dart';

abstract class UserRepositoryBase {
  Future<UserModel?> getUser();
  Future<void> saveUser(UserModel user, File? image);
}
