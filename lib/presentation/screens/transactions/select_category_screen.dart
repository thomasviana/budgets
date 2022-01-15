import 'package:budgets/core/categories/domain.dart';
import 'package:budgets/presentation/routes/app_navigator.dart';
import 'package:budgets/presentation/screens/transactions/edit_transaction_cubit/edit_transaction_screen_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../resources/colors.dart';

class SelectCategoryScreen extends StatefulWidget {
  final List<Category>? categories;
  const SelectCategoryScreen({
    Key? key,
    required this.categories,
  }) : super(key: key);
  @override
  _SelectCategoryScreenState createState() => _SelectCategoryScreenState();
}

class _SelectCategoryScreenState extends State<SelectCategoryScreen>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  late EditTransactionScreenCubit cubit;
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
    cubit = context.read<EditTransactionScreenCubit>();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditTransactionScreenCubit, EditTransactionScreenState>(
      builder: _buildState,
    );
  }

  Widget _buildState(BuildContext context, EditTransactionScreenState state) {
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
              onPressed: () => AppNavigator.navigateToCategoriesPage(context),
            ),
          ),
        ],
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          _CategoriesList(
            cubit: cubit,
            categories: widget.categories!,
            controller: _controller,
          ),
          _SubCategoriesList(
            cubit: cubit,
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _CategoriesList extends StatelessWidget {
  final EditTransactionScreenCubit cubit;
  final List<Category> categories;
  final TabController controller;
  const _CategoriesList({
    Key? key,
    required this.cubit,
    required this.categories,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditTransactionScreenCubit, EditTransactionScreenState>(
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
                  trailing: state.category!.id == category.id
                      ? Icon(Icons.check, color: AppColors.primaryColor)
                      : null,
                  onTap: () {
                    cubit.onCategorySelected(category);
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
  final EditTransactionScreenCubit cubit;
  const _SubCategoriesList({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditTransactionScreenCubit, EditTransactionScreenState>(
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
                'SUBCATEGORÍAS',
                style: TextStyle(fontWeight: FontWeight.w200, fontSize: 12),
                textAlign: TextAlign.start,
              ),
            ),
            Divider(height: 0),
            FutureBuilder(
                future: cubit.getUserSubCategories(),
                builder: (context, snapshot) {
                  return ListView.separated(
                    shrinkWrap: true,
                    itemCount: state.subCategories!.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(height: 0),
                    itemBuilder: (BuildContext context, int index) {
                      final subCategory = state.subCategories![index];
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
                        onTap: () {
                          cubit.onSubCategorySelected(subCategory);
                          AppNavigator.navigateBack(context);
                        },
                      );
                    },
                  );
                }),
            const Divider(height: 0),
          ],
        );
      },
    );
  }
}
