import 'package:budgets/src/models/user_model.dart';
import 'package:budgets/src/providers/firebase_provider.dart';
import 'dart:io';

import 'package:budgets/src/repository/user_repository.dart';

class UserRepository extends UserRepositoryBase {
  final provider = FirebaseProvider();

  @override
  Future<UserModel?> getUser() async {
    provider.getUser();
  }

  @override
  Future<void> saveUser(UserModel user, File? image) async {
    provider.saveUser(user, image);
  }
}
