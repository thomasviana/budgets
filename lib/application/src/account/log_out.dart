import 'package:injectable/injectable.dart';

import '../../../domain/account.dart';

@injectable
class LogOut {
  final AuthService _authService;

  LogOut(
    this._authService,
  );

  Future<void> call() async {
    _authService.logOut();
  }
}
