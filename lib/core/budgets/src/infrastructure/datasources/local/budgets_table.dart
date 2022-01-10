import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import 'budgets_db.dart';

part 'budgets_table.g.dart';

@DataClassName('BudgetDbDto')
class BudgetsTable extends Table {
  TextColumn get id => text().customConstraint('UNIQUE')();
  TextColumn get name => text()();
  IntColumn get icon => integer()();
  IntColumn get color => integer()();
  RealColumn get balance => real().withDefault(const Constant(0.0))();
  TextColumn get userId => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  String get tableName => 'budgets';
}

@lazySingleton
@DriftAccessor(tables: [BudgetsTable])
class BudgetDao extends DatabaseAccessor<BudgetsDatabase>
    with _$BudgetDaoMixin {
  BudgetDao(BudgetsDatabase db) : super(db);

  Stream<List<BudgetDbDto>> getBudgets(String? userId) {
    final query = select(budgetsTable)
      ..where((tbl) => tbl.userId.equals(userId));
    return query.watch();
  }

  Future<void> createOrUpdate(Insertable<BudgetDbDto> budget) =>
      into(budgetsTable).insertOnConflictUpdate(budget);

  Future<void> deleteBudget(String budgetId) =>
      (delete(budgetsTable)..where((tbl) => tbl.id.equals(budgetId))).go();
}
