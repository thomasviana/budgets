import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import 'transactions_db.dart';

part 'transactions_table.g.dart';

enum IncomeTypeTable { active, pasive }

@DataClassName('TxDbDto')
class TxsTable extends Table {
  TextColumn get id => text().customConstraint('UNIQUE')();
  RealColumn get amount => real().withDefault(const Constant(0.0))();
  DateTimeColumn get date => dateTime()();
  TextColumn get note => text().withDefault(const Constant(''))();
  TextColumn get userId => text().nullable()();
  TextColumn get categoryId => text().nullable()();
  TextColumn get accountId => text().nullable()();
  TextColumn get budgetId => text().nullable()();
  IntColumn get incomeType => intEnum<IncomeTypeTable>().nullable()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  String get tableName => 'transactions';
}

@lazySingleton
@DriftAccessor(tables: [TxsTable])
class TxDao extends DatabaseAccessor<TxsDatabase> with _$TxDaoMixin {
  TxDao(TxsDatabase db) : super(db);

  Stream<List<TxDbDto>> getTxs(String? userId) {
    final query = select(txsTable)..where((tbl) => tbl.userId.equals(userId));
    return query.watch();
  }

  Future<void> createOrUpdate(Insertable<TxDbDto> transaction) =>
      into(txsTable).insertOnConflictUpdate(transaction);

  Future<void> deleteTx(String txId) =>
      (delete(txsTable)..where((tbl) => tbl.id.equals(txId))).go();
}
