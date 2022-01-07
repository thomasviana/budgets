import 'package:budgets/presentation/resources/colors.dart';
import 'package:budgets/presentation/resources/logos.dart';
import 'package:uuid/uuid.dart';

import '../../../../common/value_objects.dart';

class Account extends Entity<AccountId> {
  String name;
  int icon;
  int color;
  String imageUrl;
  double amount;
  AccountUserId? accountUserId;

  Account({
    required AccountId id,
    required this.name,
    required this.icon,
    required this.color,
    this.imageUrl = 'https://www.csvtasaciones.com/images/cash-icon.png',
    this.amount = 0,
    this.accountUserId,
  }) : super(id);

  // ignore: use_setters_to_change_properties
  void setUserId(String userId) => accountUserId = AccountUserId(userId);
  // ignore: use_setters_to_change_properties
  void updateName(String newName) => name = newName;
  // ignore: use_setters_to_change_properties
  void updateIcon(int newIcon) => icon = newIcon;
  // ignore: use_setters_to_change_properties
  void updateColor(int newColor) => color = newColor;
  // ignore: use_setters_to_change_properties
  void updateImageUrl(String newImageUrl) => imageUrl = newImageUrl;
  // ignore: use_setters_to_change_properties
  void updateAmount(double newAmount) => amount = newAmount;

  factory Account.bancolombia() => Account(
        id: AccountId('bancolombia'),
        name: 'Bancolombia',
        icon: 0xe5f9,
        color: AppColors.primaryColor.value,
        imageUrl: AccountDefaultLogos.bancolombia,
      );

  factory Account.davivienda() => Account(
        id: AccountId('davivienda'),
        name: 'Davivienda',
        icon: 0xe5f9,
        color: AppColors.primaryColor.value,
        imageUrl: AccountDefaultLogos.davivienda,
      );

  factory Account.cash() => Account(
        id: AccountId('cash'),
        name: 'Efectivo',
        icon: 0xe5f9,
        color: AppColors.primaryColor.value,
        imageUrl: AccountDefaultLogos.cash,
      );

  factory Account.wallet() => Account(
        id: AccountId('wallet'),
        name: 'Billetera',
        icon: 0xe5f9,
        color: AppColors.primaryColor.value,
        imageUrl: AccountDefaultLogos.wallet,
      );

  static List<Account> get defaultAccounts {
    return [
      Account.bancolombia(),
      Account.davivienda(),
      Account.cash(),
      Account.wallet(),
    ];
  }
}

class AccountId extends AlphanumericId {
  const AccountId(String value) : super(value);

  AccountId.auto() : this(const Uuid().v1());
}

class AccountUserId extends AlphanumericId {
  const AccountUserId(String value) : super(value);

  AccountUserId.auto() : this(const Uuid().v1());
}
