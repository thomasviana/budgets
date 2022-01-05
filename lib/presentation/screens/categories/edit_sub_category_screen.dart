import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/categories/domain.dart';
import '../../resources/colors.dart';
import '../../routes/app_navigator.dart';
import 'edit_sub_category_cubit/edit_sub_category_screen_cubit.dart';

class EditSubCategoryScreen extends StatefulWidget {
  final SubCategory subCategory;
  const EditSubCategoryScreen({
    Key? key,
    required this.subCategory,
  }) : super(key: key);
  @override
  _EditSubCategoryScreenState createState() => _EditSubCategoryScreenState();
}

class _EditSubCategoryScreenState extends State<EditSubCategoryScreen> {
  late EditSubCategoryScreenCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<EditSubCategoryScreenCubit>();
    cubit.init(widget.subCategory);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditSubCategoryScreenCubit, EditSubCategoryScreenState>(
      builder: _buildState,
    );
  }

  Widget _buildState(BuildContext context, EditSubCategoryScreenState state) {
    return Scaffold(
      body: CupertinoPageScaffold(
        backgroundColor: AppColors.greyBackground,
        child: NestedScrollView(
          headerSliverBuilder: (ctx, inner) => [
            CupertinoSliverNavigationBar(
              largeTitle: Text('Edit subcategory'),
              previousPageTitle: 'Back',
              trailing: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      cubit.onSubCategoryDeleted();
                      AppNavigator.navigateBack(context);
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.check,
                      color: AppColors.primaryColor,
                    ),
                    onPressed: () {
                      cubit.onSubCategorySaved();
                      AppNavigator.navigateBack(context);
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

  Widget _buildBody(BuildContext context, EditSubCategoryScreenState state) {
    if (state.isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Card(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            children: [
              SizedBox(height: 20),
              InkWell(
                // onTap: cubit.onPickNewIcon,
                child: CircleAvatar(
                  maxRadius: 40,
                  child: Icon(
                    IconData(
                      state.subCategory!.icon,
                      fontFamily: 'MaterialIcons',
                    ),
                    color: AppColors.white,
                    size: 40,
                  ),
                  backgroundColor: Color(state.subCategory!.color),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                initialValue: state.subCategory!.name,
                decoration: InputDecoration(labelText: 'Name'),
                keyboardType: TextInputType.name,
                onChanged: (name) => cubit.onNameChanged(name),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      );
    }
  }
}
