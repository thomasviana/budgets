import 'package:budgets/domain/account.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class CheckAuthStatus {
  final AuthService _authService;

  CheckAuthStatus(this._authService);

  Future<Option<UserEntity>> call() async => _authService.getUser();
}
