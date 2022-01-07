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

    return Account(
      id: id,
      name: dto.name,
      icon: dto.icon,
      color: dto.color,
      amount: dto.amount,
      imageUrl: dto.imageUrl,
      accountUserId: userId,
    );
  }

  List<Account> fromDbDtoList(List<AccountDbDto> dtos) =>
      dtos.map((dto) => fromDbDto(dto)).toList();

  AccountsTableCompanion toDbDto(Account account) {
    return AccountsTableCompanion(
      id: Value(account.id.value),
      name: Value(account.name),
      icon: Value(account.icon),
      color: Value(account.color),
      amount: Value(account.amount),
      imageUrl: Value(account.imageUrl),
      userId: Value(account.accountUserId!.value),
    );
  }

  List<AccountsTableCompanion> toDbDtoList(List<Account> accounts) {
    return accounts.map((account) => toDbDto(account)).toList();
  }
}
