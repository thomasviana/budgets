import 'package:budgets/presentation/routes/app_navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../resources/colors.dart';
import 'accounts_cubit/accounts_screen_cubit.dart';

class AccountsScreen extends StatefulWidget {
  @override
  _AccountssScreenState createState() => _AccountssScreenState();
}

class _AccountssScreenState extends State<AccountsScreen> {
  late AccountsScreenCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<AccountsScreenCubit>();
    cubit.init();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountsScreenCubit, AccountsScreenState>(
      builder: _buildState,
    );
  }

  Widget _buildState(BuildContext context, AccountsScreenState state) {
    return Scaffold(
      body: CupertinoPageScaffold(
        backgroundColor: AppColors.greyBackground,
        child: NestedScrollView(
          headerSliverBuilder: (ctx, inner) => [
            CupertinoSliverNavigationBar(
              largeTitle: Text('Accounts'),
              previousPageTitle: 'Settings',
              trailing: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.add,
                      color: AppColors.primaryColor,
                    ),
                    onPressed: () {
                      // AppNavigator.navigateToEditCategoryPage(
                      //   context,
                      //   (_) => cubit.getUserCategories(),
                      // );
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

  Widget _buildBody(BuildContext context, AccountsScreenState state) {
    if (state.isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return FutureBuilder(
        future: cubit.getUserAccounts(),
        builder: (context, snapshot) {
          return ListView.separated(
            padding: EdgeInsets.only(top: 8),
            itemCount: state.accounts.length,
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: CircleAvatar(
                  maxRadius: 20,
                  backgroundColor: Colors.amber,
                  backgroundImage: NetworkImage(state.accounts[index].imageUrl),
                ),
                title: Text(
                  state.accounts[index].name,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                ),
                onTap: () => AppNavigator.navigateToEditAccountPage(
                  context,
                  (_) => cubit.getUserAccounts(),
                  account: state.accounts[index],
                ),
              );
            },
          );
        },
      );
    }
  }
}
