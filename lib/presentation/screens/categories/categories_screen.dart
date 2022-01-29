import 'package:budgets/core/categories/domain.dart';
import 'package:budgets/presentation/core/bloc/settings_bloc.dart';
import 'package:budgets/presentation/resources/resources.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../routes/app_navigator.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
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
              largeTitle: Text(AppLocalizations.of(context)!.misc_categories),
              previousPageTitle: AppLocalizations.of(context)!.misc_back,
              trailing: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.add,
                      color: AppColors.primaryColor,
                    ),
                    onPressed: () =>
                        AppNavigator.navigateToEditCategoryPage(context),
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
    final expenseCategories = state.categories
        .where(
          (category) => category.type == CategoryType.expense,
        )
        .toList();

    final incomeCategories = state.categories
        .where(
          (category) => category.type == CategoryType.income,
        )
        .toList();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: kDefaultPadding,
              left: kDefaultPadding,
              right: kDefaultPadding,
              bottom: 8,
            ),
            child: Text(
              'CATEGORIAS DE EGRESOS',
              style: TextStyle(fontWeight: FontWeight.w200, fontSize: 12),
              textAlign: TextAlign.start,
            ),
          ),
          Container(
            color: AppColors.white,
            child: ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.only(top: 8),
              itemCount: expenseCategories.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(height: 2),
              itemBuilder: (BuildContext context, int index) {
                final category = expenseCategories[index];
                return ListTile(
                  title: Text(expenseCategories[index].name),
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
                    Icons.chevron_right,
                  ),
                  onTap: () => AppNavigator.navigateToEditCategoryPage(context,
                      category: category),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: kDefaultPadding,
              left: kDefaultPadding,
              right: kDefaultPadding,
              bottom: 8,
            ),
            child: Text(
              'CATEGORIAS DE INGRESOS',
              style: TextStyle(fontWeight: FontWeight.w200, fontSize: 12),
              textAlign: TextAlign.start,
            ),
          ),
          Container(
            color: AppColors.white,
            child: ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.only(top: 8),
              itemCount: incomeCategories.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(height: 2),
              itemBuilder: (BuildContext context, int index) {
                final category = incomeCategories[index];
                return ListTile(
                  title: Text(incomeCategories[index].name),
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
                    Icons.chevron_right,
                  ),
                  onTap: () => AppNavigator.navigateToEditCategoryPage(context,
                      category: category),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
