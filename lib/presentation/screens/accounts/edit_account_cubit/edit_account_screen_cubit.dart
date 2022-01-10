import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/accounts/application.dart';
import '../../../../core/accounts/domain.dart';
import '../../../../core/user/application.dart';
import '../../../../core/user/domain.dart';

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

  Future<void> init(Account? account) async {
    if (account != null) {
      emit(state.copyWith(account: account));
      final userOption = await getProfileInfo();
      userOption.fold(
        () => emit(
          state.copyWith(
            user: UserEntity.empty(),
          ),
        ),
        (user) => emit(
          state.copyWith(
            user: user,
          ),
        ),
      );
    } else {
      emit(state.copyWith(isEditMode: false, account: Account.empty()));
      final userOption = await getProfileInfo();
      userOption.fold(
        () => emit(
          state.copyWith(
            user: UserEntity.empty(),
          ),
        ),
        (user) => emit(
          state.copyWith(
            user: user,
          ),
        ),
      );
    }
  }

  void onNameChanged(String? name) {
    if (state.account == null) return;
    emit(
      state.copyWith(
        account: state.account!..updateName(name!),
      ),
    );
  }

  Future<void> onAccountDeleted() async {
    await deleteAccount(state.account!.id);
  }

  Future<void> onAccountSaved({bool isNewAccount = false}) async {
    if (isNewAccount) {
      await createAccount(
        accountUserId: AccountUserId(state.user!.id.value),
        name: state.account!.name,
        color: state.account!.color,
        type: state.account!.type,
        imageUrl: state.account!.imageUrl,
        balance: state.account!.balance,
      );
    } else {
      await updateAccount(
        userId: AccountUserId(state.user!.id.value),
        accountId: state.account!.id,
        name: state.account!.name,
        color: state.account!.color,
        type: state.account!.type,
        imageUrl: state.account!.imageUrl,
        balance: state.account!.balance,
      );
    }
  }

  Future<void> onColorUpdated(int newColor) async {
    emit(
      state.copyWith(
        account: state.account!..updateColor(newColor),
      ),
    );
  }

  Future<void> onTypeUpdated(AccountType newType) async {
    emit(
      state.copyWith(
        account: state.account!..updateType(newType),
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

  void onBalanceChanged(double newBalance) {
    if (state.account == null) return;
    emit(
      state.copyWith(
        account: state.account!..updateBalance(newBalance),
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
}
