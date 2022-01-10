import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';

import 'budgets_table.dart';

part 'budgets_db.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    const dbName = 'budgets_db.sqlite';
    final dbPath = await getApplicationDocumentsDirectory()
        .then((dir) => '${dir.path}/$dbName');
    final file = File(dbPath);
    return NativeDatabase(file);
  });
}

@DriftDatabase(
  tables: [BudgetsTable],
  daos: [BudgetDao],
)
class BudgetsDatabase extends _$BudgetsDatabase {
  BudgetsDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}
