import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/categories/domain.dart';
import '../../resources/colors.dart';
import 'sub_categories_cubit/sub_categories_screen_cubit.dart';

class SubCategoriesScreen extends StatefulWidget {
  final Category category;
  const SubCategoriesScreen({
    Key? key,
    required this.category,
  }) : super(key: key);
  @override
  _SubCategoriesScreenState createState() => _SubCategoriesScreenState();
}

class _SubCategoriesScreenState extends State<SubCategoriesScreen> {
  late SubCategoriesScreenCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<SubCategoriesScreenCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubCategoriesScreenCubit, SubCategoriesScreenState>(
      builder: _buildState,
    );
  }

  Widget _buildState(BuildContext context, SubCategoriesScreenState state) {
    final subCategories = widget.category.subCategories;
    return Scaffold(
      body: CupertinoPageScaffold(
        backgroundColor: AppColors.greyBackground,
        child: NestedScrollView(
          headerSliverBuilder: (ctx, inner) => [
            CupertinoSliverNavigationBar(
              largeTitle: Text('Subcategories'),
              previousPageTitle: 'Categories',
            )
          ],
          body: ListView.separated(
            itemCount: subCategories.length,
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(subCategories[index].name),
                leading: CircleAvatar(
                  maxRadius: 20,
                  child: Icon(
                    IconData(
                      subCategories[index].icon,
                      fontFamily: 'MaterialIcons',
                    ),
                    color: AppColors.white,
                  ),
                  backgroundColor: Color(subCategories[index].color),
                ),
                onTap: () {},
              );
            },
          ),
        ),
      ),
    );
  }
}
