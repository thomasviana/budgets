import 'package:budgets/presentation/core/settings/settings_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../resources/colors.dart';
import '../../routes/app_navigator.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: _buildState,
    );
  }

  Widget _buildState(BuildContext context, SettingsState state) {
    return Scaffold(
      body: CupertinoPageScaffold(
        backgroundColor: AppColors.greyBackground,
        child: NestedScrollView(
          headerSliverBuilder: (ctx, inner) => [
            CupertinoSliverNavigationBar(
              largeTitle: Text('Categorías'),
              previousPageTitle: 'Ajustes',
              trailing: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.add,
                      color: AppColors.primaryColor,
                    ),
                    onPressed: () {
                      AppNavigator.navigateToEditCategoryPage(
                        context,
                        (_) => context.read<SettingsCubit>().getSettings(),
                      );
                    },
                  ),
                ],
              ),
            )
          ],
          body: _buildBody(context, state),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, SettingsState state) {
    final categories = state.categories;
    return ListView.separated(
      padding: EdgeInsets.only(top: 8),
      itemCount: state.categories.length,
      separatorBuilder: (BuildContext context, int index) =>
          const Divider(height: 2),
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
          trailing: Icon(
            Icons.arrow_forward_ios,
          ),
          onTap: () => AppNavigator.navigateToEditCategoryPage(
            context,
            (_) => context.read<SettingsCubit>().getSettings(),
            category: category,
          ),
        );
      },
    );
  }
}
