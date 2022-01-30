part of 'edit_sub_category_screen_bloc.dart';

abstract class EditSubCategoryScreenEvent {}

class CheckSubCategory extends EditSubCategoryScreenEvent {
  final SubCategory subCategory;
  CheckSubCategory({required this.subCategory});
}

class SubCategoryDeleted extends EditSubCategoryScreenEvent {}

class SubCategorySaved extends EditSubCategoryScreenEvent {}

class ColorUpdated extends EditSubCategoryScreenEvent {
  final int color;
  ColorUpdated(this.color);
}

class IconUpdated extends EditSubCategoryScreenEvent {
  final int icon;
  IconUpdated(this.icon);
}

class NameChanged extends EditSubCategoryScreenEvent {
  final String name;
  NameChanged(this.name);
}
