import 'package:dartz/dartz.dart';

import '../../../core.dart';
import 'value_objects.dart';

class UserEntity {
  final UniqueId id;
  final UserName? name;
  final EmailAddress? emailAddress;
  final PhoneNumber? phoneNumber;
  final ImagePath? imagePath;
  final String? photoUrl;

  UserEntity({
    required this.id,
    this.name,
    this.emailAddress,
    this.phoneNumber,
    this.imagePath,
    this.photoUrl,
  });

  factory UserEntity.empty() => UserEntity(
        id: UniqueId(),
        name: UserName(''),
        emailAddress: EmailAddress(''),
        phoneNumber: PhoneNumber(''),
        imagePath: ImagePath('/assets/images/profile_photo.jpg'),
        photoUrl:
            'https://thumbs.dreamstime.com/b/vector-de-usuario-redes-sociales-perfil-avatar-predeterminado-retrato-vectorial-del-176194876.jpg',
      );

  Option<ValueFailure<dynamic>> get failureOption {
    return name!.value.fold(
      (f) => some(f),
      (_) => none(),
    );
  }

  UserEntity copyWith({
    UniqueId? id,
    UserName? name,
    EmailAddress? emailAddress,
    PhoneNumber? phoneNumber,
    ImagePath? imagePath,
    String? photoUrl,
  }) {
    return UserEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      emailAddress: emailAddress ?? this.emailAddress,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      imagePath: imagePath ?? this.imagePath,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }
}
