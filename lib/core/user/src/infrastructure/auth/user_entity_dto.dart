import '../../../domain.dart';

class UserEntityDTO {
  final String? id;
  final String? name;
  final String? emailAddress;
  final String? phoneNumber;
  final String? photoUrl;
  UserEntityDTO({
    this.id,
    this.name,
    this.emailAddress,
    required this.phoneNumber,
    required this.photoUrl,
  });

  factory UserEntityDTO.fromDomain(UserEntity userEntity) {
    return UserEntityDTO(
      id: userEntity.id.value,
      name: userEntity.name!.value,
      emailAddress: userEntity.emailAddress.value,
      phoneNumber: userEntity.phoneNumber!.value,
      photoUrl: userEntity.photoUrl,
    );
  }

  UserEntity toDomain() {
    return UserEntity(
      id: UserId(id!),
      name: UserName(name!),
      emailAddress: EmailAddress(emailAddress!),
      phoneNumber: PhoneNumber(phoneNumber ?? ''),
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
      'photoUrl': newImage ?? photoUrl,
    };
  }
}
