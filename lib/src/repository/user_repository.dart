import 'dart:io';

import 'package:budgets/src/models/user_model.dart';

abstract class UserRepositoryBase {
  Future<UserModel?> getUser();
  Future<void> saveUser(UserModel user, File? image);
}
