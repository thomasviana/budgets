import 'dart:async';

import 'package:injectable/injectable.dart';

import '../../domain.dart';

@injectable
class GetProfileInfo {
  final AuthService _authService;
  GetProfileInfo(this._authService);

  Stream<UserEntity?> call() => _authService.getUser();
}
