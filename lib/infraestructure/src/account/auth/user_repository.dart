// import 'dart:io';

// import 'package:budgets/domain/account.dart';
// import 'package:injectable/injectable.dart';

// import 'user_firebase_provider.dart';

// @LazySingleton(as: UserRepositoryBase)
// class UserRepository extends UserRepositoryBase {
//   final provider = UserFirebaseProvider();

//   @override
//   Future<UserModel?> getUser() async {
//     return provider.getUser();
//   }

//   @override
//   Future<void> saveUser(UserModel user, File? image) async {
//     provider.saveUser(user, image);
//   }
// }
