import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../user/application.dart';
import '../../domain.dart';

@injectable
class GetCategories {
  final CategoryRepository _categoryRepository;
  final GetProfileInfo _getProfileInfo;

  const GetCategories(
    this._categoryRepository,
    this._getProfileInfo,
  );

  Stream<Option<List<Category>>> call() async* {
    final user = await _getProfileInfo().first;
    if (user != null) {
      yield* _categoryRepository.fetchCategories(CategoryUserId(user.id.value));
    }
  }
}
