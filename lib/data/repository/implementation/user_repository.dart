import 'dart:io';

import 'package:budgets/data/models/user_model.dart';
import 'package:budgets/data/providers/firebase_provider.dart';

import '../user_repository.dart';

class UserRepository extends UserRepositoryBase {
  final provider = FirebaseProvider();

  @override
  Future<UserModel?> getUser() async {
    print('try');
    return await provider.getUser();
  }

  @override
  Future<void> saveUser(UserModel user, File? image) async {
    provider.saveUser(user, image);
  }
}
