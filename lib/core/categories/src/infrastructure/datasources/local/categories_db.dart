import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';

import 'categories_table.dart';

part 'categories_db.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    const dbName = 'collaboration_db.sqlite';
    final dbPath = await getApplicationDocumentsDirectory()
        .then((dir) => '${dir.path}/$dbName');
    final file = File(dbPath);
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [CategoryTable], daos: [CategoryDao])
class CategoriesDatabase extends _$CategoriesDatabase {
  CategoriesDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}
