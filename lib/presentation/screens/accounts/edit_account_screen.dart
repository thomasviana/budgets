import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

import '../../../core/accounts/domain.dart';
import '../../resources/colors.dart';
import '../../resources/icons.dart';
import '../../resources/logos.dart';
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
              largeTitle:
                  Text(state.isEditMode ? 'Editar cuenta' : 'Crear cuenta'),
              previousPageTitle: 'Atras',
              trailing: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (state.account?.id.value != 'bank' &&
                      state.account?.id.value != 'cash' &&
                      state.account?.id.value != 'wallet')
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
                      if (state.account!.name.isEmpty) return;
                      cubit.onAccountSaved(isNewAccount: !state.isEditMode);
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
      NetworkImage? image;
      Icon? accountIcon;
      bool isImageAvailable;
      final account = state.account;

      if (account!.imageUrl != null) {
        isImageAvailable = true;
        image = NetworkImage(account.imageUrl!);
      } else {
        isImageAvailable = false;
        accountIcon = Icon(
          IconData(
            account.icon,
            fontFamily: 'MaterialIcons',
          ),
          size: 40,
          color: AppColors.white,
        );
      }
      return Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            Center(
              child: InkWell(
                onTap: () {
                  _showEditOptions(context, cubit, state);
                },
                child: Stack(
                  alignment: Alignment(1, 1.2),
                  children: [
                    CircleAvatar(
                      maxRadius: 40,
                      backgroundColor: Color(account.color),
                      backgroundImage: image,
                      child: isImageAvailable ? null : accountIcon,
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
                  Divider(height: 2),
                  ListTile(
                    leading: Icon(Icons.drive_file_rename_outline_outlined),
                    minLeadingWidth: 2,
                    title: Text('Nombre'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (state.account!.name.isNotEmpty)
                          Text(
                            state.account!.name,
                            style: TextStyle(color: AppColors.greySecondary),
                          ),
                        if (state.account!.name.isEmpty)
                          Text(
                            'Requerido',
                            style: TextStyle(color: Colors.red),
                          ),
                        SizedBox(width: 10),
                        Icon(Icons.arrow_forward_ios_rounded)
                      ],
                    ),
                    onTap: () {
                      showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                        context: context,
                        builder: (context) => _EditNameBottomSheet(
                          state: state,
                          onCancelPressed: () {},
                          onSavePressed: (name) {
                            cubit.onNameChanged(name);
                          },
                        ),
                      );
                    },
                  ),
                  Divider(height: 2),
                  ListTile(
                    leading: Icon(
                      IconData(
                        state.account!.icon,
                        fontFamily: 'MaterialIcons',
                      ),
                    ),
                    minLeadingWidth: 2,
                    title: Text('Tipo'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          state.account!.typeAsString,
                          style: TextStyle(color: AppColors.greySecondary),
                        ),
                        SizedBox(width: 10),
                        Icon(Icons.arrow_forward_ios_rounded)
                      ],
                    ),
                    onTap: () {
                      showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                        context: context,
                        builder: (context) => _EditTypeBottomSheet(
                          state: state,
                          onCancelPressed: () {},
                          onTypeSelected: (accountType) {
                            cubit.onTypeChanged(accountType);
                            AppNavigator.navigateBack(context);
                          },
                        ),
                      );
                    },
                  ),
                  Divider(height: 2),
                  ListTile(
                    leading: Icon(Icons.attach_money_rounded),
                    minLeadingWidth: 2,
                    title: Text('Balance'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '\$${currency.format(state.account!.balance)}',
                          style: TextStyle(color: AppColors.greySecondary),
                        ),
                        SizedBox(width: 10),
                        Icon(Icons.arrow_forward_ios_rounded)
                      ],
                    ),
                    onTap: () {
                      showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                        context: context,
                        builder: (context) => _EditBalanceBottomSheet(
                          state: state,
                          onCancelPressed: () {},
                          onSavePressed: (balance) {
                            cubit.onBalanceChanged(balance);
                          },
                        ),
                      );
                    },
                  ),
                  Divider(height: 2),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }
}

Future<void> _showEditOptions(
  BuildContext context,
  EditAccountScreenCubit cubit,
  EditAccountScreenState state,
) async {
  await showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoActionSheet(
      actions: <CupertinoActionSheetAction>[
        CupertinoActionSheetAction(
          child: const Text('Cambiar color'),
          onPressed: () {
            Navigator.pop(context);
            _pickColor(context, cubit, state);
          },
        ),
        CupertinoActionSheetAction(
          child: const Text('Seleccionar logo'),
          onPressed: () {
            Navigator.pop(context);
            _pickImage(context, cubit, state);
          },
        ),
        if (state.account!.imageUrl != null)
          CupertinoActionSheetAction(
            child: Text(
              'Eliminar logo',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
              cubit.onLogoDeleted();
            },
          )
      ],
      cancelButton: CupertinoActionSheetAction(
        child: const Text(
          'Cancelar',
          style: TextStyle(color: Colors.red),
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
  EditAccountScreenCubit cubit,
  EditAccountScreenState state,
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
        selectedColor: Color(state.account!.color),
        onMainColorChange: (colorSwatch) {
          cubit.onColorUpdated(colorSwatch!.value).then(
                (_) => Navigator.of(context).pop(),
              );
        },
      ),
    ),
  );
}

Future _pickImage(
  BuildContext context,
  EditAccountScreenCubit cubit,
  EditAccountScreenState state,
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
        'Seleccionar logo',
        textAlign: TextAlign.center,
      ),
      actions: [
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: Text('Cerrar'),
        )
      ],
      content: SizedBox(
        height: 300,
        width: MediaQuery.of(context).size.width * .66,
        child: GridView.count(
          crossAxisCount: 4,
          padding: const EdgeInsets.all(6.0),
          mainAxisSpacing: 20.0,
          crossAxisSpacing: 20.0,
          children: <String>[
            AccountDefaultLogos.bancolombia,
            AccountDefaultLogos.davivienda,
            AccountDefaultLogos.nuBank,
            AccountDefaultLogos.bbva,
            AccountDefaultLogos.falabella,
            AccountDefaultLogos.bancoDeBogota,
            AccountDefaultLogos.bancoDeOccidente,
            AccountDefaultLogos.avvillas,
            AccountDefaultLogos.scotiabank,
            AccountDefaultLogos.cajaSocial,
            AccountDefaultLogos.bankOfAmerica,
            AccountDefaultLogos.chase,
            AccountDefaultLogos.wellsFargo,
            AccountDefaultLogos.cash,
            AccountDefaultLogos.binance,
            AccountDefaultLogos.metamask,
          ]
              .map(
                (url) => InkWell(
                  onTap: () {
                    cubit.onLogoSelected(url);
                    Navigator.of(context).pop();
                  },
                  child: GridTile(
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(url),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    ),
  );
}

class _EditNameBottomSheet extends HookWidget {
  final Function(String) onSavePressed;
  final VoidCallback onCancelPressed;
  final EditAccountScreenState state;

  const _EditNameBottomSheet({
    Key? key,
    required this.onSavePressed,
    required this.onCancelPressed,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textEditingController = useTextEditingController()
      ..text = state.account!.name;
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

class _EditTypeBottomSheet extends StatelessWidget {
  final Function(AccountType) onTypeSelected;
  final VoidCallback onCancelPressed;
  final EditAccountScreenState state;

  const _EditTypeBottomSheet({
    Key? key,
    required this.onTypeSelected,
    required this.onCancelPressed,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.95,
      maxChildSize: 0.95,
      builder: (context, controller) => Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Stack(
                alignment: FractionalOffset.center,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      child: const Text('Cancelar'),
                      onPressed: () {
                        onCancelPressed();
                        AppNavigator.navigateBack(context);
                      },
                    ),
                  ),
                  const Text(
                    'Editar cuenta',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
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
                'TIPOS DE CUENTA',
                style: TextStyle(fontWeight: FontWeight.w200, fontSize: 12),
                textAlign: TextAlign.start,
              ),
            ),
            Divider(height: 2),
            ListTile(
              leading: Icon(AppIcons.bank),
              minLeadingWidth: 2,
              title: Text('Cuenta bancaria'),
              trailing: state.account!.type == AccountType.bank
                  ? Icon(Icons.check, color: AppColors.primaryColor)
                  : null,
              onTap: () => onTypeSelected(AccountType.bank),
            ),
            Divider(height: 2),
            ListTile(
              leading: Icon(AppIcons.cash),
              minLeadingWidth: 2,
              title: Text('Efectivo'),
              trailing: state.account!.type == AccountType.cash
                  ? Icon(Icons.check, color: AppColors.primaryColor)
                  : null,
              onTap: () => onTypeSelected(AccountType.cash),
            ),
            Divider(height: 2),
            ListTile(
              leading: Icon(AppIcons.wallet),
              minLeadingWidth: 2,
              title: Text('Billetera'),
              trailing: state.account!.type == AccountType.wallet
                  ? Icon(Icons.check, color: AppColors.primaryColor)
                  : null,
              onTap: () => onTypeSelected(AccountType.wallet),
            ),
            Divider(height: 2),
          ],
        ),
      ),
    );
  }
}

class _EditBalanceBottomSheet extends HookWidget {
  final Function(double) onSavePressed;
  final VoidCallback onCancelPressed;
  final EditAccountScreenState state;

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
      ..text = _formatter.format(state.account!.balance.toString());

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
