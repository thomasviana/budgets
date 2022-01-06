import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/categories/domain.dart';
import '../../resources/colors.dart';
import '../../routes/app_navigator.dart';
import 'edit_category_cubit/edit_category_screen_cubit.dart';

class EditCategoryScreen extends StatefulWidget {
  final Category category;
  const EditCategoryScreen({
    Key? key,
    required this.category,
  }) : super(key: key);
  @override
  _EditCategoryScreenState createState() => _EditCategoryScreenState();
}

class _EditCategoryScreenState extends State<EditCategoryScreen> {
  late EditCategoryScreenCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<EditCategoryScreenCubit>();
    cubit.init(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditCategoryScreenCubit, EditCategoryScreenState>(
      builder: _buildState,
    );
  }

  Widget _buildState(BuildContext context, EditCategoryScreenState state) {
    return Scaffold(
      body: CupertinoPageScaffold(
        backgroundColor: AppColors.greyBackground,
        child: NestedScrollView(
          headerSliverBuilder: (ctx, inner) => [
            CupertinoSliverNavigationBar(
              largeTitle: Text('Edit category'),
              previousPageTitle: 'Back',
              trailing: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // IconButton(
                  //   icon: Icon(
                  //     Icons.delete_outline,
                  //     color: Colors.red,
                  //   ),
                  //   onPressed: () {
                  //     cubit.onCategoryDeleted();
                  //     AppNavigator.navigateBack(context);
                  //   },
                  // ),
                  IconButton(
                    icon: Icon(
                      Icons.check,
                      color: AppColors.primaryColor,
                    ),
                    onPressed: () {
                      cubit.onCategorySaved();
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

  Widget _buildBody(BuildContext context, EditCategoryScreenState state) {
    if (state.isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: AppColors.white,
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
                          state.category!.icon,
                          fontFamily: 'MaterialIcons',
                        ),
                        color: AppColors.white,
                        size: 40,
                      ),
                      backgroundColor: Color(state.category!.color),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    initialValue: state.category!.name,
                    decoration: InputDecoration(labelText: 'Name'),
                    keyboardType: TextInputType.name,
                    onChanged: (name) => cubit.onNameChanged(name),
                  ),
                ],
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
                'SUBCATEGORIES',
                style: TextStyle(fontWeight: FontWeight.w200, fontSize: 12),
                textAlign: TextAlign.start,
              ),
            ),
            Container(
              color: AppColors.white,
              child: FutureBuilder(
                future: cubit.getUserSubCategories(),
                builder: (context, snapshot) {
                  final subCategories = state.subCategories ?? [];
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.only(top: 8, bottom: 8),
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
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                        ),
                        onTap: () {
                          AppNavigator.navigateToEditSubCategoryPage(
                            context,
                            subCategories[index],
                            (_) => cubit.getUserSubCategories(),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 40),
            Container(
              color: AppColors.white,
              child: ListTile(
                title: Text('Add subcategory'),
                leading: CircleAvatar(
                  maxRadius: 20,
                  child: Icon(
                    Icons.add,
                    color: AppColors.white,
                  ),
                  backgroundColor: AppColors.greyDisabled,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                ),
                onTap: () {},
              ),
            ),
            SizedBox(height: 80),
          ],
        ),
      );
    }
  }
}
