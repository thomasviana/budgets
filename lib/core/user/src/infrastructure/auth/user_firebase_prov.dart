import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart' as path;

import '../../../../../presentation/resources/constants.dart';
import '../../../domain.dart';
import 'user_entity_dto.dart';

@lazySingleton
class UserFirebaseProv {
  final FirebaseStorage _firebaseStorage;
  final FirebaseFirestore _firebaseFirestore;

  UserFirebaseProv(
    this._firebaseStorage,
    this._firebaseFirestore,
  );

  User? get currentUser {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception('Not authenticated exception.');
    return user;
  }

  Stream<UserEntity?> getUser() async* {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      yield null;
    } else {
      yield* _firebaseFirestore
          .doc('userTest/${user.uid}')
          .snapshots()
          .map((snapshot) {
        if (snapshot.exists) {
          final userData = UserEntityDTO.fromFirebaseMap(snapshot.data()!);
          final userEntity = userData.toDomain();
          return userEntity;
        } else {
          final registeredUser = _userFromFirebase(user);
          return registeredUser;
        }
      });
    }
  }

  UserEntity _userFromFirebase(User user) {
    return UserEntity(
      id: UserId(user.uid),
      name: UserName(user.displayName ?? ''),
      emailAddress: EmailAddress(user.email!),
      phoneNumber: PhoneNumber(user.phoneNumber ?? ''),
      photoUrl: user.photoURL ?? kDefaultPhotoUrl,
    );
  }

  Future<void> saveUser(UserEntity user) async {
    final ref = _firebaseFirestore.doc('userTest/${currentUser!.uid}');
    final userDTO = UserEntityDTO.fromDomain(user);
    if (user.imagePath == null) {
      await ref.set(userDTO.toFirebaseMap(), SetOptions(merge: true));
    } else {
      final imagePath =
          '${currentUser!.uid}/profile/${path.basename(user.imagePath!)}';
      final storageRef = _firebaseStorage.ref(imagePath);
      await storageRef.putFile(File(user.imagePath!));
      final url = await storageRef.getDownloadURL();
      await ref.set(
        userDTO.toFirebaseMap(newImage: url),
        SetOptions(merge: true),
      );
    }
  }
}
