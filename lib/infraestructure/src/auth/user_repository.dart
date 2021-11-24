import 'dart:io';

import '../../../domain/auth.dart';
import 'user_firebase_provider.dart';

class UserRepository extends UserRepositoryBase {
  final provider = UserFirebaseProvider();

  @override
  Future<UserModel?> getUser() async {
    return provider.getUser();
  }

  @override
  Future<void> saveUser(UserModel user, File? image) async {
    provider.saveUser(user, image);
  }
}
