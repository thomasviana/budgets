import 'package:injectable/injectable.dart';

import '../../../user/application.dart';
import '../../domain.dart';

@injectable
class SetDefaultSubCategories {
  final GetProfileInfo _getProfileInfo;
  final SubCategoryRepository _subCategoryRepository;

  const SetDefaultSubCategories(
    this._getProfileInfo,
    this._subCategoryRepository,
  );

  Future<void> call() async {
    _getProfileInfo().then(
      (optionUser) => optionUser.fold(
        () {},
        (user) {
          final subCategories = SubCategory.allSubCategories;
          _subCategoryRepository.saveList(subCategories);
        },
      ),
    );
  }
}
