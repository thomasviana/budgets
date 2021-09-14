import 'dart:io';

import 'package:budgets/data/models/user_model.dart';

abstract class UserRepositoryBase {
  Future<UserModel?> getUser();
  Future<void> saveUser(UserModel user, File? image);
}
