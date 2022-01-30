part of 'edit_category_screen_bloc.dart';

abstract class EditCategoryScreenEvent {}

class CheckCategory extends EditCategoryScreenEvent {
  final Category? category;
  CheckCategory({this.category});
}

class GetUserSubcategories extends EditCategoryScreenEvent {}

class CategoryDeleted extends EditCategoryScreenEvent {}

class CategorySaved extends EditCategoryScreenEvent {}

class ColorUpdated extends EditCategoryScreenEvent {
  final int color;
  ColorUpdated(this.color);
}

class IconUpdated extends EditCategoryScreenEvent {
  final int icon;
  IconUpdated(this.icon);
}

class NameChanged extends EditCategoryScreenEvent {
  final String name;
  NameChanged(this.name);
}

class TypeChanged extends EditCategoryScreenEvent {
  final CategoryType categoryType;
  TypeChanged(this.categoryType);
}

class SubcategoryAdded extends EditCategoryScreenEvent {}
