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
            )
          ],
          body: ListView.separated(
            itemCount: state.categories.length,
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(state.categories[index].name.value),
                leading: CircleAvatar(
                  maxRadius: 20,
                  // TODO: Icon data as string
                  child: Icon(Icons.mobile_friendly),
                  backgroundColor: Color(state.categories[index].color),
                ),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () => AppNavigator.navigateToSubCategoriesPage(
                  context,
                  state.categories[index],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}