import 'package:budgets/core/transactions/domain.dart';
import 'package:budgets/presentation/core/settings/settings_cubit.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../resources/colors.dart';
import '../../routes/app_navigator.dart';
import 'edit_transaction_cubit/edit_transaction_screen_cubit.dart';

class EditTransactionScreen extends StatefulWidget {
  final Transaction? transaction;
  const EditTransactionScreen({
    Key? key,
    this.transaction,
  }) : super(key: key);
  @override
  _EditTransactionScreenState createState() => _EditTransactionScreenState();
}

class _EditTransactionScreenState extends State<EditTransactionScreen> {
  late EditTransactionScreenCubit cubit;
  late SettingsCubit settingsCubit;
  late CurrencyTextInputFormatter formatter;
  late TextEditingController textEditingController;

  @override
  void initState() {
    settingsCubit = context.read<SettingsCubit>();
    cubit = context.read<EditTransactionScreenCubit>()
      ..init(widget.transaction)
      ..getUserSubCategories();
    formatter = CurrencyTextInputFormatter(symbol: '\$', decimalDigits: 0);
    textEditingController = TextEditingController()
      ..text = formatter.format(cubit.state.transaction!.amount.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditTransactionScreenCubit, EditTransactionScreenState>(
      builder: _buildState,
    );
  }

  Widget _buildState(BuildContext context, EditTransactionScreenState state) {
    // Account leading
    final account = state.account.fold(
      () => settingsCubit.state.accounts.first,
      (account) => account,
    );
    NetworkImage? image;
    Icon? accountIcon;
    bool isImageAvailable;
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

    // Budget leading
    final budget = state.budget.fold(
      () => settingsCubit.state.budgets.first,
      (budget) => budget,
    );
    bool hasAbbreviation = true;
    if (budget.abbreviation == null || budget.abbreviation!.isEmpty) {
      hasAbbreviation = false;
    }

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    child: const Text('Cancelar'),
                    onPressed: () {
                      AppNavigator.navigateBack(context);
                    },
                  ),
                  const Text(
                    'Transacción',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  TextButton(
                    child: const Text('Guardar'),
                    onPressed: () {
                      AppNavigator.navigateBack(context);
                      // onSavePressed(textEditingController.value.text.trim());
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: CupertinoSlidingSegmentedControl(
                children: const {
                  0: Text('Egreso'),
                  1: Text('Ingreso'),
                },
                onValueChanged: (int? index) =>
                    cubit.onTransactionTypeChanged(index),
                groupValue: state.transaction!.transactionType.index,
              ),
            ),
            const SizedBox(height: 25),
            TextField(
              controller: textEditingController,
              inputFormatters: [formatter],
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              autofocus: true,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: state.transaction!.isExpense ? Colors.red : Colors.green,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                hintStyle: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: '\$${currency.format(state.transaction!.amount)}',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Divider(height: 2),
            ListTile(
              leading: CircleAvatar(
                maxRadius: 20,
                backgroundColor: Color(account.color),
                backgroundImage: image,
                child: isImageAvailable ? null : accountIcon,
              ),
              minLeadingWidth: 2,
              title: Text('Cuenta'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    account.name,
                    style: TextStyle(color: AppColors.greySecondary),
                  ),
                  SizedBox(width: 10),
                  Icon(Icons.arrow_forward_ios_rounded)
                ],
              ),
              onTap: () {
                AppNavigator.navigateToSelectAccountPage(
                  context,
                  settingsCubit.state.accounts,
                );
              },
            ),
            Divider(height: 2),
            ListTile(
              leading: state.subCategory.fold(
                () => CircleAvatar(
                  maxRadius: 20,
                  child: Text(
                    '?',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: AppColors.white),
                  ),
                  backgroundColor: AppColors.greyDisabled,
                ),
                (subcategory) => CircleAvatar(
                  maxRadius: 20,
                  child: Icon(
                    IconData(
                      subcategory.icon,
                      fontFamily: 'MaterialIcons',
                    ),
                    color: AppColors.white,
                  ),
                  backgroundColor: Color(subcategory.color),
                ),
              ),
              title: Text('Categoría'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  state.subCategory.fold(
                    () => Text(
                      'Requerido',
                      style: TextStyle(color: Colors.red),
                    ),
                    (subCategory) => Text(
                      subCategory.name,
                      style: TextStyle(color: AppColors.greySecondary),
                    ),
                  ),
                  SizedBox(width: 10),
                  Icon(Icons.arrow_forward_ios_rounded)
                ],
              ),
              onTap: () {
                AppNavigator.navigateToSelectCategoryPage(
                  context,
                  settingsCubit.state.categories,
                );
              },
            ),
            Divider(height: 2),
            ListTile(
              leading: CircleAvatar(
                maxRadius: 20,
                backgroundColor: Color(budget.color),
                child: hasAbbreviation
                    ? Text(
                        budget.abbreviation!,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                        ),
                      )
                    : Icon(
                        Icons.inbox,
                        color: AppColors.white,
                      ),
              ),
              minLeadingWidth: 2,
              title: Text('Presupuesto'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    budget.name,
                    style: TextStyle(color: AppColors.greySecondary),
                  ),
                  SizedBox(width: 10),
                  Icon(Icons.arrow_forward_ios_rounded)
                ],
              ),
              onTap: () {
                AppNavigator.navigateToSelectBudgetPage(
                  context,
                  budgets: settingsCubit.state.budgets,
                );
              },
            ),
            Divider(height: 2),
            ListTile(
              leading: Icon(Icons.drive_file_rename_outline_outlined),
              minLeadingWidth: 2,
              title: Text('Nota'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    state.transaction!.note,
                    style: TextStyle(color: AppColors.greySecondary),
                  ),
                  SizedBox(width: 10),
                  Icon(Icons.arrow_forward_ios_rounded)
                ],
              ),
              onTap: () {
                AppNavigator.navigateToEditNotePage(
                  context,
                  content: state.transaction!.note,
                );
              },
            ),
            Divider(height: 2),
            ListTile(
                leading: Icon(Icons.calendar_today_rounded),
                minLeadingWidth: 2,
                title: Text('Fecha'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      'Enero 13, 10:38 am',
                      style: TextStyle(color: AppColors.greySecondary),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.arrow_forward_ios_rounded)
                  ],
                ),
                onTap: () {}
                //   showModalBottomSheet(
                //     backgroundColor: Colors.transparent,
                //     isScrollControlled: true,
                //     context: context,
                //     builder: (context) => _SelectAccountBottomSheet(
                //       state: state,
                //       onCancelPressed: () {},
                //       onAccountSelected: (accountType) {
                //         cubit.onTypeChanged(accountType);
                //         AppNavigator.navigateBack(context);
                //       },
                //     ),
                //   );
                // },
                ),
            Divider(height: 2),
          ],
        ),
      ),
    );
  }
}

Future<void> _showOptions(
  BuildContext context,
  EditTransactionScreenCubit cubit,
  EditTransactionScreenState state,
) async {
  await showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoActionSheet(
      actions: <CupertinoActionSheetAction>[
        CupertinoActionSheetAction(
          child: const Text(
            'Descartar cambios',
            style: TextStyle(color: Colors.red),
          ),
          onPressed: () {
            Navigator.pop(context);
            // _pickColor(context, cubit, state);
          },
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: const Text(
          'Continuar',
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ),
  );
}
