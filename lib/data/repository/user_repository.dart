import 'dart:io';

import '../models/user_model.dart';

abstract class UserRepositoryBase {
  Future<UserModel?> getUser();
  Future<void> saveUser(UserModel user, File? image);
}
