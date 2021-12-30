import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/categories/domain.dart';

part 'categories_screen_state.dart';

@injectable
class CategoriesScreenCubit extends Cubit<CategoriesScreenState> {
  CategoriesScreenCubit() : super(CategoriesScreenState.initial());
}
