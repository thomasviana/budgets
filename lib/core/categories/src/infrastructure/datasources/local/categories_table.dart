import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import 'categories_db.dart';

part 'categories_table.g.dart';

@DataClassName('CategoryDbDto')
class CategoryTable extends Table {
  TextColumn get id => text().customConstraint('UNIQUE')();
  TextColumn get userId => text().nullable()();
  TextColumn get name => text()();
  IntColumn get icon => integer()();
  IntColumn get color => integer()();
  //TODO: Subcategories

  @override
  Set<Column> get primaryKey => {id};

  @override
  String get tableName => 'category';
}

@lazySingleton
@DriftAccessor(tables: [CategoryTable])
class CategoryDao extends DatabaseAccessor<CategoriesDatabase>
    with _$CategoryDaoMixin {
  CategoryDao(CategoriesDatabase db) : super(db);

  Stream<List<CategoryDbDto>> getCategories(String? userId) {
    final query = select(categoryTable)
      ..where((tbl) => tbl.userId.equals(userId));
    return query.watch();
  }

  // Future<void> createOrUpdate(CategoryDbDto category) =>
  //     into(categoryTable).insertOnConflictUpdate(category);

  Future<void> createOrUpdate(Insertable<CategoryDbDto> category) =>
      into(categoryTable).insertOnConflictUpdate(category);

  Future<void> deleteCategory(String categoryId) =>
      (delete(categoryTable)..where((tbl) => tbl.id.equals(categoryId))).go();
}
