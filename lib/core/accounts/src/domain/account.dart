import 'package:uuid/uuid.dart';

import '../../../../common/value_objects.dart';
import '../../../../presentation/resources/colors.dart';

enum AccountType { bank, cash, wallet }

class Account extends Entity<AccountId> {
  String name;
  AccountType type;
  int color;
  String? imageUrl;
  double balance;
  AccountUserId? accountUserId;

  Account({
    required AccountId id,
    required this.name,
    required this.type,
    required this.color,
    this.imageUrl,
    this.balance = 0,
    this.accountUserId,
  }) : super(id);

  Account copyWith({
    String? name,
    AccountType? type,
    int? color,
    String? imageUrl,
    double? balance,
    AccountUserId? accountUserId,
  }) {
    return Account(
      id: id,
      name: name ?? this.name,
      type: type ?? this.type,
      color: color ?? this.color,
      imageUrl: imageUrl ?? this.imageUrl,
      balance: balance ?? this.balance,
      accountUserId: accountUserId,
    );
  }

  // ignore: use_setters_to_change_properties
  void setUserId(String userId) => accountUserId = AccountUserId(userId);
  // ignore: use_setters_to_change_properties
  void updateName(String newName) => name = newName;
  // ignore: use_setters_to_change_properties
  void updateType(AccountType newType) => type = newType;
  // ignore: use_setters_to_change_properties
  void updateColor(int newColor) => color = newColor;
  // ignore: use_setters_to_change_properties
  void updateImageUrl(String? newImageUrl) => imageUrl = newImageUrl;
  // ignore: use_setters_to_change_properties
  void updateBalance(double newBalance) => balance = newBalance;

  int get icon {
    if (type == AccountType.bank) return 0xe040;
    if (type == AccountType.cash) return 0xf8cf;
    if (type == AccountType.wallet) return 0xe041;
    return 0xe041;
  }

  String get typeAsString {
    if (type == AccountType.bank) return 'Cuenta bancaria';
    if (type == AccountType.cash) return 'Efectivo';
    if (type == AccountType.wallet) return 'Billetera';
    return 'Cuenta bancaria';
  }

  factory Account.empty() => Account(
        id: AccountId.auto(),
        name: '',
        type: AccountType.bank,
        color: AppColors.primaryColor.value,
      );

  factory Account.bank() => Account(
        id: AccountId('bank'),
        name: 'Cuenta bancaria',
        type: AccountType.bank,
        color: AppColors.primaryColor.value,
        // imageUrl: AccountDefaultLogos.bancolombia,
      );

  factory Account.cash() => Account(
        id: AccountId('cash'),
        name: 'Efectivo',
        type: AccountType.cash,
        color: AppColors.primaryColor.value,
        // imageUrl: AccountDefaultLogos.cash,
      );

  factory Account.wallet() => Account(
        id: AccountId('wallet'),
        name: 'Billetera',
        type: AccountType.wallet,
        color: AppColors.primaryColor.value,
        // imageUrl: AccountDefaultLogos.wallet,
      );

  static List<Account> get defaultAccounts {
    return [
      Account.bank(),
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
