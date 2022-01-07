import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../domain.dart';

@injectable
class GetCategories {
  final CategoryRepository _categoryRepository;

  const GetCategories(
    this._categoryRepository,
  );

  Future<Option<List<Category>>> call(CategoryUserId userId) =>
      _categoryRepository.fetchCategories(userId);
}
