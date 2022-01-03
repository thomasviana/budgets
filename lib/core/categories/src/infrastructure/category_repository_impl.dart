import 'package:budgets/core/categories/infrastructure.dart';
import 'package:injectable/injectable.dart';

import '../../domain.dart';

@LazySingleton(as: CategoryRepository)
class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryDao _categoryDao;
  final CategoryMapper _categoryMapper;

  CategoryRepositoryImpl(this._categoryDao, this._categoryMapper);

  @override
  Future<void> delete(CategoryId categoryId) {
    return _categoryDao.deleteCategory(categoryId.value);
  }

  @override
  Stream<List<Category>> fetchCategories(CategoryUserId? userId) {
    return _categoryDao
        .getCategories(userId!.value)
        .map((dtos) => _categoryMapper.fromDbDtoList(dtos));
  }

  @override
  Future<void> save(Category category) {
    return Future.value(_categoryMapper.toDbDto(category))
        .then((dto) => _categoryDao.createOrUpdate(dto));
  }
}
