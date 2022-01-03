import 'package:budgets/core/categories/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../resources/colors.dart';
import '../../routes/app_navigator.dart';
import 'categories_cubit/categories_screen_cubit.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  late CategoriesScreenCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<CategoriesScreenCubit>();
    cubit.init();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesScreenCubit, CategoriesScreenState>(
      builder: _buildState,
    );
  }

  Widget _buildState(BuildContext context, CategoriesScreenState state) {
    return Scaffold(
      body: CupertinoPageScaffold(
        backgroundColor: AppColors.greyBackground,
        child: NestedScrollView(
          headerSliverBuilder: (ctx, inner) => [
            CupertinoSliverNavigationBar(
              largeTitle: Text('Categories'),
              previousPageTitle: 'Settings',
              trailing: IconButton(
                icon: Icon(
                  Icons.add,
                  color: AppColors.primaryColor,
                ),
                onPressed: () {
                  cubit.onAddCategory();
                  cubit.listenCategories();
                },
              ),
            )
          ],
          body: _buildBody(context, cubit, state),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, CategoriesScreenCubit cubit,
      CategoriesScreenState state) {
    if (state.isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return StreamBuilder<List<Category>?>(
        stream: cubit.listenCategories(),
        builder: (context, AsyncSnapshot<List<Category>?> snapshot) {
          final categories = snapshot.data ?? [];
          print(categories.length);
          return ListView.separated(
            itemCount: categories.length,
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(categories[index].name),
                leading: CircleAvatar(
                  maxRadius: 20,
                  child: Icon(
                    IconData(
                      categories[index].icon,
                      fontFamily: 'MaterialIcons',
                    ),
                    color: AppColors.white,
                  ),
                  backgroundColor: Color(categories[index].color),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                ),
                onTap: () => AppNavigator.navigateToEditCategoryPage(
                  context,
                  categories[index],
                ),
              );
            },
          );
        },
      );
    }
  }
}
