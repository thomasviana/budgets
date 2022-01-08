import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain.dart';
import '../../../../infrastructure.dart';

@lazySingleton
class AccountMapper {
  const AccountMapper();

  Account fromDbDto(AccountDbDto dto) {
    final id = AccountId(dto.id);
    final userId = AccountUserId(dto.userId!);
    final accountType = AccountType.values[dto.type.index];

    return Account(
      id: id,
      name: dto.name,
      type: accountType,
      color: dto.color,
      balance: dto.balance,
      imageUrl: dto.imageUrl,
      accountUserId: userId,
    );
  }

  List<Account> fromDbDtoList(List<AccountDbDto> dtos) =>
      dtos.map((dto) => fromDbDto(dto)).toList();

  AccountsTableCompanion toDbDto(Account account) {
    final accountType = AccountTypeTable.values[account.type.index];
    return AccountsTableCompanion(
      id: Value(account.id.value),
      name: Value(account.name),
      type: Value(accountType),
      color: Value(account.color),
      balance: Value(account.balance),
      imageUrl: Value(account.imageUrl),
      userId: Value(account.accountUserId!.value),
    );
  }

  List<AccountsTableCompanion> toDbDtoList(List<Account> accounts) {
    return accounts.map((account) => toDbDto(account)).toList();
  }
}
