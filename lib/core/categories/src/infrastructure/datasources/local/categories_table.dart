import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import 'categories_db.dart';

part 'categories_table.g.dart';

enum CategoryTypeTable { income, expense }

@DataClassName('CategoryDbDto')
class CategoriesTable extends Table {
  TextColumn get id => text().customConstraint('UNIQUE')();
  TextColumn get name => text()();
  IntColumn get icon => integer()();
  IntColumn get color => integer()();
  RealColumn get amount => real().withDefault(const Constant(0.0))();
  IntColumn get type => intEnum<CategoryTypeTable>()();
  TextColumn get userId => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  String get tableName => 'categories';
}

@DataClassName('SubCategoryDbDto')
class SubCategoriesTable extends Table {
  TextColumn get id => text().customConstraint('UNIQUE')();
  TextColumn get name => text()();
  IntColumn get icon => integer()();
  IntColumn get color => integer()();
  RealColumn get amount => real().withDefault(const Constant(0.0))();
  TextColumn get cateogryId => text().references(CategoriesTable, #id)();

  @override
  Set<Column> get primaryKey => {id};

  @override
  String get tableName => 'subcategories';
}

@lazySingleton
@DriftAccessor(tables: [CategoriesTable])
class CategoryDao extends DatabaseAccessor<CategoriesDatabase>
    with _$CategoryDaoMixin {
  CategoryDao(CategoriesDatabase db) : super(db);

  Stream<List<CategoryDbDto>> getCategories(String? userId) {
    final query = select(categoriesTable)
      ..where((tbl) => tbl.userId.equals(userId));
    return query.watch();
  }

  Future<void> createOrUpdate(Insertable<CategoryDbDto> category) =>
      into(categoriesTable).insertOnConflictUpdate(category);

  Future<void> deleteCategory(String categoryId) =>
      (delete(categoriesTable)..where((tbl) => tbl.id.equals(categoryId))).go();
}

@lazySingleton
@DriftAccessor(tables: [SubCategoriesTable])
class SubCategoryDao extends DatabaseAccessor<CategoriesDatabase>
    with _$SubCategoryDaoMixin {
  SubCategoryDao(CategoriesDatabase db) : super(db);

  Stream<List<SubCategoryDbDto>> watchSubCategories() =>
      select(subCategoriesTable).watch();

  Stream<List<SubCategoryDbDto>> getSubCategories(String? categoryId) {
    final query = select(subCategoriesTable)
      ..where((tbl) => tbl.cateogryId.equals(categoryId));
    return query.watch();
  }

  Future<void> createOrUpdate(Insertable<SubCategoryDbDto> subCategory) =>
      into(subCategoriesTable).insertOnConflictUpdate(subCategory);

  Future<void> deleteCategory(String subCategoryId) =>
      (delete(subCategoriesTable)..where((tbl) => tbl.id.equals(subCategoryId)))
          .go();
}
