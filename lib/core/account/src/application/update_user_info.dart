import 'package:injectable/injectable.dart';

import '../../domain.dart';

@injectable
class UpdateUserInfo {
  final AuthService _authService;
  UpdateUserInfo(
    this._authService,
  );

  Future<void> call(UserEntity user) => _authService.saveUser(user);
}
