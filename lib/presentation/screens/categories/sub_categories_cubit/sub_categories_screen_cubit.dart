import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/src/categories/sub_category.dart';

part 'sub_categories_screen_state.dart';

@injectable
class SubCategoriesScreenCubit extends Cubit<SubCategoriesScreenState> {
  SubCategoriesScreenCubit() : super(SubCategoriesScreenState.initial());
}
