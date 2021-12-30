import 'package:uuid/uuid.dart';

import '../../../../presentation/resources/constants.dart';
import '../../../core.dart';
import 'value_objects.dart';

class UserEntity extends Entity<UserId> {
  final EmailAddress emailAddress;
  UserName? name;
  PhoneNumber? phoneNumber;
  String? imagePath;
  String? photoUrl;

  UserEntity({
    required UserId id,
    required this.emailAddress,
    this.name,
    this.phoneNumber,
    this.imagePath,
    this.photoUrl = kDefaultPhotoUrl,
  }) : super(id);

  // ignore: use_setters_to_change_properties
  void updateImagePath(String? newImagePath) => imagePath = newImagePath;
  // ignore: use_setters_to_change_properties
  void updatePhotoUrl(String? newPhotoUrl) => photoUrl = newPhotoUrl;
  void updateName(String? newName) => name = UserName(newName!);
  void updatePhoneNumber(String? newPhoneNumber) {
    phoneNumber = PhoneNumber(newPhoneNumber!);
  }

  factory UserEntity.empty() => UserEntity(
        id: UserId.auto(),
        name: UserName(''),
        emailAddress: EmailAddress(''),
        phoneNumber: PhoneNumber(''),
        imagePath: '/assets/images/profile_photo.jpg',
        photoUrl:
            'https://thumbs.dreamstime.com/b/vector-de-usuario-redes-sociales-perfil-avatar-predeterminado-retrato-vectorial-del-176194876.jpg',
      );
}

class UserId extends AlphanumericId {
  const UserId(String value) : super(value);

  UserId.auto() : this(const Uuid().v1());
}
