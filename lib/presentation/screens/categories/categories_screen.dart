import 'dart:io' show Platform;

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
    if (Platform.isIOS) {
      return CupertinoPageScaffold(
        backgroundColor: AppColors.greyBackground,
        child: CustomScrollView(
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          slivers: [
            CupertinoSliverNavigationBar(
              stretch: true,
              largeTitle: Text(AppLocalizations.of(context)!.misc_categories),
              previousPageTitle: AppLocalizations.of(context)!.misc_back,
            ),
            SliverToBoxAdapter(
              child: Material(child: CategoriesContent()),
            )
          ],
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.misc_categories),
        ),
        body: CategoriesContent(),
      );
    }
  }
}

class CategoriesContent extends StatelessWidget {
  const CategoriesContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
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
                      leading: ListTileLeadingIcon(
                        icon: category.icon,
                        color: category.color,
                      ),
                      trailing: Platform.isIOS
                          ? const Icon(CupertinoIcons.forward)
                          : null,
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
                      leading: ListTileLeadingIcon(
                        icon: category.icon,
                        color: category.color,
                      ),
                      trailing: Platform.isIOS
                          ? const Icon(CupertinoIcons.forward)
                          : null,
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
      },
    );
  }
}
