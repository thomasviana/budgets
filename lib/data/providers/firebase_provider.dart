import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

import 'package:budgets/data/models/user_model.dart';

class FirebaseProvider {
  FirebaseStorage get storage => FirebaseStorage.instance;
  FirebaseFirestore get firestore => FirebaseFirestore.instance;

  User get currentUser {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception('Not authenticated exception.');
    return user;
  }

  Future<UserModel?> getUser() async {
    final snapshot = await firestore.doc('user/${currentUser.uid}').get();
    if (snapshot.exists) {
      print(snapshot.data()!['name']);
      final userData = UserModel.fromFirebaseMap(snapshot.data()!);
      print(userData.lastName);
      return userData;
    }
    return null;
  }

  Future<void> saveUser(UserModel user, File? image) async {
    final ref = firestore.doc('user/${currentUser.uid}');
    if (image == null) {
      await ref.set(user.toFirebaseMap(), SetOptions(merge: true));
    } else {
      final imagePath =
          '${currentUser.uid}/profile/${path.basename(image.path)}';
      final storageRef = storage.ref(imagePath);
      await storageRef.putFile(image);
      final url = await storageRef.getDownloadURL();
      await ref.set(user.toFirebaseMap(newImage: url), SetOptions(merge: true));
    }
  }
}
