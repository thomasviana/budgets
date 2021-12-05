import 'package:injectable/injectable.dart';

import '../../../domain/account.dart';

@injectable
class SetUserImage {
  final AuthService _authService;
  SetUserImage(
    this._authService,
  );

  Future<void> call(UserEntity user) => _authService.setProfileImage(
        user,
      );
}
