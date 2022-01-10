import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';

import 'accounts_table.dart';

part 'accounts_db.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    const dbName = 'accounts_db.sqlite';
    final dbPath = await getApplicationDocumentsDirectory()
        .then((dir) => '${dir.path}/$dbName');
    final file = File(dbPath);
    return NativeDatabase(file);
  });
}

@DriftDatabase(
  tables: [AccountsTable],
  daos: [AccountDao],
)
class AccountsDatabase extends _$AccountsDatabase {
  AccountsDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}
