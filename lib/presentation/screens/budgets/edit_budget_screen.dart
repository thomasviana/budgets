import 'dart:io' show Platform;

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

import '../../../core/budgets/domain.dart';
import '../../resources/resources.dart';
import '../../routes/app_navigator.dart';
import 'edit_budget_bloc/edit_budget_screen_bloc.dart';

class EditBudgetScreen extends StatefulWidget {
  final Budget? budget;
  const EditBudgetScreen({
    Key? key,
    required this.budget,
  }) : super(key: key);
  @override
  _EditBudgetScreenState createState() => _EditBudgetScreenState();
}

class _EditBudgetScreenState extends State<EditBudgetScreen> {
  late EditBudgetScreenBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.read<EditBudgetScreenBloc>()
      ..add(CheckBudget(budget: widget.budget));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditBudgetScreenBloc, EditBudgetScreenState>(
      builder: _buildState,
    );
  }

  Widget _buildState(BuildContext context, EditBudgetScreenState state) {
    if (Platform.isIOS) {
      return CupertinoPageScaffold(
        backgroundColor: AppColors.greyBackground,
        child: CustomScrollView(
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          slivers: [
            CupertinoSliverNavigationBar(
              stretch: true,
              largeTitle: Text(
                state.isEditMode ? 'Editar presupuesto' : 'Nuevo presupuesto',
              ),
              previousPageTitle: AppLocalizations.of(context)!.misc_back,
              trailing: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (state.budget?.id.value != 'inv' &&
                      state.budget?.id.value != 'seg' &&
                      state.budget?.id.value != 'dar')
                    GestureDetector(
                      child: Icon(
                        CupertinoIcons.trash_circle,
                        color: AppColors.red,
                      ),
                      onTap: () {
                        bloc.add(BudgetDeleted());
                        AppNavigator.navigateBack(context);
                      },
                    ),
                  SizedBox(width: 8),
                  GestureDetector(
                    child: Icon(
                      CupertinoIcons.checkmark_circle,
                      color: AppColors.primaryColor,
                    ),
                    onTap: () {
                      if (state.budget!.name.isEmpty) return;
                      bloc.add(BudgetSaved());
                      AppNavigator.navigateBack(context);
                    },
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Material(
                child: _buildBody(context, state),
              ),
            )
          ],
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          title: Text(
            state.isEditMode ? 'Editar presupuesto' : 'Nuevo presupuesto',
          ),
          actions: [
            if (state.budget?.id.value != 'inv' &&
                state.budget?.id.value != 'seg' &&
                state.budget?.id.value != 'dar')
              IconButton(
                icon: Icon(
                  Icons.delete_outline,
                  color: AppColors.red,
                ),
                onPressed: () {
                  bloc.add(BudgetDeleted());
                  AppNavigator.navigateBack(context);
                },
              ),
            IconButton(
              icon: Icon(
                Icons.check,
              ),
              onPressed: () {
                if (state.budget!.name.isEmpty) return;
                bloc.add(BudgetSaved());
                AppNavigator.navigateBack(context);
              },
            ),
          ],
        ),
        body: _buildBody(context, state),
      );
    }
  }

  Widget _buildBody(BuildContext context, EditBudgetScreenState state) {
    if (state.isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      final budget = state.budget;
      bool hasAbbreviation = true;
      if (budget!.abbreviation == null || budget.abbreviation!.isEmpty) {
        hasAbbreviation = false;
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20),
          Center(
            child: InkWell(
              onTap: () {
                _showEditOptions(context, bloc, state);
              },
              child: Stack(
                alignment: Alignment(1, 1.2),
                children: [
                  CircleAvatar(
                    maxRadius: 40,
                    backgroundColor: Color(state.budget!.color),
                    child: hasAbbreviation
                        ? Text(
                            budget.abbreviation!,
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: AppColors.white,
                            ),
                          )
                        : Icon(
                            Icons.inbox,
                            color: AppColors.white,
                            size: 40,
                          ),
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
          ),
          if (Platform.isAndroid) ...[
            SizedBox(height: 20),
            Divider(height: 2),
          ],
          Padding(
            padding: const EdgeInsets.only(
              top: kDefaultPadding,
              left: kDefaultPadding,
              right: kDefaultPadding,
              bottom: 8,
            ),
            child: Text(
              'GENERAL',
              style: TextStyle(fontWeight: FontWeight.w200, fontSize: 12),
              textAlign: TextAlign.start,
            ),
          ),
          Container(
            color: AppColors.white,
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.drive_file_rename_outline_outlined),
                  minLeadingWidth: 2,
                  title: Text('Nombre'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (state.budget!.name.isNotEmpty)
                        Text(
                          state.budget!.name,
                          style: TextStyle(color: AppColors.greySecondary),
                        ),
                      if (state.budget!.name.isEmpty)
                        Text(
                          'Requerido',
                          style: TextStyle(color: AppColors.red),
                        ),
                      SizedBox(width: 10),
                      if (Platform.isIOS) const Icon(CupertinoIcons.forward),
                    ],
                  ),
                  onTap: () => AppNavigator.navigateToEditBudgetNamePage(
                    context,
                    name: state.budget!.name,
                  ),
                ),
                if (Platform.isIOS) Divider(height: 2),
                ListTile(
                  leading: Icon(Icons.inbox),
                  minLeadingWidth: 2,
                  title: Text('Abreviatura'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        state.budget!.abbreviation ?? '',
                        style: TextStyle(color: AppColors.greySecondary),
                      ),
                      SizedBox(width: 10),
                      if (Platform.isIOS) const Icon(CupertinoIcons.forward),
                    ],
                  ),
                  onTap: () =>
                      AppNavigator.navigateToEditBudgetAbbreviationPage(
                    context,
                    abbreviation: state.budget!.abbreviation,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }
  }
}

Future<void> _showEditOptions(
  BuildContext context,
  EditBudgetScreenBloc bloc,
  EditBudgetScreenState state,
) async {
  await showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoActionSheet(
      actions: <CupertinoActionSheetAction>[
        CupertinoActionSheetAction(
          child: const Text('Cambiar color'),
          onPressed: () {
            Navigator.pop(context);
            _pickColor(context, bloc, state);
          },
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: const Text(
          'Cancelar',
          style: TextStyle(color: AppColors.red),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ),
  );
}

Future _pickColor(
  BuildContext context,
  EditBudgetScreenBloc bloc,
  EditBudgetScreenState state,
) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      title: Text(
        'Seleccionar color',
        textAlign: TextAlign.center,
      ),
      actions: [
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: Text('Cerrar'),
        )
      ],
      content: MaterialColorPicker(
        allowShades: false,
        selectedColor: Color(state.budget!.color),
        onMainColorChange: (colorSwatch) {
          bloc.add(ColorUpdated(colorSwatch!.value));
          Navigator.of(context).pop();
        },
      ),
    ),
  );
}

class _EditAbbreviationBottomSheet extends HookWidget {
  final Function(String) onSavePressed;
  final VoidCallback onCancelPressed;
  final EditBudgetScreenState state;

  const _EditAbbreviationBottomSheet({
    Key? key,
    required this.onSavePressed,
    required this.onCancelPressed,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textEditingController = useTextEditingController()
      ..text = state.budget!.abbreviation ?? '';
    return DraggableScrollableSheet(
      initialChildSize: 0.95,
      maxChildSize: 0.95,
      builder: (context, controller) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
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
                  },
                ),
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
                    onSavePressed(textEditingController.value.text.trim());
                    AppNavigator.navigateBack(context);
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
              maxLength: 3,
              decoration: InputDecoration(
                alignLabelWithHint: true,
                label: Center(
                  child: Text(
                    'Nueva abreviatura',
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

class _EditBalanceBottomSheet extends HookWidget {
  final Function(double) onSavePressed;
  final VoidCallback onCancelPressed;
  final EditBudgetScreenState state;

  const _EditBalanceBottomSheet({
    Key? key,
    required this.onSavePressed,
    required this.onCancelPressed,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CurrencyTextInputFormatter _formatter =
        CurrencyTextInputFormatter(symbol: '\$');
    final textEditingController = useTextEditingController()
      ..text = _formatter.format(state.budget!.balance.toString());

    return DraggableScrollableSheet(
      initialChildSize: 0.95,
      maxChildSize: 0.95,
      builder: (context, controller) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
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
                  },
                ),
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
                    final balance = _formatter.getUnformattedValue();
                    onSavePressed(balance.toDouble());
                    AppNavigator.navigateBack(context);
                  },
                ),
              ],
            ),
            SizedBox(height: 50),
            TextField(
              controller: textEditingController,
              inputFormatters: [_formatter],
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
                    'Nuevo balance',
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
                hintText: '\$${currency.format(0)}',
              ),
            )
          ],
        ),
      ),
    );
  }
}
