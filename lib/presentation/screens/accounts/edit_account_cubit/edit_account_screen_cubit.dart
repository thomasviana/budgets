import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/accounts/application.dart';
import '../../../../core/accounts/domain.dart';
import '../../../../core/user/application.dart';

part 'edit_account_screen_state.dart';

@injectable
class EditAccountScreenCubit extends Cubit<EditAccountScreenState> {
  UpdateAccount updateAccount;
  DeleteAccount deleteAccount;
  GetProfileInfo getProfileInfo;
  CreateAccount createAccount;

  EditAccountScreenCubit(
    this.updateAccount,
    this.deleteAccount,
    this.getProfileInfo,
    this.createAccount,
  ) : super(EditAccountScreenState.initial());

  void checkAccount(Account? account) {
    emit(state.copyWith(account: account ?? Account.empty()));
  }

  Future<void> onAccountDeleted() async {
    await deleteAccount(state.account!.id);
  }

  Future<void> onAccountSaved() async {
    getProfileInfo().then(
      (userOption) => userOption.fold(
        () {},
        (user) async {
          if (!state.isEditMode) {
            await createAccount(
              accountUserId: AccountUserId(user.id.value),
              name: state.account!.name,
              color: state.account!.color,
              type: state.account!.type,
              imageUrl: state.account!.imageUrl,
              balance: state.account!.balance,
            );
          } else {
            await updateAccount(
              userId: AccountUserId(user.id.value),
              accountId: state.account!.id,
              name: state.account!.name,
              color: state.account!.color,
              type: state.account!.type,
              imageUrl: state.account!.imageUrl,
              balance: state.account!.balance,
            );
          }
        },
      ),
    );
  }

  Future<void> onColorUpdated(int newColor) async {
    emit(
      state.copyWith(
        account: state.account!..updateColor(newColor),
      ),
    );
  }

  Future<void> onLogoSelected(String imageUrl) async {
    emit(
      state.copyWith(
        account: state.account!..updateImageUrl(imageUrl),
      ),
    );
  }

  Future<void> onLogoDeleted() async {
    emit(
      state.copyWith(
        account: state.account!..updateImageUrl(null),
      ),
    );
  }

  void onNameChanged(String? name) {
    emit(
      state.copyWith(
        account: state.account!..updateName(name!),
      ),
    );
  }

  Future<void> onTypeChanged(AccountType newType) async {
    emit(
      state.copyWith(
        account: state.account!..updateType(newType),
      ),
    );
  }

  void onBalanceChanged(double newBalance) {
    emit(
      state.copyWith(
        account: state.account!..updateBalance(newBalance),
      ),
    );
  }
}
