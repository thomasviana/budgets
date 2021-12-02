import 'dart:io';

import 'package:budgets/domain/account.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart' as path;

import 'user_entity_dto.dart';

@lazySingleton
class UserFirebaseProv {
  final FirebaseStorage _firebaseStorage;
  final FirebaseFirestore _firebaseFirestore;

  UserFirebaseProv(
    this._firebaseStorage,
    this._firebaseFirestore,
  );

  // FirebaseStorage get storage => FirebaseStorage.instance;
  // FirebaseFirestore get firestore => FirebaseFirestore.instance;

  User? get currentUser {
    final user = FirebaseAuth.instance.currentUser;
    // if (user == null) throw Exception('Not authenticated exception.');
    if (user == null) print('No current user found');

    return user;
  }

  Future<Option<UserEntity>> getUser() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return Future.value(none());
    } else {
      final snapshot = await _firebaseFirestore.doc('users/${user.uid}').get();
      if (snapshot.exists) {
        final userData = UserEntityDTO.fromFirebaseMap(snapshot.data()!);
        return some(userData.toDomain());
      }
      return Future.value(none());
    }
  }

  Future<void> saveUser(UserEntity user, File? image) async {
    final ref = _firebaseFirestore.doc('users/${currentUser!.uid}');
    final userDTO = UserEntityDTO.fromDomain(user);
    if (image == null) {
      await ref.set(userDTO.toFirebaseMap(), SetOptions(merge: true));
    } else {
      final imagePath =
          '${currentUser!.uid}/profile/${path.basename(image.path)}';
      final storageRef = _firebaseStorage.ref(imagePath);
      await storageRef.putFile(image);
      final url = await storageRef.getDownloadURL();
      await ref.set(
          userDTO.toFirebaseMap(newImage: url), SetOptions(merge: true));
    }
  }
}
