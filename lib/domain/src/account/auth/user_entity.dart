import 'package:uuid/uuid.dart';

import '../../../core.dart';
import 'value_objects.dart';

class UserEntity extends Entity<UserId> {
  final EmailAddress emailAddress;
  late UserName? _name;
  late PhoneNumber? _phoneNumber;
  late String? _imagePath;
  late String? _photoUrl;

  UserEntity({
    required UserId id,
    required this.emailAddress,
    PhoneNumber? phoneNumber,
    UserName? name,
    String? imagePath,
    String? photoUrl,
  }) : super(id) {
    setImage(imagePath);
    setPhotoUrl(photoUrl ??
        'https://thumbs.dreamstime.com/b/vector-de-usuario-redes-sociales-perfil-avatar-predeterminado-retrato-vectorial-del-176194876.jpg');
    updateName(name!.value);
    updatePhoneNumber(phoneNumber!.value);
  }

  void setImage(String? newImagePath) {
    _imagePath = newImagePath;
  }

  void setPhotoUrl(String? newPhotoUrl) {
    _photoUrl = newPhotoUrl;
  }

  void updateName(String? newName) {
    _name = UserName(newName!);
  }

  void updatePhoneNumber(String? newPhoneNumber) {
    _phoneNumber = PhoneNumber(newPhoneNumber!);
  }

  String? get imagePath => _imagePath;
  String? get photoUrl => _photoUrl;
  UserName? get name => _name;
  PhoneNumber? get phoneNumber => _phoneNumber;

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
