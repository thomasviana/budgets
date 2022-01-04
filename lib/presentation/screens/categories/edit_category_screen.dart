import 'package:budgets/presentation/routes/app_navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/categories/domain.dart';
import '../../resources/colors.dart';
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
    final subCategories = widget.category.subCategories;

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
                  IconButton(
                    icon: Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      cubit.onCategoryDeleted();
                      AppNavigator.navigateBack(context);
                    },
                  ),
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
      return Card(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            children: [
              SizedBox(height: 40),
              InkWell(
                // onTap: cubit.onPickNewIcon,
                child: CircleAvatar(
                  maxRadius: 40,
                  child: Icon(
                    IconData(
                      widget.category.icon,
                      fontFamily: 'MaterialIcons',
                    ),
                    color: AppColors.white,
                  ),
                  backgroundColor: Color(widget.category.color),
                ),
              ),
              SizedBox(height: 50),
              TextFormField(
                initialValue: cubit.state.category!.name,
                decoration: InputDecoration(labelText: 'Name'),
                keyboardType: TextInputType.name,
                onChanged: (name) =>
                    context.read<EditCategoryScreenCubit>().onNameChanged(name),
              ),

              const SizedBox(height: 50),
              Text(
                'User ID: ${cubit.state.user!.id.value}',
              ),
              const SizedBox(height: 50),
              // body: ListView.separated(
              //   itemCount: subCategories.length,
              //   separatorBuilder: (BuildContext context, int index) =>
              //       const Divider(),
              //   itemBuilder: (BuildContext context, int index) {
              //     return ListTile(
              //       title: Text(subCategories[index].name),
              //       leading: CircleAvatar(
              //         maxRadius: 20,
              //         child: Icon(
              //           IconData(
              //             subCategories[index].icon,
              //             fontFamily: 'MaterialIcons',
              //           ),
              //           color: AppColors.white,
              //         ),
              //         backgroundColor: Color(subCategories[index].color),
              //       ),
              //       onTap: () {},
              //     );
              //   },
              // ),
            ],
          ),
        ),
      );
    }
  }
}
