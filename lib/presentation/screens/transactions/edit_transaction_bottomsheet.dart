import 'package:budgets/core/transactions/domain.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../resources/colors.dart';
import '../../routes/app_navigator.dart';
import 'edit_transaction_cubit/edit_transaction_bottomsheet_cubit.dart';

class EditTransactionBottomSheet extends StatefulWidget {
  final Transaction? transaction;
  const EditTransactionBottomSheet({
    Key? key,
    this.transaction,
  }) : super(key: key);
  @override
  _EditTransactionBottomSheetState createState() =>
      _EditTransactionBottomSheetState();
}

class _EditTransactionBottomSheetState
    extends State<EditTransactionBottomSheet> {
  late EditTransactionBottomSheetCubit cubit;
  late CurrencyTextInputFormatter formatter;
  late TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    formatter = CurrencyTextInputFormatter(symbol: '\$', decimalDigits: 0);
    textEditingController = TextEditingController()
      ..text = formatter.format(
        widget.transaction != null
            ? widget.transaction!.amount.toString()
            : '0',
      );
    ;
    cubit = context.read<EditTransactionBottomSheetCubit>();
    cubit.init(widget.transaction);
  }

  final Map<int, Widget> transactionType = const <int, Widget>{
    0: Text('Expense'),
    1: Text('Income'),
  };

  final Map<int, Widget> incomeType = const <int, Widget>{
    0: Text('Active Income'),
    1: Text('Pasive Income'),
  };

  int? currentValue = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditTransactionBottomSheetCubit,
        EditTransactionBottomSheetState>(
      builder: _buildState,
    );
  }

  Widget _buildState(
      BuildContext context, EditTransactionBottomSheetState state) {
    Widget makeDismissible({required Widget child}) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.of(context).pop(),
        child: GestureDetector(
          onTap: () {},
          child: child,
        ),
      );
    }

    return makeDismissible(
      child: DraggableScrollableSheet(
        initialChildSize: 0.95,
        maxChildSize: 0.95,
        minChildSize: 0.95,
        builder: (context, controller) => Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
          child: ListView(
            controller: controller,
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
                        // onCancelPressed();
                      },
                    ),
                    const Text(
                      'Transación',
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
                  children: transactionType,
                  onValueChanged: (int? value) {
                    setState(() {
                      currentValue = value;
                    });
                  },
                  groupValue: currentValue,
                ),
              ),
              const SizedBox(height: 25),
              TextField(
                controller: textEditingController,
                inputFormatters: [formatter],
                keyboardType: TextInputType.name,
                autofocus: true,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  hintStyle: TextStyle(fontSize: 18),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: '\$${currency.format(0)}',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Divider(height: 2),
              ListTile(
                  leading: Icon(Icons.account_balance),
                  minLeadingWidth: 2,
                  title: Text('Cuenta'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        'Bancolombia',
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
                  //     builder: (context) => _EditTypeBottomSheet(
                  //       state: state,
                  //       onCancelPressed: () {},
                  //       onTypeSelected: (accountType) {
                  //         cubit.onTypeChanged(accountType);
                  //         AppNavigator.navigateBack(context);
                  //       },
                  //     ),
                  //   );
                  // },
                  ),
              Divider(height: 2),
              ListTile(
                  leading: Icon(Icons.all_inbox),
                  minLeadingWidth: 2,
                  title: Text('Presupuesto'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        'SEG',
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
                  //     builder: (context) => _EditTypeBottomSheet(
                  //       state: state,
                  //       onCancelPressed: () {},
                  //       onTypeSelected: (accountType) {
                  //         cubit.onTypeChanged(accountType);
                  //         AppNavigator.navigateBack(context);
                  //       },
                  //     ),
                  //   );
                  // },
                  ),
              Divider(height: 2),
              ListTile(
                  leading: Icon(Icons.folder_open),
                  minLeadingWidth: 2,
                  title: Text('Categoría'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        'Arriendo',
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
                  //     builder: (context) => _EditTypeBottomSheet(
                  //       state: state,
                  //       onCancelPressed: () {},
                  //       onTypeSelected: (accountType) {
                  //         cubit.onTypeChanged(accountType);
                  //         AppNavigator.navigateBack(context);
                  //       },
                  //     ),
                  //   );
                  // },
                  ),
              Divider(height: 2),
              ListTile(
                  leading: Icon(Icons.drive_file_rename_outline_outlined),
                  minLeadingWidth: 2,
                  title: Text('Nota'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        'Apto 504',
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
                  //     builder: (context) => _EditTypeBottomSheet(
                  //       state: state,
                  //       onCancelPressed: () {},
                  //       onTypeSelected: (accountType) {
                  //         cubit.onTypeChanged(accountType);
                  //         AppNavigator.navigateBack(context);
                  //       },
                  //     ),
                  //   );
                  // },
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
                  //     builder: (context) => _EditTypeBottomSheet(
                  //       state: state,
                  //       onCancelPressed: () {},
                  //       onTypeSelected: (accountType) {
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
      ),
    );
  }

  Future<void> _showOptions(
    BuildContext context,
    EditTransactionBottomSheetCubit cubit,
    EditTransactionBottomSheetState state,
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
}

class _EditNameBottomSheet extends HookWidget {
  final Function(String) onSavePressed;
  final VoidCallback onCancelPressed;
  final EditTransactionBottomSheetState state;

  const _EditNameBottomSheet({
    Key? key,
    required this.onSavePressed,
    required this.onCancelPressed,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textEditingController = useTextEditingController()
      ..text = state.transaction!.note;
    return DraggableScrollableSheet(
      initialChildSize: 0.95,
      maxChildSize: 0.95,
      builder: (context, controller) => Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    child: const Text('Cancelar'),
                    onPressed: () {
                      AppNavigator.navigateBack(context);
                      onCancelPressed();
                    }),
                const Text(
                  'Editar cuenta',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                TextButton(
                  child: const Text('Guardar'),
                  onPressed: () {
                    AppNavigator.navigateBack(context);
                    onSavePressed(textEditingController.value.text.trim());
                  },
                ),
              ],
            ),
            SizedBox(height: 50),
            TextField(
              controller: textEditingController,
              keyboardType: TextInputType.name,
              autofocus: true,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                alignLabelWithHint: true,
                label: Center(
                  child: Text(
                    'Nuevo nombre',
                  ),
                ),
                labelStyle: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.w300,
                  fontSize: 14,
                ),
                hintStyle: TextStyle(fontSize: 18),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: '',
              ),
            )
          ],
        ),
      ),
    );
  }
}
