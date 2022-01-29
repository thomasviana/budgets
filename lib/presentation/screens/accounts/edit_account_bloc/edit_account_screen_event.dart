part of 'edit_account_screen_bloc.dart';

abstract class EditAccountScreenEvent {}

class CheckAccount extends EditAccountScreenEvent {
  final Account? account;
  CheckAccount({this.account});
}

class AccountDeleted extends EditAccountScreenEvent {}

class AccountSaved extends EditAccountScreenEvent {}

class ColorUpdated extends EditAccountScreenEvent {
  final int color;
  ColorUpdated(this.color);
}

class LogoSelected extends EditAccountScreenEvent {
  final String imageUrl;
  LogoSelected(this.imageUrl);
}

class LogoDeleted extends EditAccountScreenEvent {}

class NameChanged extends EditAccountScreenEvent {
  final String name;
  NameChanged(this.name);
}

class TypeChanged extends EditAccountScreenEvent {
  final AccountType accountType;
  TypeChanged(this.accountType);
}

class BalanceChanged extends EditAccountScreenEvent {
  final double balance;
  BalanceChanged(this.balance);
}
