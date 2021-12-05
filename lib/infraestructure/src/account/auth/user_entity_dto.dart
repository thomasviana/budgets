import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/account.dart';
import '../../../../domain/core.dart';

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
    required String? photoUrl,
  }) = _UserEntityDTO;

  factory UserEntityDTO.fromDomain(UserEntity userEntity) {
    return UserEntityDTO(
      id: userEntity.id.getOrCrash(),
      name: userEntity.name!.getOrCrash(),
      emailAddress: userEntity.emailAddress!.getOrCrash(),
      phoneNumber: userEntity.phoneNumber!.getOrCrash(),
      photoUrl: userEntity.photoUrl,
    );
  }

  UserEntity toDomain() {
    return UserEntity(
      id: UniqueId.fromUniqueString(id!),
      name: UserName(name!),
      emailAddress: EmailAddress(emailAddress!),
      phoneNumber: PhoneNumber(phoneNumber!),
      photoUrl: photoUrl,
    );
  }

  factory UserEntityDTO.fromFirebaseMap(Map<String?, Object?> data) {
    return UserEntityDTO(
      id: data['id']! as String,
      name: data['name']! as String,
      emailAddress: data['email']! as String,
      phoneNumber: data['phoneNumber']! as String,
      photoUrl: data['photoUrl'] as String?,
    );
  }

  Map<String, Object?> toFirebaseMap({String? newImage}) {
    return <String, Object?>{
      'id': id,
      'name': name,
      'email': emailAddress,
      'phoneNumber': phoneNumber,
      'photoUrl': photoUrl ?? photoUrl,
    };
  }
}
