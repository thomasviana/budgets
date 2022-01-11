import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';

import 'transactions_table.dart';

part 'transactions_db.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    const dbName = 'categories_db.sqlite';
    final dbPath = await getApplicationDocumentsDirectory()
        .then((dir) => '${dir.path}/$dbName');
    final file = File(dbPath);
    return NativeDatabase(file);
  });
}

@DriftDatabase(
  tables: [TxsTable],
  daos: [TxDao],
)
class TxsDatabase extends _$TxsDatabase {
  TxsDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}
