import 'package:budgets/core/transactions/domain.dart';
import 'package:budgets/presentation/core/settings/settings_cubit.dart';
import 'package:budgets/presentation/resources/resources.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as f;
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

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
  late f.Timestamp dateTime;

  @override
  void initState() {
    settingsCubit = context.read<SettingsCubit>();
    cubit = context.read<EditTransactionScreenCubit>()
      ..init(widget.transaction)
      ..getUserSubCategories();
    formatter = CurrencyTextInputFormatter(symbol: '\$', decimalDigits: 0);
    textEditingController = TextEditingController()
      ..text = formatter.format(cubit.state.transaction!.amount.toString());
    dateTime = f.Timestamp.now();
    initializeDateFormatting();
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

    //Date Picker
    Widget buildDatePicker() => SizedBox(
          height: 150,
          child: CupertinoDatePicker(
            initialDateTime: DateTime.now(),
            maximumDate: DateTime.now(),
            onDateTimeChanged: (dateTime) {
              final timeStamp = f.Timestamp.fromDate(dateTime);
              setState(() {
                this.dateTime = timeStamp;
              });
            },
          ),
        );

    //Date formatter
    String getFormattedDate(DateTime date) {
      if (date.day == DateTime.now().day) {
        return AppLocalizations.of(context)!.misc_today +
            DateFormat(',').add_jm().format(date);
      } else if (date.day == DateTime.now().subtract(Duration(days: 1)).day) {
        return AppLocalizations.of(context)!.misc_yesterday +
            DateFormat(',').add_jm().format(date);
      } else {
        return DateFormat('MMM d,', AppLocalizations.of(context)!.localeName)
            .add_jm()
            .format(date);
      }
    }

    //SaveButtonEnable

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
                      _showCancelOptions(
                        context,
                        onDiscardPressed: () =>
                            AppNavigator.navigateBack(context),
                      );
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
                    child: const Text(
                      'Guardar',
                      style: TextStyle(
                        color: AppColors.greyDisabled,
                      ),
                    ),
                    onPressed: () {
                      AppNavigator.navigateBack(context);
                      final amount = textEditingController.text
                          .replaceAll(RegExp(r'[^\w\s]+'), '');
                      cubit.onTransactionSaved(
                        double.parse(amount),
                        dateTime.toDate(),
                      );
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
                color:
                    state.transaction!.isExpense ? AppColors.red : Colors.green,
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
                  Icon(Icons.chevron_right)
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
                      style: TextStyle(color: AppColors.red),
                    ),
                    (subCategory) => Text(
                      subCategory.name,
                      style: TextStyle(color: AppColors.greySecondary),
                    ),
                  ),
                  SizedBox(width: 10),
                  Icon(Icons.chevron_right)
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
                  Icon(Icons.chevron_right)
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
                  Icon(Icons.chevron_right)
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
            Theme(
              data:
                  Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                leading: Icon(Icons.calendar_today_rounded),
                title: Text('Fecha'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      getFormattedDate(dateTime.toDate()),
                      style: TextStyle(color: AppColors.greySecondary),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.chevron_right)
                  ],
                ),
                children: [
                  buildDatePicker(),
                ],
              ),
            ),
            Divider(height: 2),
          ],
        ),
      ),
    );
  }
}

Future<void> _showCancelOptions(
  BuildContext context, {
  required VoidCallback onDiscardPressed,
}) async {
  await showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoActionSheet(
      actions: <CupertinoActionSheetAction>[
        CupertinoActionSheetAction(
          child: const Text(
            'Descartar cambios',
            style: TextStyle(color: AppColors.red),
          ),
          onPressed: () {
            Navigator.pop(context);
            onDiscardPressed();
          },
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: const Text(
          'Continuar editando',
        ),
        onPressed: () => Navigator.pop(context),
      ),
    ),
  );
}
