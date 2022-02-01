part of 'settings_bloc.dart';

abstract class SettingsEvent {}

class GetUserAccounts extends SettingsEvent {}

class GetUserCategories extends SettingsEvent {}

class GetUserBudgets extends SettingsEvent {}
