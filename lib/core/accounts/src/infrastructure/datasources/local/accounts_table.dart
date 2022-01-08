import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import 'accounts_db.dart';

part 'accounts_table.g.dart';

enum AccountTypeTable { bank, cash, wallet }

@DataClassName('AccountDbDto')
class AccountsTable extends Table {
  TextColumn get id => text().customConstraint('UNIQUE')();
  TextColumn get name => text()();
  IntColumn get type => intEnum<AccountTypeTable>()();
  IntColumn get color => integer()();
  TextColumn get imageUrl => text().nullable()();
  RealColumn get balance => real().withDefault(const Constant(0.0))();
  TextColumn get userId => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  String get tableName => 'accounts';
}

@lazySingleton
@DriftAccessor(tables: [AccountsTable])
class AccountDao extends DatabaseAccessor<AccountsDatabase>
    with _$AccountDaoMixin {
  AccountDao(AccountsDatabase db) : super(db);

  Stream<List<AccountDbDto>> getAccounts(String? userId) {
    final query = select(accountsTable)
      ..where((tbl) => tbl.userId.equals(userId));
    return query.watch();
  }

  Future<void> createOrUpdate(Insertable<AccountDbDto> account) =>
      into(accountsTable).insertOnConflictUpdate(account);

  Future<void> deleteAccount(String accountId) =>
      (delete(accountsTable)..where((tbl) => tbl.id.equals(accountId))).go();
}
