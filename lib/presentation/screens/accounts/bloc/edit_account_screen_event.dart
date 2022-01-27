part of 'edit_account_screen_bloc.dart';

abstract class EditAccountScreenEvent {}

class CheckAccount extends EditAccountScreenEvent {
  final Account? account;
  CheckAccount({this.account});
}

class AccountDeleted extends EditAccountScreenEvent {}

class AccountSaved extends EditAccountScreenEvent {}

class ColorUpdated extends EditAccountScreenEvent {
  final int newColor;
  ColorUpdated({required this.newColor});
}

class LogoSelected extends EditAccountScreenEvent {
  final String imageUrl;
  LogoSelected({required this.imageUrl});
}

class LogoDeleted extends EditAccountScreenEvent {}
