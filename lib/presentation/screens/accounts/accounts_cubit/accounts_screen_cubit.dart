import 'package:bloc/bloc.dart';
import 'package:budgets/core/accounts/application.dart';
import 'package:budgets/core/accounts/domain.dart';
import 'package:budgets/core/user/application.dart';
import 'package:budgets/core/user/domain.dart';
import 'package:injectable/injectable.dart';

part 'accounts_screen_state.dart';

@injectable
class AccountsScreenCubit extends Cubit<AccountsScreenState> {
  GetAccounts getAccounts;
  GetProfileInfo getProfileInfo;
  SaveAccounts saveAccounts;
  CreateAccount createAccount;

  AccountsScreenCubit(
    this.getAccounts,
    this.getProfileInfo,
    this.createAccount,
    this.saveAccounts,
  ) : super(AccountsScreenState.initial());

  Future<void> init() async {
    final userOption = await getProfileInfo();
    userOption.fold(
      () => null,
      (user) {
        emit(
          state.copyWith(
            user: user,
            isLoading: false,
          ),
        );
      },
    );
    getUserAccounts();
  }

  Future<void> getUserAccounts() async {
    final userAccounts = await getAccounts(AccountUserId(state.user!.id.value));
    userAccounts.fold(
      () => _setDefaultAccounts(),
      (accounts) => emit(state.copyWith(accounts: accounts)),
    );
  }

  Future<void> _setDefaultAccounts() async {
    final accounts = Account.defaultAccounts;
    for (final account in accounts) {
      account.setUserId(state.user!.id.value);
    }
    await saveAccounts(accounts: accounts);
  }
}
