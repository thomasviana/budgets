import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../resources/colors.dart';
import 'cubit/categories_screen_cubit.dart';

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
    return CupertinoPageScaffold(
      backgroundColor: AppColors.greyBackground,
      child: NestedScrollView(
        headerSliverBuilder: (context, _) => [
          CupertinoSliverNavigationBar(
            largeTitle: Text('Categories'),
          ),
        ],
        body: CustomScrollView(
          semanticChildCount: state.categories.length,
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  final int itemIndex = index ~/ 2;
                  if (index.isEven) {
                    return Padding(
                        child: Text(
                            state.categories[itemIndex].name!.getOrCrash()),
                        padding: EdgeInsets.all(16));
                  }
                  return Divider(height: 0, color: Colors.grey);
                },
                semanticIndexCallback: (Widget widget, int localIndex) {
                  if (localIndex.isEven) {
                    return localIndex ~/ 2;
                  }
                  return null;
                },
                childCount: math.max(0, state.categories.length * 2 - 1),
              ),
            ),
          ],
        ),

        // body: ListView.separated(
        //   itemCount: state.categories.length,
        //   separatorBuilder: (BuildContext context, int index) =>
        //       const Divider(),
        //   itemBuilder: (BuildContext context, int index) {
        //     return ListTile(
        //       title: Text(state.categories[index].name!.getOrCrash()),
        //       leading: state.categories[index].icon,
        //       trailing: Icon(Icons.arrow_forward_ios),
        //       onTap: () => AppNavigator.navigateToProfilePage(context),
        //     );
        //   },
        // ),
      ),
    );
  }
}
