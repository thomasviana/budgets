import '../../domain.dart';

class DeleteCategory {
  final CategoryRepository _categoryRepository;

  const DeleteCategory(this._categoryRepository);

  Future<void> call(CategoryId categoryId) {
    return _categoryRepository.delete(categoryId);
  }
}
