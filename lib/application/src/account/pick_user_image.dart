import 'package:injectable/injectable.dart';

import '../../../domain/account.dart';

@injectable
class PickUserImage {
  final AuthService _authService;
  PickUserImage(
    this._authService,
  );

  Future<void> call(UserEntity user, ImagePath userImage) =>
      _authService.setProfileImage(user);
}
