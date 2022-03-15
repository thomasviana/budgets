import 'dart:async';

import 'package:injectable/injectable.dart';

import '../../domain.dart';

@injectable
class CheckAuthStatus {
  final AuthService _authService;

  CheckAuthStatus(this._authService);

  Stream<UserEntity?> call() => _authService.getUser();
}
