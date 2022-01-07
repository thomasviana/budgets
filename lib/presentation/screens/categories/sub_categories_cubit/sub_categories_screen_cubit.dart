import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/categories/application.dart';
import '../../../../core/categories/domain.dart';

part 'sub_categories_screen_state.dart';

@injectable
class SubCategoriesScreenCubit extends Cubit<SubCategoriesScreenState> {
  GetSubCategories getSubCategories;
  SaveSubCategories saveSubCategories;

  SubCategoriesScreenCubit(
    this.getSubCategories,
    this.saveSubCategories,
  ) : super(SubCategoriesScreenState.initial());

  Future<void> getUserSubCategories(CategoryId categoryId) async {
    final userSubCategories = await getSubCategories(categoryId);
    userSubCategories.fold(
      () => _setDefaultSubCategories(),
      (subCategories) => emit(state.copyWith(subCategories: subCategories)),
    );
  }

  Future<void> _setDefaultSubCategories() async {
    final subCategories = SubCategory.allSubCategories;
    await saveSubCategories(subCategories: subCategories);
  }
}
