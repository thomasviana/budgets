import 'package:budgets/core/accounts/domain.dart';
import 'package:budgets/presentation/routes/app_navigator.dart';
import 'package:budgets/presentation/screens/transactions/edit_transaction_cubit/edit_transaction_screen_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../resources/colors.dart';

class SelectAccountScreen extends StatefulWidget {
  final List<Account>? accounts;
  const SelectAccountScreen({
    Key? key,
    required this.accounts,
  }) : super(key: key);
  @override
  _SelectAccountScreenState createState() => _SelectAccountScreenState();
}

class _SelectAccountScreenState extends State<SelectAccountScreen> {
  late EditTransactionScreenCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<EditTransactionScreenCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditTransactionScreenCubit, EditTransactionScreenState>(
      builder: _buildState,
    );
  }

  Widget _buildState(BuildContext context, EditTransactionScreenState state) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cuenta'),
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () => AppNavigator.navigateBack(context),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              child: Text('Editar'),
              onPressed: () => AppNavigator.navigateToAccountsPage(context),
            ),
          ),
        ],
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
              'CUENTAS',
              style: TextStyle(fontWeight: FontWeight.w200, fontSize: 12),
              textAlign: TextAlign.start,
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            itemCount: widget.accounts!.length,
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(height: 0),
            itemBuilder: (BuildContext context, int index) {
              NetworkImage? image;
              Icon? accountIcon;
              bool isImageAvailable;
              final account = widget.accounts![index];
              if (account.imageUrl != null) {
                isImageAvailable = true;
                image = NetworkImage(account.imageUrl!);
              } else {
                isImageAvailable = false;
                accountIcon = Icon(
                  IconData(
                    account.icon,
                    fontFamily: 'MaterialIcons',
                  ),
                  color: AppColors.white,
                );
              }
              return ListTile(
                leading: CircleAvatar(
                  maxRadius: 20,
                  backgroundColor: Color(account.color),
                  backgroundImage: image,
                  child: isImageAvailable ? null : accountIcon,
                ),
                title: Text(
                  account.name,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                trailing: state.account!.id == account.id
                    ? Icon(Icons.check, color: AppColors.primaryColor)
                    : null,
                onTap: () {
                  cubit.onAccountSelected(account);
                  Navigator.pop(context, account);
                },
              );
            },
          ),
          const Divider(height: 0),
        ],
      ),
    );
  }
}
