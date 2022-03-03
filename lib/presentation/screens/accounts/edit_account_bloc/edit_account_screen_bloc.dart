import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/accounts/application.dart';
import '../../../../core/accounts/domain.dart';
import '../../../../core/user/application.dart';

part 'edit_account_screen_event.dart';
part 'edit_account_screen_state.dart';

@injectable
class EditAccountScreenBloc
    extends Bloc<EditAccountScreenEvent, EditAccountScreenState> {
  UpdateAccount updateAccount;
  DeleteAccount deleteAccount;
  GetProfileInfo getProfileInfo;
  CreateAccount createAccount;
  EditAccountScreenBloc(
    this.updateAccount,
    this.deleteAccount,
    this.getProfileInfo,
    this.createAccount,
  ) : super(EditAccountScreenState.initial()) {
    on<CheckAccount>((event, emit) {
      event.account != null
          ? emit(
              state.copyWith(
                account: event.account,
                isEditMode: true,
                isLoading: false,
              ),
            )
          : emit(
              state.copyWith(
                account: Account.empty(),
                isEditMode: false,
                isLoading: false,
              ),
            );
    });
    on<AccountDeleted>(
      (event, emit) async => deleteAccount(state.account!.id),
    );
    on<AccountSaved>(
      (event, emit) => getProfileInfo().then(
        (userOption) => userOption.fold(
          () {},
          (user) async {
            if (!state.isEditMode) {
              await createAccount(
                name: state.account!.name,
                color: state.account!.color,
                type: state.account!.type,
                imageUrl: state.account!.imageUrl,
              );
            } else {
              await updateAccount(
                accountId: state.account!.id,
                name: state.account!.name,
                color: state.account!.color,
                type: state.account!.type,
                imageUrl: state.account!.imageUrl,
              );
            }
          },
        ),
      ),
    );
    on<ColorUpdated>(
      (event, emit) => emit(
        state.copyWith(account: state.account!.copyWith(color: event.color)),
      ),
    );
    on<LogoSelected>(
      (event, emit) => emit(
        state.copyWith(
          account: state.account!.copyWith(imageUrl: event.imageUrl),
        ),
      ),
    );
    on<LogoDeleted>(
      (event, emit) => state.copyWith(
        account: state.account!.copyWith(imageUrl: null), //TODO: Use Option
      ),
    );
    on<NameChanged>(
      (event, emit) => emit(
        state.copyWith(account: state.account!.copyWith(name: event.name)),
      ),
    );
    on<TypeChanged>(
      (event, emit) => emit(
        state.copyWith(
          account: state.account!.copyWith(type: event.accountType),
        ),
      ),
    );
    on<BalanceChanged>(
      (event, emit) => emit(
        state.copyWith(
          account: state.account!.copyWith(balance: event.balance),
        ),
      ),
    );
  }
}
