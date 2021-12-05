import 'package:injectable/injectable.dart';

import '../../../domain/account.dart';

@injectable
class UpdateUserInfo {
  final AuthService _authService;
  UpdateUserInfo(
    this._authService,
  );

  Future<void> call(UserEntity user) => _authService.saveUser(user);
}
