import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core.dart';
import 'value_objects.dart';

class UserEntity {
  final UniqueId id;
  final UserName? name;
  final EmailAddress? emailAddress;
  final PhoneNumber? phoneNumber;
  final UserImage? userImage;

  UserEntity({
    required this.id,
    this.name,
    this.emailAddress,
    this.phoneNumber,
    this.userImage,
  });

  factory UserEntity.empty() => UserEntity(
        id: UniqueId(),
        name: UserName(''),
        emailAddress: EmailAddress(''),
        phoneNumber: PhoneNumber(''),
        userImage: UserImage(File('/assets/images/profile_photo.jpg')),
      );

  Option<ValueFailure<dynamic>> get failureOption {
    return name!.value.fold(
      (f) => some(f),
      (_) => none(),
    );
  }
}
