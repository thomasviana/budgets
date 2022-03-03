import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/settings/settings_bloc.dart';
import '../../resources/resources.dart';
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
              // trailing: IconButton(
              //   icon: Icon(
              //     Icons.add,
              //     color: AppColors.primaryColor,
              //   ),
              //   onPressed: () =>
              //       AppNavigator.navigateToEditCategoryPage(context),
              // ),
            )
          ],
          body: _buildBody(context, state),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, SettingsState state) {
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
              itemCount: state.expenseCategories.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(height: 2),
              itemBuilder: (BuildContext context, int index) {
                final category = state.expenseCategories[index];
                return ListTile(
                  title: Text(category.name),
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
                  onTap: () => AppNavigator.navigateToEditCategoryPage(
                    context,
                    category: category,
                  ),
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
              itemCount: state.incomeCategories.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(height: 2),
              itemBuilder: (BuildContext context, int index) {
                final category = state.incomeCategories[index];
                return ListTile(
                  title: Text(state.incomeCategories[index].name),
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
                  onTap: () {
                    AppNavigator.navigateToEditCategoryPage(
                      context,
                      category: category,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
