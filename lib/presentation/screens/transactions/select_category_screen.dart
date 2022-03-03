import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/categories/domain.dart';
import '../../core/settings/settings_bloc.dart';
import '../../resources/resources.dart';
import '../../routes/app_navigator.dart';
import 'edit_transaction_bloc/edit_transaction_screen_bloc.dart';

class SelectCategoryScreen extends StatefulWidget {
  const SelectCategoryScreen({
    Key? key,
  }) : super(key: key);
  @override
  _SelectCategoryScreenState createState() => _SelectCategoryScreenState();
}

class _SelectCategoryScreenState extends State<SelectCategoryScreen>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  late EditTransactionScreenBloc bloc;
  late SettingsBloc settingsBloc;
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
    bloc = context.read<EditTransactionScreenBloc>();
    settingsBloc = context.read<SettingsBloc>();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return BlocBuilder<EditTransactionScreenBloc, EditTransactionScreenState>(
      builder: _buildState,
    );
  }

  Widget _buildState(BuildContext context, EditTransactionScreenState state) {
    final categories = settingsBloc.state.categories
        .where(
          (category) =>
              category.type.index == state.transaction.transactionType.index,
        )
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: Text('Categoría'),
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            if (_controller.index == 1) {
              _controller.animateTo(0);
            } else {
              AppNavigator.navigateBack(context);
            }
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              child: Text('Editar'),
              onPressed: () => state.category.fold(
                () {},
                (category) => _controller.index == 0
                    ? AppNavigator.navigateToCategoriesPage(context)
                    : AppNavigator.navigateToEditCategoryPage(
                        context,
                        category: category,
                        then: (_) => bloc.add(GetUserSubcategories()),
                      ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SearchBox(
            text: state.query!,
            hintText: 'Buscar categoría',
            onChanged: (query) =>
                bloc.add(SearchSubCategory(query: query.trim())),
          ),
          Expanded(
            child: state.query!.isEmpty
                ? TabBarView(
                    controller: _controller,
                    children: [
                      _CategoriesList(
                        categories: categories,
                        controller: _controller,
                      ),
                      _SubCategoriesList()
                    ],
                  )
                : _SubCategorySuggestions(),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _SubCategorySuggestions extends StatelessWidget {
  const _SubCategorySuggestions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditTransactionScreenBloc, EditTransactionScreenState>(
      builder: (context, state) {
        return ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 8,
                left: kDefaultPadding,
                right: kDefaultPadding,
                bottom: 8,
              ),
              child: Text(
                'SUGERENCIAS',
                style: TextStyle(fontWeight: FontWeight.w200, fontSize: 12),
                textAlign: TextAlign.start,
              ),
            ),
            ListView.separated(
              shrinkWrap: true,
              itemCount: state.subCategorySuggestions!.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(height: 0),
              itemBuilder: (BuildContext context, int index) {
                final subCategory = state.subCategorySuggestions![index];
                return ListTile(
                  title: Text(subCategory.name),
                  leading: CircleAvatar(
                    maxRadius: 20,
                    child: Icon(
                      IconData(
                        subCategory.icon,
                        fontFamily: 'MaterialIcons',
                      ),
                      color: AppColors.white,
                    ),
                    backgroundColor: Color(subCategory.color),
                  ),
                  trailing: state.category.fold(
                    () => null,
                    (stateCategoryt) {
                      if (stateCategoryt.id == subCategory.id) {
                        return Icon(Icons.check, color: AppColors.primaryColor);
                      }
                      return null;
                    },
                  ),
                  onTap: () {
                    context
                        .read<EditTransactionScreenBloc>()
                        .add(SubCategorySelected(subCategory: subCategory));
                    AppNavigator.navigateBack(context);
                  },
                );
              },
            ),
            const Divider(height: 0),
          ],
        );
      },
    );
  }
}

class _CategoriesList extends StatelessWidget {
  final List<Category> categories;
  final TabController controller;
  const _CategoriesList({
    Key? key,
    required this.categories,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditTransactionScreenBloc, EditTransactionScreenState>(
      builder: (context, state) {
        return ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 8,
                left: kDefaultPadding,
                right: kDefaultPadding,
                bottom: 8,
              ),
              child: Text(
                'CATEGORÍAS',
                style: TextStyle(fontWeight: FontWeight.w200, fontSize: 12),
                textAlign: TextAlign.start,
              ),
            ),
            ListView.separated(
              shrinkWrap: true,
              itemCount: categories.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(height: 0),
              itemBuilder: (BuildContext context, int index) {
                final category = categories[index];
                return ListTile(
                  title: Text(categories[index].name),
                  leading: CircleAvatar(
                    maxRadius: 20,
                    child: Icon(
                      IconData(
                        category.icon,
                        fontFamily: 'MaterialIcons',
                      ),
                      color: AppColors.white,
                    ),
                    backgroundColor: Color(category.color),
                  ),
                  trailing: state.category.fold(
                    () => null,
                    (stateCategoryt) {
                      if (stateCategoryt.id == category.id) {
                        return Icon(Icons.check, color: AppColors.primaryColor);
                      }
                      return null;
                    },
                  ),
                  onTap: () {
                    context
                        .read<EditTransactionScreenBloc>()
                        .add(CategorySelected(category: category));
                    controller.animateTo(1);
                  },
                );
              },
            ),
            const Divider(height: 0),
          ],
        );
      },
    );
  }
}

class _SubCategoriesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditTransactionScreenBloc, EditTransactionScreenState>(
      builder: (context, state) {
        return ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 30,
                left: kDefaultPadding,
                right: kDefaultPadding,
                bottom: 8,
              ),
              child: Text(
                'GENERAL',
                style: TextStyle(fontWeight: FontWeight.w200, fontSize: 12),
                textAlign: TextAlign.start,
              ),
            ),
            ListTile(
              title: Text(state.subCategories!.first.name),
              leading: CircleAvatar(
                maxRadius: 20,
                child: Icon(
                  IconData(
                    state.subCategories!.first.icon,
                    fontFamily: 'MaterialIcons',
                  ),
                  color: AppColors.white,
                ),
                backgroundColor: Color(state.subCategories!.first.color),
              ),
              trailing: state.subCategory.fold(
                () => null,
                (stateSubCategoryt) {
                  if (stateSubCategoryt.id == state.subCategories!.first.id) {
                    return Icon(Icons.check, color: AppColors.primaryColor);
                  }
                  return null;
                },
              ),
              onTap: () {
                context.read<EditTransactionScreenBloc>().add(
                      SubCategorySelected(
                        subCategory: state.subCategories!.first,
                      ),
                    );
                AppNavigator.navigateBack(context);
              },
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 30,
                left: kDefaultPadding,
                right: kDefaultPadding,
                bottom: 8,
              ),
              child: Text(
                'SUBCATEGORÍAS',
                style: TextStyle(fontWeight: FontWeight.w200, fontSize: 12),
                textAlign: TextAlign.start,
              ),
            ),
            Divider(height: 0),
            if (state.subCategories!.length == 1)
              state.category.fold(
                () => SizedBox(),
                (category) => Padding(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  child: Text(
                    'No hay subcategorias añadidas aún para la categoria:  ${category.name}.',
                    style: TextStyle(color: AppColors.greySecondary),
                  ),
                ),
              ),
            ListView.separated(
              shrinkWrap: true,
              itemCount: state.subCategories!.length - 1,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(height: 0),
              itemBuilder: (BuildContext context, int index) {
                final subCategory = state.subCategories![index + 1];
                return ListTile(
                  title: Text(subCategory.name),
                  leading: CircleAvatar(
                    maxRadius: 20,
                    child: Icon(
                      IconData(
                        subCategory.icon,
                        fontFamily: 'MaterialIcons',
                      ),
                      color: AppColors.white,
                    ),
                    backgroundColor: Color(subCategory.color),
                  ),
                  trailing: state.subCategory.fold(
                    () => null,
                    (stateSubCategoryt) {
                      if (stateSubCategoryt.id == subCategory.id) {
                        return Icon(Icons.check, color: AppColors.primaryColor);
                      }
                      return null;
                    },
                  ),
                  onTap: () {
                    AppNavigator.navigateBack(context);
                    context
                        .read<EditTransactionScreenBloc>()
                        .add(SubCategorySelected(subCategory: subCategory));
                  },
                );
              },
            ),
            const Divider(height: 0),
          ],
        );
      },
    );
  }
}

class SearchBox extends StatefulWidget {
  final String text;
  final ValueChanged<String> onChanged;
  final String hintText;
  const SearchBox({
    Key? key,
    required this.text,
    required this.onChanged,
    required this.hintText,
  }) : super(key: key);

  @override
  _SearchBoxState createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final styleActive = TextStyle(color: AppColors.black);
    final styleHint = TextStyle(color: Colors.black54);
    final style = widget.text.isEmpty ? styleHint : styleActive;
    return Container(
      height: 42,
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.white,
        border: Border.all(color: Colors.black26),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextField(
        autofocus: true,
        controller: controller,
        decoration: InputDecoration(
          icon: Icon(Icons.search, color: style.color),
          suffixIcon: widget.text.isNotEmpty
              ? GestureDetector(
                  child: Icon(
                    Icons.close,
                    color: style.color,
                  ),
                  onTap: () {
                    controller.clear();
                    widget.onChanged('');
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                )
              : null,
          hintText: widget.hintText,
          hintStyle: style,
          border: InputBorder.none,
        ),
        style: style,
        onChanged: widget.onChanged,
      ),
    );
  }
}
