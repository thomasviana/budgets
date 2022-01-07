import 'package:budgets/core/accounts/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../resources/colors.dart';
import '../../routes/app_navigator.dart';
import 'edit_account_cubit/edit_account_screen_cubit.dart';

class EditAccountScreen extends StatefulWidget {
  final Account? account;
  const EditAccountScreen({
    Key? key,
    required this.account,
  }) : super(key: key);
  @override
  _EditAccountScreenState createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  late EditAccountScreenCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<EditAccountScreenCubit>();
    cubit.init(widget.account);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditAccountScreenCubit, EditAccountScreenState>(
      builder: _buildState,
    );
  }

  Widget _buildState(BuildContext context, EditAccountScreenState state) {
    return Scaffold(
      body: CupertinoPageScaffold(
        backgroundColor: AppColors.greyBackground,
        child: NestedScrollView(
          headerSliverBuilder: (ctx, inner) => [
            CupertinoSliverNavigationBar(
              largeTitle: Text('Edit account'),
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
                      cubit.onAccountDeleted();
                      AppNavigator.navigateBack(context);
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.check,
                      color: AppColors.primaryColor,
                    ),
                    onPressed: () {
                      cubit.onAccountSaved();
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

  Widget _buildBody(BuildContext context, EditAccountScreenState state) {
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
                onTap: () {
                  // _showEditOptions(context, cubit, state);
                },
                child: Stack(
                  alignment: Alignment(1, 1.2),
                  children: [
                    CircleAvatar(
                      maxRadius: 40,
                      child: Icon(
                        IconData(
                          state.account!.icon,
                          fontFamily: 'MaterialIcons',
                        ),
                        color: AppColors.white,
                        size: 40,
                      ),
                      backgroundColor: Color(state.account!.color),
                    ),
                    CircleAvatar(
                      maxRadius: 15,
                      child: Icon(
                        Icons.edit,
                        color: AppColors.white,
                        size: 15,
                      ),
                      backgroundColor: AppColors.greySecondary,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                initialValue: state.account!.name,
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
