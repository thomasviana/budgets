import 'dart:io';

import 'package:budgets/domain/account.dart';
import 'package:budgets/domain/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entity_dto.freezed.dart';

@freezed
abstract class UserEntityDTO implements _$UserEntityDTO {
  const UserEntityDTO._();

  // ignore: sort_unnamed_constructors_first
  const factory UserEntityDTO({
    required String? id,
    required String? name,
    required String? emailAddress,
    required String? phoneNumber,
    required String? userImage,
  }) = _UserEntityDTO;

  factory UserEntityDTO.fromDomain(UserEntity userEntity) {
    return UserEntityDTO(
      id: userEntity.id.getOrCrash(),
      name: userEntity.name!.getOrCrash(),
      emailAddress: userEntity.emailAddress!.getOrCrash(),
      phoneNumber: userEntity.phoneNumber!.getOrCrash(),
      userImage: userEntity.userImage!.getOrCrash().path,
    );
  }

  UserEntity toDomain() {
    return UserEntity(
      id: UniqueId.fromUniqueString(id!),
      name: UserName(name!),
      emailAddress: EmailAddress(emailAddress!),
      phoneNumber: PhoneNumber(phoneNumber!),
      userImage: UserImage(File(userImage!)),
    );
  }

  factory UserEntityDTO.fromFirebaseMap(Map<String?, Object?> data) {
    return UserEntityDTO(
        id: data['id']! as String,
        name: data['name']! as String,
        emailAddress: data['email']! as String,
        phoneNumber: data['phoneNumber']! as String,
        userImage: data['image'] as String? ?? 'dd');
  }

  Map<String, Object?> toFirebaseMap({String? newImage}) {
    return <String, Object?>{
      'id': id,
      'name': name,
      'emailAddress': emailAddress,
      'phoneNumber': phoneNumber,
      'userImage': newImage ?? userImage,
    };
  }
}
