import 'package:budgets/domain/account.dart';
import 'package:injectable/injectable.dart';

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
