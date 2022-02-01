import 'package:bloc/bloc.dart';
import 'package:budgets/core/accounts/application.dart';
import 'package:budgets/core/accounts/domain.dart';
import 'package:budgets/core/user/application.dart';
import 'package:injectable/injectable.dart';

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
          ? emit(state.copyWith(
              account: event.account, isEditMode: true, isLoading: false))
          : emit(state.copyWith(
              account: Account.empty(), isEditMode: false, isLoading: false));
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
      ),
    );
    on<ColorUpdated>(
      (event, emit) => emit(
          state.copyWith(account: state.account!..updateColor(event.color))),
    );
    on<LogoSelected>(
      (event, emit) => emit(state.copyWith(
          account: state.account!..updateImageUrl(event.imageUrl))),
    );
    on<LogoDeleted>(
      (event, emit) =>
          emit(state.copyWith(account: state.account!..updateImageUrl(null))),
    );
    on<NameChanged>(
      (event, emit) => emit(
        state.copyWith(account: state.account!..updateName(event.name)),
      ),
    );
    on<TypeChanged>(
      (event, emit) => emit(state.copyWith(
          account: state.account!..updateType(event.accountType))),
    );
    on<BalanceChanged>(
      (event, emit) => emit(state.copyWith(
          account: state.account!..updateBalance(event.balance))),
    );
  }
}
