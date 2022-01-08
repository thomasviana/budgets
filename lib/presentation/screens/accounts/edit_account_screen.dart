import 'package:budgets/core/accounts/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

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
      String? dropdownValue = 'Cuenta bancaria';
      return Card(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20),
              Center(
                child: InkWell(
                  onTap: () {
                    // _showEditOptions(context, cubit, state);
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
              const SizedBox(height: 20),
              TextFormField(
                initialValue: state.account!.name,
                decoration: InputDecoration(labelText: 'Name'),
                keyboardType: TextInputType.name,
                onChanged: (name) => cubit.onNameChanged(name),
              ),
              const SizedBox(height: 20),
              DropdownButton<String>(
                hint: Text('Tipe de cuenta'),
                isExpanded: true,
                value: state.account!.typeAsString,
                icon: const Icon(Icons.arrow_drop_down),
                underline: Container(
                  height: 2,
                  color: Colors.grey[400],
                ),
                onChanged: (type) => cubit.onTypeChanged(type),
                items: <String>[
                  'Cuenta bancaria',
                  'Efectivo',
                  'Billetera',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: '\$${currency.format(state.account!.balance)}',
                decoration: InputDecoration(labelText: 'Balance'),
                keyboardType: TextInputType.number,
                onChanged: (balance) => cubit.onBalanceChanged(balance),
              ),
              const SizedBox(height: 20),
            ],
          ),
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
          child: const Text('Cambiar imagen'),
          onPressed: () {
            Navigator.pop(context);
            _pickImage(context, cubit);
          },
        ),
        CupertinoActionSheetAction(
          child: const Text('Edit color'),
          onPressed: () {
            Navigator.pop(context);
            _pickColor(context, cubit, state);
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

Future<void> _pickImage(
  BuildContext context,
  EditAccountScreenCubit cubit,
) async {
  final icon = await FlutterIconPicker.showIconPicker(
    context,
    title: Text(
      'Selecionar imagen',
      textAlign: TextAlign.center,
    ),
    iconPickerShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(16),
      ),
    ),
    searchHintText: 'Buscar',
    closeChild: Text('Cerrar'),
    iconSize: 30,
    iconColor: AppColors.black,
    iconPackModes: [IconPack.cupertino],
  );

  // if (icon != null) {
  //   cubit.onTypeUpdated(icon.codePoint);
  // }
}
