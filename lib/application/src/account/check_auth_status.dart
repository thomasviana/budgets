import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/account.dart';

@injectable
class CheckAuthStatus {
  final AuthService _authService;

  CheckAuthStatus(this._authService);

  Future<Option<UserEntity>> call() async => _authService.getUser();
}
