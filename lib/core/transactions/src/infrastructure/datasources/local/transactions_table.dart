import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import 'transactions_db.dart';

part 'transactions_table.g.dart';

enum IncomeTypeTable { active, pasive }

@DataClassName('TransactionDbDto')
class TransactionsTable extends Table {
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
@DriftAccessor(tables: [TransactionsTable])
class TransactionDao extends DatabaseAccessor<TransactionsDatabase>
    with _$TransactionDaoMixin {
  TransactionDao(TransactionsDatabase db) : super(db);

  Stream<List<TransactionDbDto>> getTransactions(String? userId) {
    final query = select(transactionsTable)
      ..where((tbl) => tbl.userId.equals(userId));
    return query.watch();
  }

  Future<void> createOrUpdate(Insertable<TransactionDbDto> transaction) =>
      into(transactionsTable).insertOnConflictUpdate(transaction);

  Future<void> deleteTransaction(String transactionId) =>
      (delete(transactionsTable)..where((tbl) => tbl.id.equals(transactionId)))
          .go();
}
