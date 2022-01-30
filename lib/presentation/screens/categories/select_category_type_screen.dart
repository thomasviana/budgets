import 'package:budgets/core/categories/domain.dart';
import 'package:budgets/presentation/resources/resources.dart';
import 'package:budgets/presentation/routes/app_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'edit_category_bloc/edit_category_screen_bloc.dart';

class SelectCategoryTypeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditCategoryScreenBloc, EditCategoryScreenState>(
      builder: _buildState,
    );
  }

  Widget _buildState(BuildContext context, EditCategoryScreenState state) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tipo'),
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () => AppNavigator.navigateBack(context),
        ),
      ),
      body: ListView(
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
              'TIPOS DE CATEGORÍA',
              style: TextStyle(fontWeight: FontWeight.w200, fontSize: 12),
              textAlign: TextAlign.start,
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.monetization_on_outlined,
              color: AppColors.red,
            ),
            minLeadingWidth: 2,
            title: Text(
              'Categoría de egreso',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            trailing: state.category!.type == CategoryType.expense
                ? Icon(Icons.check, color: AppColors.primaryColor)
                : null,
            onTap: () {
              context
                  .read<EditCategoryScreenBloc>()
                  .add(TypeChanged(CategoryType.expense));
              Navigator.pop(context);
            },
          ),
          const Divider(height: 0),
          ListTile(
            leading: Icon(
              Icons.monetization_on_outlined,
              color: AppColors.green,
            ),
            minLeadingWidth: 2,
            title: Text(
              'Categoría de ingreso',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            trailing: state.category!.type == CategoryType.income
                ? Icon(Icons.check, color: AppColors.primaryColor)
                : null,
            onTap: () {
              context
                  .read<EditCategoryScreenBloc>()
                  .add(TypeChanged(CategoryType.income));
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
